module SettingsHelper

	def has_weights project
		rattributes = project.rattributes
		if(rattributes.any? == false)
			return false
		end

		rattributes.each do |r|
			if r.weight == 0.0 or r.weight == nil
				return false
			end
		end

		return true

	end

	def has_mf project
		rattributes = project.rattributes
		if(rattributes.any? == false)
			return false
		end
		rattributes.each do |r|
			if r.mfunction == nil
				return false
			end
		end
		return true
	end
end
