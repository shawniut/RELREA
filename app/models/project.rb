class Project < ActiveRecord::Base

	include ReadinessHelper

	has_many :rattributes,   autosave: true
	has_one :info, :class_name => 'Info'
	accepts_nested_attributes_for :rattributes,  :allow_destroy => true 


	
	def get_release_readiness start_date, end_date

		return release_readiness self, start_date, end_date
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
