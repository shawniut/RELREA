class Rattribute < ActiveRecord::Base
	include GitmetricHelper
	include MembershipFunctionHelper

	attr_accessor :satisfaction_degree,:optimistic_weight,:pessimistic_weight

	belongs_to :project, autosave:true
	belongs_to :metric, :class_name => 'Dataservice::Metric'
	belongs_to :raw_file, :class_name => 'RawFile', :dependent => :destroy
	belongs_to :mfunction, :class_name => 'Mfunction', :dependent => :destroy
	has_many :values, :class_name => 'Value', :dependent => :destroy

	def save_value(value)
		v = find_value(value)
	  if  v != nil
	    v.mvalue = value.mvalue
	    v.save
	  else
	    self.values << value
	    self.save
	    
	  end
	end

	def find_value(value)
		self.values.each do|v|
			if v.start_date == value.start_date and v.end_date == value.end_date
				return v
			end
		end
		return nil
	end

	def get_satisfaction_over_time project, release
		
		data = []
		self.values.where(:start_date=>release.start_date).each do|v|
			
			satisfaction_level = get_satisfaction_degree self.mfunction.parameter, v.mvalue, self.mfunction.name
			days = (v.end_date - v.start_date).to_i
			data << [days, satisfaction_level.round(2)]
		end
		return data
	end

	def download_and_save_json_file repo, user
		if self.metric.name == "Feature completion rate"
       		output = get_issues_from_github user, repo
       	elsif self.metric.name == "Features Implemented"
         	output = get_issues_from_github user, repo
      	elsif self.metric.name == "Code churn rate"
        	output = get_code_churn_from_github user, repo
		elsif self.metric.name == "Defect find rate"
      		output = get_issues_from_github user, repo
      	elsif self.metric.name == "Bug fix rate"
        	output = get_issues_from_github user, repo
      	elsif self.metric.name == "Pull-request Completion Rate"
        	output = get_pull_requests_from_github user, repo
      	end

      	raw_file = RawFile.new :file=>output, :source=>"Github"
  		self.raw_file = raw_file
  		self.save
  		logger.debug "Shawn"

	end

	def get_issues_from_github user, repo
		logger.debug "https://api.github.com/search/issues?per_page=1000&q=label:"+label+"+user:"+user+"+repo:"+repo
  		return JSON.parse(open("https://api.github.com/search/issues?per_page=1000&q=label:"+label+"+user:"+user+"+repo:"+repo, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read)
	end

	def get_pull_requests_from_github user, repo
		logger.debug "https://api.github.com/repos/"+user+"/"+repo+"/pulls?per_page=1000&state=all"

		return JSON.parse(open("https://api.github.com/repos/"+user+"/"+repo+"/pulls?per_page=1000&state=all", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read)
	end

	def get_code_churn_from_github user, repo
		logger.debug "https://api.github.com/repos/"+user+"/"+repo+"/stats/code_frequency"
		return JSON.parse(open("https://api.github.com/repos/"+user+"/"+repo+"/stats/code_frequency", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read)
	end

end
