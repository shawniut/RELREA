class ReleaseToReleaseController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])

  	respond_to do |format|	 	
			format.js	
	end
  end

  def load_satisfaction_by_day
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"].to_i

  	respond_to do |format|	 	
			format.js	
	end
  end
end
