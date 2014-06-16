module DashboardHelper

	def get_data
		#return data2 = [[0,0],[0.1,0],[0.3,1],[0.4,1]]
		Project.find_by(:id=>23).get_all_readiness_values
	end

	def get_all_series_data  project, average_data, optimistic_data, pessimistic_data, release
		start_date = release.start_date
		#logger.debug "Start date : #{start_date}"
		end_dates = Value.where(:rattribute_id=>project.rattributes[0].id, :start_date=>start_date).order(:end_date).uniq.pluck(:end_date)
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

		logger.debug average_data
		
		average_data = average_data.sort_by { |e| e[0] }
		optimistic_data = optimistic_data.sort_by { |e| e[0] }
		pessimistic_data = pessimistic_data.sort_by { |e| e[0] }
		
		logger.debug average_data

		return average_data.to_json

	end

	def get_moving_average_series data, k

		moving_average_series = []
		interval = data[1][0] - data[0][0]


		(k..data.length).each do |i|
			days = data[i-1][0]
			moving_average_rr = 0.0
			(i-k..i-1).each do |j|
				moving_average_rr += data[j][1]

			end
			moving_average_series << [days+interval,(moving_average_rr/k).round(2)]
		end

		return moving_average_series

	end

	# def check_deviation_with_moving_average_and_formate_readiness_series readiness_data, moving_average_data, k

	# 	(k..moving_average_data.length-2).each do |i|
	# 		if readiness_data[i][1]< moving_average_data[i][1]

	# 			readiness_data[i][1] = {y: + readiness_data[i][1] , color: 'red'}
	# 		end
	# 	end

	# 	return readiness_data
	# end

	def get_all_series_data_average  project,release
		average_data = []
		start_date = release.start_date
		#logger.debug "Start date : #{start_date}"
		end_dates = Value.where(:rattribute_id=>project.rattributes[0].id, :start_date=>start_date).order(:end_date).uniq.pluck(:end_date)
		#logger.debug "End date : #{end_dates}"
		end_dates.each do |end_date|

			rattributes = project.get_attributes_with_owa_weights start_date, end_date
			
			average_radiness = get_average_readiness rattributes
			days = (end_date-start_date).to_i
			
			average_data << [days, average_radiness.round(2)]
			
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

	def get_color_shade n

			step_size = 196/n
			red = 0
			green = 200
			
			output = []	

			(1..n).each do |i|
			    red += step_size;
			    output << [red, green, 47]  
			end
			return output
	end

	def get_green_color n
			red = 0
			green = 200
			
			output = []	

			(1..n).each do |i|
			    output << [red, green, 47]  
			end
			return output
	end


end
