class AnalysisController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
    @average_data = []
    @optimistic_data = []
    @pessimistic_data = []

    if params["release_id"] == nil
      @Release =  @Project.releases.where(:name=>'next')[0]
      @selected_index = 0
      @moving_average_index = 0
      @moving_average_order = 3
    else
      @Release =  Release.find_by(:id =>params["release_id"])
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
end
