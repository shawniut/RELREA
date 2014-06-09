class Release < ActiveRecord::Base
	include GitmetricHelper
	def get_pulls
		get_pull_request_completion_rate
	end

	def has_value rattributes
		flag = false
		rattributes.each do |r|	
			flag =  r.values.where(:start_date => self.start_date).any?
		end
		return flag
	end

	def has_day rattributes, days
		flag = false
		rattributes.each do |r|	
			values = r.values.where(:start_date => self.start_date)
			flag = false
			values.each do |v|
				if (v.end_date - v.start_date).to_i == days
					flag = true
				end 
			end
		end

		return flag

	end
end
