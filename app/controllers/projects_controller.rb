class ProjectsController < ApplicationController
  def index
  end
  def create
		@Project = Project.new

		@Project.name = params[:name][:name]
		@Project.repo = params[:repo_name][:name]
		@Project.user = params[:user_name][:name]

		if params[:JIRA] == "1"
			@Project.jira = Jira.new
		end

		if @Project.save
			redirect_to "/projects", :notice => "Project saved successfully !!"
		else
			render action: 'index'
		end
		
	end
end
