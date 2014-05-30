class DataService::DatasourcesController < ApplicationController
	def index
		
	end

	def new

	end

	def update

	end

	def create 
		
		@Projects = Project.new
		@Projects.name  = params[:repo_name][:name]
		@Projects.repo  = params[:repo_name][:name]
		@Projects.url  = params[:url][:name]
		@Projects.user  = params[:user_name][:name]

		

		if @Projects.save

			@Metrics = Dataservice::Metric.all
			respond_to do |format|
			 	
			 	format.html { render :action => "index" }
			 	format.js
			end

		 else
		 	respond_to do |format|
			 	
		 	 	format.html { render :action => "index" }
		 	 end
		 end
	end

end
