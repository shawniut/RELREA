class DataService::DatasourcesController < ApplicationController
	def index
		
	end

	def new

	end

	def update

	end

	def show

		@Project = Project.find_by(:id=> params["id"])

		@Metrics = Dataservice::Metric.all
			respond_to do |format|
			 	
			 	#format.html { render :action => "index" }
			 	format.js
		end
	end

	def save

		project = Project.find_by(:id=>params['id'])
		rattributes = project.rattributes

		metrics = Dataservice::Metric.all;
		
		metrics.each do |m|

			if m.id.to_s == params[m.id.to_s].to_s
					if project.is_metric_exist(m.id) == false
						logger.debug "Shawn1"
						att = Rattribute.create(:name => m.name)	
   						att.metric = m
   						rattributes << att
					end
			else
				rattributes.each do |r|
					if r.metric.id == m.id
						logger.debug "Shawn2"	
   						rattributes.delete(r)
					end
				end
			end
		end

		project.save

		respond_to do |format|	
			 format.html { render :action => "index" }
			 format.js
		end

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
