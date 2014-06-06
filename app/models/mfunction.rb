class Mfunction < ActiveRecord::Base

	def get_parameter_as_array
		array = parameter.split(":")
		data = nil
		if name == "Shape 1"
			last_x = array[1].to_f + (array[1].to_f/4)
			data = [[0,0],[array[0].to_f,0],[array[1].to_f,1],[last_x,1]]
		elsif name == "Shape 2"
			last_x = array[1].to_f + (array[1].to_f/4)
			data = [[0,1],[array[0].to_f,0],[array[1].to_f,1],[last_x,0]]
		end
		return data
	end

	def get_parameter_names
		if name == "Shape 1"
			return ["p","q"]
		elsif name == "Shape 2"
			return ["p","q","r","s"]
		end
	end
	
	def get_parameter_as_array_without_max_min
		array = parameter.split(":")
		data = nil
		if name == "Shape 1"
			data = [array[0].to_f,array[1].to_f]
		elsif name == "Shape 2"
			data = [array[0].to_f,array[1].to_f]
		end
		return data
	end

end
