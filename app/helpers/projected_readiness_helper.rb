module ProjectedReadinessHelper

	def get_projected_series data, days
		logger.debug days
		p= data

		weights = get_weights p.length

		x = days
		sum = 0
		(0..(p.length-2)).each do |i|
			
			y1= p[i][1]
			y2= p[i+1][1]

			x1= p[i][0]
			x2= p[i+1][0]

			m =  (y2-y1)/(x2-x1)
			y= (m*(x-x2) + y2)

			if y > 1
				y = 1
			elsif y <0
				y=0
			end

			logger.debug y

			sum += y*weights[i]
		end

		projected_series = []
		projected_series << p[p.length-1]
		projected_series << [x,sum.round(2)]

		return projected_series
		
	end

	def get_weights length

		sum = 0.0
		temp_weights = []

		(1..length-1).each do |i|
			w = 1.to_f/(i**0.6).to_f
			sum += w
			temp_weights << w
		end
		weights = []
		(1..length-1).each do |i|
			

			weights << (temp_weights[i-1]/sum).round(4)
		end		
		return weights.reverse
	end
end
