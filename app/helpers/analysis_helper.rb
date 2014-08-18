module AnalysisHelper

	def get_attributes_impact project,release
		average_data= []
		optimistic_data = []
		pessimistic_data = []

		get_all_series_data project, average_data, optimistic_data, pessimistic_data, release
		
		serises = []
		positive_series = []
		negetive_series = []
		positive_series_percentage = []
		negetive_series_percentage = []
		negetive_series = []

		series_index  = 0

		project.rattributes.each do |ra|
			attribute_satisfaction_data = ra.get_satisfaction_over_time project, release
			positive_impact_count = 0.0
			positive_impact_sum = 0.0
			negetive_impact_count = 0.0
			negetive_impact_sum = 0.0
			i=0

			average_data.each do |p|
			
				q = attribute_satisfaction_data[i]
					if q[1] < p[1] 
						negetive_impact_count += 1
						negetive_impact_sum += (p[1]-q[1])*ra.weight
					elsif q[1] > p[1] 
						positive_impact_count += 1
						positive_impact_sum += (q[1]-p[1])*ra.weight
						
					end
				i+=1
			end

			positive_series << (positive_impact_count==0 ? 0 : ((positive_impact_sum/positive_impact_count)).round(2))
			negetive_series << (negetive_impact_count==0 ? 0 : ((negetive_impact_sum/negetive_impact_count)).round(2))
			# positive_series << (positive_impact_count==0 ? 0 : ((positive_impact_sum/positive_impact_count)*ra.weight).round(2))
			# negetive_series << (negetive_impact_count==0 ? 0 : ((negetive_impact_sum/negetive_impact_count)*ra.weight).round(2))
			positive_series_percentage << positive_impact_count
			negetive_series_percentage << negetive_impact_count


		end
		serises << negetive_series
		serises << positive_series
		serises << negetive_series_percentage
		serises << positive_series_percentage
		logger.debug serises
		return serises
	end


	def get_positive_negetive_chart overall_data, attribute_data, positive_series,negetive_series, weight

		#positive_series = []
		#negetive_series = []

		i=0
		overall_data.each do |p|
			q = attribute_data[i]
			
			d = -(p[1]-q[1])*weight*5

			 if p[1] >= q[1]
			 	negetive_series << [p[0],p[1], p[1] + d]
			 	positive_series << [p[0],p[1],p[1]]
			 elsif p[1] <= q[1]
			 	positive_series << [p[0],p[1] + d,p[1]]
			 	negetive_series << [p[0],p[1],p[1]]
			 		
			 end 

			i+=1
		end

	end

	def get_MMRE actual, predicted, k

		total_error = 0.0

		(0..predicted.length-2).each do |i|
			a = actual[k+i]
			p = predicted[i]
			total_error += ((a[1]-p[1]).abs)/a[1]
		end
		return ((total_error/(predicted.length-2))*100).round(2)
	end

	def formate_date data, start_date
		date = start_date

		data.each do |d|
			date += 7.days
			d[0] = date.to_datetime.strftime('%Q').to_i
			
		end

		return data
	end

	def get_projected_RR_series data, a, b, h, lt0, bt0

		projected_series = []


		(1..data.length).each do |i|

			d = data[i-1]

			logger.debug "Shawn1: #{d}"
			lt = a*d[1] + (1-a)*(lt0 + bt0)
			bt = b*(lt-lt0) + (1-b)*bt0

			yth = lt + bt

			lt0 = lt
			bt0 = bt

			projected_series << [data[i-1][0]+7, yth.round(2)]
		end

		(2..h).each do |i|
			last_date = data[data.length-1][0]
			last_date += 7
			projected_series << [last_date, (lt0 + i*bt0).round(3)]
		end

		logger.debug "Shawn: #{projected_series}"
		return projected_series

	end

end
