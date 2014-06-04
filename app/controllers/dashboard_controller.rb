class DashboardController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
  	respond_to do |format|	 	
			format.js	
	end
  end
  
  def save
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"]

  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end

  def show_attributes_trend
  	@Project = Project.find_by(:id=>params["id"])
  	@index = params["index"].to_i
  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end
 
end
