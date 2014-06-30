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

		#logger.debug average_data
		
		average_data = average_data.sort_by { |e| e[0] }
		optimistic_data = optimistic_data.sort_by { |e| e[0] }
		pessimistic_data = pessimistic_data.sort_by { |e| e[0] }
		
		#logger.debug average_data

		return average_data

	end

	def get_all_series_data_with_various_decision_strategy  project,release
		start_date = release.start_date
		end_dates = Value.where(:rattribute_id=>project.rattributes[0].id, :start_date=>start_date).order(:end_date).uniq.pluck(:end_date)
		average_data = []
		optimistic_data = []
		pessimistic_data = []
		moderately_pessimistic_data = []
		moderately_optimistic_data = []

		end_dates.each do |end_date|
			rattributes = project.get_attributes_with_owa_weights start_date, end_date
			average_radiness = get_average_readiness rattributes
			optimistic_radiness = get_optimistic_readiness rattributes
			pessimistic_radiness = get_pessimistic_readiness rattributes
			moderately_optimistic_readiness = get_moderately_optimistic_readiness rattributes
			moderately_pessimistic_readiness = get_moderately_pessimistic_readiness rattributes
			days = (end_date-start_date).to_i
			
			average_data << [days, average_radiness.round(2)]
			optimistic_data << [days, optimistic_radiness.round(2)]
			pessimistic_data << [days, pessimistic_radiness.round(2)]
			moderately_pessimistic_data << [days, moderately_pessimistic_readiness.round(2)]
			moderately_optimistic_data << [days, moderately_optimistic_readiness.round(2)]				
		end
		
		average_data = average_data.sort_by { |e| e[0] }
		optimistic_data = optimistic_data.sort_by { |e| e[0] }
		pessimistic_data = pessimistic_data.sort_by { |e| e[0] }
		moderately_pessimistic_data = moderately_pessimistic_data.sort_by { |e| e[0] }
		moderately_optimistic_data = moderately_optimistic_data.sort_by { |e| e[0] }
		

		return average_data, optimistic_data, moderately_optimistic_data, pessimistic_data, moderately_pessimistic_data

	end

	def get_overall_moving_average project, release, k

		overall_moving_average_seris = []
		attribute_moving_averages = []
		data_length = 0
		project.rattributes.each do |ra|
			 attribute_moving_averages << (get_moving_average_series (ra.get_satisfaction_over_time @Project, release),k)
			 ength = 0
		end
		(0..attribute_moving_averages[0].length-1).each do |j|
			i=0
			overall_projected_rediness = 0
			project.rattributes.each do |ra|
				 individual_attribute_moving_average = attribute_moving_averages[i]
				 i+=1
				 overall_projected_rediness += (individual_attribute_moving_average[j][1]*ra.weight)
			end
			overall_moving_average_seris << [attribute_moving_averages[0][j][0],overall_projected_rediness.round(2)]
		end

		return overall_moving_average_seris
	end

	def get_moving_average_series data, k

		moving_average_series = []
		weights = get_MA_weights k+1
		logger.debug "weights #{weights}"
		interval = data[1][0] - data[0][0]
		(k..data.length).each do |i|
			days = data[i-1][0]
			moving_average_rr = 0.0
			index = 0
			(i-k..i-1).each do |j|
				# moving_average_rr += data[j][1]*weights[index]
				moving_average_rr += data[j][1]*weights[index]
				index+=1
			end
			moving_average_series << [days+interval,(moving_average_rr).round(2)]
		end

		return moving_average_series

	end

	def get_MA_weights length

		sum = 0.0
		temp_weights = []

		(1..length-1).each do |i|
			w = 1.to_f/(i*1.5).to_f
			sum += w
			temp_weights << w
		end
		weights = []
		(1..length-1).each do |i|
			

			weights << (temp_weights[i-1]/sum).round(4)
		end		
		return weights.reverse
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

	

	def get_optimistic_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.optimistic_weight)
		end
		return readiness
	end

	def get_moderately_optimistic_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.moderately_optimistic_weight)
		end
		return readiness
	end

	def get_moderately_pessimistic_readiness rattributes
		readiness = 0.0
		rattributes.each do |r|
			readiness += (r.satisfaction_degree*r.moderately_pessimistic_weight)
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
