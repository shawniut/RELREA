class InfosController < ApplicationController
  def index
  	@Project = Project.find_by(:id => params['id'])

  	respond_to do |format|
      format.js
    end
  end

  def save
  	@Project = Project.find_by(:id => params['id'])


  	release_date = params[:project][:release_date].to_date
  	start_date = params[:project][:start_date].to_date
    repo = params[:project][:repo]
    user = params[:project][:user]

    is_private = false
    if params["private"] == "1" 
     
      if is_private == false and params["private"] == "1" 
        @Project.username = params[:github][:user_name]
        @Project.password = params[:github][:password]
      end
       is_private = true 
    end
   
  	info = @Project.info

  	if info == nil
  		info = Info.create(:next_release_date => release_date, :start_date => start_date, :is_private=>is_private)
  		@Project.info = info
      @Project.user = user
      @Project.repo = repo
  	else
  		info.next_release_date = release_date
  		info.start_date = start_date
      info.is_private = is_private
      @Project.user = user
      @Project.repo = repo
      info.save
  	end

    if @Project.jira != nil
       jira = @Project.jira
       jira.project_name = params[:jira_project][:name]
       jira.url = params[:jira_project][:url]
       jira.username = params[:jira_project][:user_name]
       jira.password = params[:jira_project][:password]
       jira.save
    end

    @Project.save
      
    respond_to do |format|    
      format.js
    end
  end
end