class HomeController < ApplicationController

	def index
		
	end

	def create 
		Rails.logger.info("PARAMS: #{params.inspect}")
		
		@val = params['ids']

		@ids = params['ids'].split(":")
  
		@project_id = params['project_id']

		p_id = 	@project_id

		project = Project.find_by(:id=> p_id)

		@count = 0

		
		@ids.each do |id|
			metric = Dataservice::Metric.find_by(:id => id)

   			att = Rattribute.create(:name => "BFR")	
   			att.metric = metric
			project.rattributes << att

			@count += 1
		end

		project.save
		
		@project_id2 = params['project_id']

		render 'index'
	end 


end
