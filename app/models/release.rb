class Release < ActiveRecord::Base
	include GitmetricHelper
	def get_pulls
		get_pull_request_completion_rate
	end
end
