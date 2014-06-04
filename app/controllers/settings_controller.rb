class SettingsController < ApplicationController

	def index
		@Project = Project.find_by(:id=>params["id"])
	  	respond_to do |format|	 	
				format.js	
		end	
	end
end
