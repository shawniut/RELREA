module DashboardHelper

	def get_data
		#return data2 = [[0,0],[0.1,0],[0.3,1],[0.4,1]]
		Project.find_by(:id=>23).get_all_readiness_values
	end

	def get_all_series_data  project, average_data, optimistic_data, pessimistic_data, release
		start_date = release.start_date
		#logger.debug "Start date : #{start_date}"
		end_dates = Value.where(:rattribute_id=>project.rattributes[0].id, :start_date=>start_date).uniq.pluck(:end_date)
		#logger.debug "End date : #{end_dates}"
		end_dates.each do |end_date|

			rattributes = project.get_attributes_with_owa_weights start_date, end_date
			
			average_radiness = get_average_readiness rattributes
			optimistic_radiness = get_optimistic_readiness rattributes
			pessimistic_radiness = get_pessimistic_readiness rattributes
			days = (end_date-start_date).to_i
			
			average_data << [days, average_radiness.round(2)]
			optimistic_data << [days, optimistic_radiness.round(2)]
			pessimistic_data << [days, pessimistic_radiness.round(2)]
		end
		return average_data.to_json

	end

	def get_pessimistic_series_data project

	end

	def get_optimistic_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.optimistic_weight)
		end
		return readiness
	end

	def get_pessimistic_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.pessimistic_weight)
		end
		return readiness
	end

	def get_average_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.weight)
		end
		return readiness
	end


end
