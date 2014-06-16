class DashboardController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []

    if params["release_id"] == nil
      @Release =  @Project.releases.where(:name=>'next')[0]
      @selected_index = 0
    else
      @Release =  Release.find_by(:id =>params["release_id"])
      @selected_index = params["selected_index"]
    end

    logger.debug "r date: #{@Release.start_date}"

  	respond_to do |format|	 	
			format.js	
	  end
  end
  
  def load_satisfaction_by_day
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"].to_i

    @series_name = params["series_name"]
    @release = Release.find_by(:id =>params["release_id"])
    
    @rattributes = @Project.get_attributes_with_owa_weights @release.start_date, @Project.get_end_date( @days, @release)

  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end

  def show_attributes_trend
  	@Project = Project.find_by(:id=>params["id"])
    @release = Release.find_by(:id =>params["release_id"])
  	@index = params["index"].to_i
  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end
 
end
