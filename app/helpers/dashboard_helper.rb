module DashboardHelper

	def get_data
		#return data2 = [[0,0],[0.1,0],[0.3,1],[0.4,1]]
		Project.find_by(:id=>23).get_all_readiness_values
	end

end
