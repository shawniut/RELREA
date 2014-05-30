module MembershipFunctionHelper

	def index value
		parameters = "10:20:"
		puts shape2(parameters, value)
	end

	def get_satisfaction_degree parameters, metric_value, shape

		if shape == "Shape 1"
			return shape1 parameters, metric_value
		elsif shape == "Shape 2"
			return shape2 parameters, metric_value
		end

	end

	def shape1 parameters, metric_value

		parameter_values = parameters.split(":");

		x = metric_value.to_f
		p = parameter_values[0].to_f 
		q =  parameter_values[1].to_f 

		if x <= p
			return 0;
		
		elsif x > p and x<q

			return (x-p)/(q-p)
		else
			return 1
		end

	end

	def shape2 parameters, metric_value

		parameter_values = parameters.split(":");

		x = metric_value.to_f
		p = parameter_values[0].to_f 
		q =  parameter_values[1].to_f 

		if x <= p
			return 1;
		
		elsif x > p and x<q

			return (q-x)/(q-p)
		else
			return 0
		end

	end

end 


