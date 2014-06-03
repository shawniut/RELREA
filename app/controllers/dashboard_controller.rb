class DashboardController < ApplicationController
  def index
  	@data2 = [[0,0],[0.1,0],[0.3,1],[0.4,1]]
  end
  
  def save
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"]

  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js
			
	end

  end
 
end
