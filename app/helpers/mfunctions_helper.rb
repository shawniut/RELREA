module MfunctionsHelper

	def get_past_release_data ra, releases

		data = []
		releases.each do |r|
			logger.debug "Shawn#{r}"
			duration = (r.date-r.start_date).to_i
			values = ra.values.where(:start_date => r.start_date)
			if values.any?
				values = values.sort(){|v1,v2| v1.mvalue <=> v2.mvalue}
				data << [r.name, duration, values[0].mvalue, values[values.length-1].mvalue]
			end
		end
		return data

	end
end
