module ReadinessHelper

	include MembershipFunctionHelper


	#this function calculates release readiness based on weighted average
	def release_readiness project, start_date, end_date

		rattributes = project.rattributes

		readiness = 0

		rattributes.each do |r|
			metric_value = r.values.where(:start_date => start_date, :end_date=> end_date)[0].mvalue
			satisfaction_degree =  get_satisfaction_degree r.mfunction.parameter, metric_value, r.mfunction.name
			readiness += (r.weight * satisfaction_degree) 
		end

		return readiness

	end



	def set_owa_weights rattributes

		rattributes = rattributes.sort!{|r1,r2| [r2.satisfaction_degree,r2.weight] <=> [r1.satisfaction_degree, r1.weight]}
		total_weight = get_total_weight rattributes
		
		pessimistic_alpha = 4
		moderately_pessimistic_alpha = 2	
		moderately_optimistic_alpha = 0.6
		optimistic_alpha = 0.3


		i = 1
		rattributes.each do |r|
			#this equation comes from the AHP paper of wager
			a = (get_weight_upto_i rattributes, i / total_weight)**pessimistic_alpha
			b = (get_weight_upto_i rattributes, (i-1) / total_weight)**pessimistic_alpha
			r.pessimistic_weight = (a-b).round(3) 
			i +=1
		end	

		i = 1
		rattributes.each do |r|
			#this equation comes from the AHP paper of wager
			a = (get_weight_upto_i rattributes, i / total_weight)**moderately_pessimistic_alpha
			b = (get_weight_upto_i rattributes, (i-1) / total_weight)**moderately_pessimistic_alpha
			r.moderately_pessimistic_weight = (a-b).round(3) 
			i +=1
		end	

		i = 1
		rattributes.each do |r|
			#this equation comes from the AHP paper of wager
			a = (get_weight_upto_i rattributes, i / total_weight)**moderately_optimistic_alpha
			b = (get_weight_upto_i rattributes, (i-1) / total_weight)**moderately_optimistic_alpha
			r.moderately_optimistic_weight = (a-b).round(3)  
			i +=1
		end	

		i = 1
		rattributes.each do |r|
			#this equation comes from the AHP paper of wager
			a = (get_weight_upto_i rattributes, i / total_weight)**optimistic_alpha
			b = (get_weight_upto_i rattributes, (i-1) / total_weight)**optimistic_alpha
			r.optimistic_weight = (a-b).round(3)  
			i +=1
		end	

	end

	def get_weight_upto_i rattributes, i
		total_weight = 0.0
		(1..i).each do |j|
			total_weight += rattributes[j-1].weight		
		end	
		total_weight.round(2)
		return total_weight

	end

	def get_total_weight rattributes

		total_weight = 0.0

		rattributes.each do |r|
			total_weight += r.weight
		end	
		return total_weight.round(2)
	end

end