module ProjectsHelper
	def is_project_ok? p

		if (p.info != nil) and (p.rattributes.any?) and (has_mf p) and (has_weights p) and (p.releases.any?)
			return true
		else
			return false
		end


	end
end
