class AnalysisController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []

    if params["release_id"] == nil
      @Releases =  @Project.releases
      @selected_index = 0
      @moving_average_index = 0
      @moving_average_order = 3
      @analysis_type = 1
      @analysis_type_index = 0
    else
      release_id = params["release_id"].to_i
      @Releases =  release_id!=0 ? Release.where(:id =>release_id) : @Project.releases
      @selected_index = params["selected_index"]
    end

    @trend = 0.2
    @level = 0.8
    @step = 1;

    if params["projection_trend"].to_f != 0.0
       @trend = params["projection_trend"].to_f
       @level = params["projection_level"].to_f
       @step = params["projection_step"].to_f
    end

    if params["moving_average_selected_index"] != nil
      @moving_average_order =  params["moving_average_id"].to_i
      @moving_average_index = params["moving_average_selected_index"]
    end

    if params["analysis_type_id"] != nil
       @analysis_type = params["analysis_type_id"].to_i
       @analysis_type_index = @analysis_type -1
    end

  	respond_to do |format|	 	
			format.js	
	end
  end

  def load_attribute_satisfaction
  	@Project = Project.find_by(:id=>params["id"])

    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []



    @series_name = params["series_name"]
    @release = Release.find_by(:id =>params["release_id"])

    if params["release_id"] == "0"
       @release = @Project.releases[0]
    end

    @days = (params["days"].to_date - @release.start_date ).to_i

  	@moving_average_data = []

    @moving_average_order =  params["moving_average_id"].to_i
    @interval = params["interval"].to_i
    
    @rattributes = @Project.get_attributes_with_owa_weights @release.start_date, @Project.get_end_date( @days, @release)

  	respond_to do |format|	 	
			#format.html { render  :controller => "dashboard", :ation => 'index', :id => params[:id]}
			format.js	
	end
  end
end
