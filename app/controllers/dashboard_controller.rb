class DashboardController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []

  	respond_to do |format|	 	
			format.js	
	end
  end
  
  def save
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"].to_i

    @series_name = params["series_name"]
    release = @Project.releases.where(:name=>'next')[0]
    
    @rattributes = @Project.get_attributes_with_owa_weights release.start_date, @Project.get_end_date( @days)

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
