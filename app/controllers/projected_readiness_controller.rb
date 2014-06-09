class ProjectedReadinessController < ApplicationController
  def index
  		@Project = Project.find_by(:id=>params["id"])
  		@average_data = []
   		@optimistic_data = []
   		@pessimistic_data = []

   		@Release =  @Project.releases.where(:name=>'next')[0]

  		respond_to do |format|	 	
			format.js	
		end
  end
end
