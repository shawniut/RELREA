class Rattribute < ActiveRecord::Base
	include GitmetricHelper
	include MembershipFunctionHelper

	attr_accessor :satisfaction_degree,:optimistic_weight,:pessimistic_weight

	belongs_to :project, autosave:true
	belongs_to :metric, :class_name => 'Dataservice::Metric'
	belongs_to :mfunction, :class_name => 'Mfunction'
	has_many :values, :class_name => 'Value'

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

	def get_satisfaction_over_time
		data = []
		self.values.each do|v|
			
			satisfaction_level = get_satisfaction_degree self.mfunction.parameter, v.mvalue, self.mfunction.name
			days = (v.end_date - v.start_date).to_i
			data << [days, satisfaction_level.round(2)]
		end
		return data
	end

	

end
