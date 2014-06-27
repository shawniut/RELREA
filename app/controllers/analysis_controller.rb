class AnalysisController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []

    if params["release_id"] == nil
      @Releases =  @Project.releases.where(:name=>'next')
      @selected_index = 0
      @moving_average_index = 0
      @moving_average_order = 3
    else
      release_id = params["release_id"].to_i
      @Releases =  release_id!=0 ? Release.where(:id =>release_id) : @Project.releases
      @selected_index = params["selected_index"]
    end
    if params["moving_average_selected_index"] != nil
      @moving_average_order =  params["moving_average_id"].to_i
      @moving_average_index = params["moving_average_selected_index"]
    end
  	respond_to do |format|	 	
			format.js	
	end
  end

  def load_attribute_satisfaction
  	@Project = Project.find_by(:id=>params["id"])
  	@days = params["days"].to_i

  	@moving_average_data = params['moving_average_data']

    @series_name = params["series_name"]
    @release = Release.find_by(:id =>params["release_id"])

    @moving_average_order =  params["moving_average_id"].to_i
    @interval = params["interval"].to_i
    
    @rattributes = @Project.get_attributes_with_owa_weights @release.start_date, @Project.get_end_date( @days, @release)

  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end
end
