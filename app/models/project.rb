class Project < ActiveRecord::Base

	include ReadinessHelper
	include MembershipFunctionHelper
	include GitmetricHelper

	has_many :rattributes,   autosave: true, :dependent => :destroy
	has_many :releases,   autosave: true, :dependent => :destroy
	has_one :info, :class_name => 'Info', :dependent => :destroy
	has_one :jira, :class_name => 'Jira', :dependent => :destroy
	validates_presence_of :name, :repo, :user

	def get_attributes_with_owa_weights start_date, end_date
		rattributes = self.rattributes
		#setting the satisfaction degree to the readiness attributes

		rattributes.each do |r|
			metric_value = r.values.where(:start_date => start_date, :end_date=> end_date)[0].mvalue
			satisfaction_degree =  get_satisfaction_degree r.mfunction.parameter, metric_value, r.mfunction.name
			r.satisfaction_degree = satisfaction_degree
		end
		return set_owa_weights rattributes
	end
	
	def get_release_readiness start_date, end_date

		return release_readiness self, start_date, end_date
	end

	def get_all_readiness_values
		release = self.releases.where(:name=>'next')[0]
		start_date = release.start_date
		#logger.debug "Start date : #{start_date}"
		end_dates = Value.where(:rattribute_id=>self.rattributes[0].id, :start_date=>start_date).uniq.pluck(:end_date)
		#logger.debug "End date : #{end_dates}"
		data = []
		end_dates.each do |end_date|

			r = get_release_readiness start_date, end_date
			data << [(end_date-start_date).to_i, r.round(2)]
		end
		return data.to_json
	end

	def get_attributes_names	
		start_date = self.info.start_date
		data = []
		self.rattributes.each do |r|
			data << r.metric.ra + "(#{r.metric.code})"
		end
		return data
	end

	def get_end_date days, release
		start_date = release.start_date
		#logger.debug "Start date : #{start_date}"
		end_dates = Value.where(:rattribute_id=>self.rattributes[0].id, :start_date=>start_date).uniq.pluck(:end_date)
		#logger.debug "End date : #{end_dates}"
		end_dates.each do |end_date|
			if (end_date-start_date).to_i == days
				return end_date
			end
		end
		return nil
	end

	def get_satisfaction_level_by_date days,release
		
		start_date = release.start_date
		logger.debug "Start date : #{start_date}"
		specific_date = get_end_date days, release
		logger.debug "Specific date : #{specific_date}"
		data = []
		
		self.rattributes.each do |r|
			metric_value = Value.where(:rattribute_id=>r.id, :start_date=>start_date, :end_date=>specific_date)[0].mvalue
			satisfaction_level = get_satisfaction_degree r.mfunction.parameter, metric_value, r.mfunction.name
			data << satisfaction_level.to_f.round(2	)
		end
		return data.to_json
	end

	def is_metric_exist metric_id
		self.rattributes.each do |r|
			if r.metric.id == metric_id
				return true
			end
		end
		return false
	end

	def raw_files_downloaded?

		self.rattributes.each do |r|

			if(r.raw_file == nil)
				return false
			end
		end
		return true

	end



	def get_release_info 
		get_releases self.user, self.repo, self
	end

	def save_release(release)
		r = find_release(release)
	  if  r != nil
	    r.name = release.name
	    r.date = release.date
	    r.start_date = release.start_date
	    r.save
	    return false
	  else
	    self.releases << release
	    self.save
	    return true
	  end
	end

	def find_release(release)
		self.releases.each do|r|
			if r.date == release.date and r.start_date == release.start_date
				return r
			end
		end
		return nil
	end
	
end
