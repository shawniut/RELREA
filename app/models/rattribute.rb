class Rattribute < ActiveRecord::Base
	include GitmetricHelper

	belongs_to :project, autosave:true
	belongs_to :metric, :class_name => 'Dataservice::Metric'
	belongs_to :mfunction, :class_name => 'Mfunction'
	has_many :values, :class_name => 'Value'

	def save_value(value)
		v = find_value(value)
	  if  v != nil
	    v.mvalue = value.mvalue
	    v.save
	    logger.debug "shawn"
	    logger.debug v.mvalue
	  else
	  	logger.debug "shawn-create"
	    logger.debug value.mvalue
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

	

end
