module ReadinessHelper

	include MembershipFunctionHelper


	#this function calculates release readiness based on weighted average
	def release_readiness project, start_date, end_date

		rattributes = project.rattributes

		readiness = 0

		rattributes.each do |r|

			metric_value = r.values.where(:start_date => start_date, :end_date=> end_date)[0].mvalue
			puts metric_value
			puts r.mfunction.parameter
			puts r.mfunction.parameter
			puts r.mfunction.name
			puts r.weight

			satisfaction_degree =  get_satisfaction_degree r.mfunction.parameter, metric_value, r.mfunction.name

			readiness += (r.weight * satisfaction_degree) 

		end

		return readiness

	end

end