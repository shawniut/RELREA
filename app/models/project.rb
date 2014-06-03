class Project < ActiveRecord::Base

	include ReadinessHelper
	include MembershipFunctionHelper

	has_many :rattributes,   autosave: true
	has_one :info, :class_name => 'Info'
	accepts_nested_attributes_for :rattributes,  :allow_destroy => true 


	
	def get_release_readiness start_date, end_date

		return release_readiness self, start_date, end_date
	end

	def get_all_readiness_values
		start_date = self.info.start_date
		end_dates = Value.where(:rattribute_id=>self.rattributes[0].id).uniq.pluck(:end_date)
		data = []
		end_dates.each do |end_date|

			r = get_release_readiness start_date, end_date
			data << [(end_date-start_date).to_i, r.round(2)]
		end
		return data.to_json
	end

	def get_attributes_names

		data = []

		self.rattributes.each do |r|

			data << r.metric.name

		end

		return data

	end

	def get_satisfaction_level_by_date days
		start_date = self.info.start_date
		end_dates = Value.where(:rattribute_id=>self.rattributes[0].id).uniq.pluck(:end_date)
		

		specific_date = nil
		data = []
		end_dates.each do |end_date|
			if (end_date-start_date).to_i == days
				specific_date = end_date
			end
		end


		self.rattributes.each do |r|
			metric_value = Value.where(:rattribute_id=>r.id, :start_date=>start_date, :end_date=>specific_date)[0].mvalue
			satisfaction_level = get_satisfaction_degree r.mfunction.parameter, metric_value, r.mfunction.name
			data << satisfaction_level.to_f
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
	
end
