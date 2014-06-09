class InfosController < ApplicationController
  def index
  	@Project = Project.find_by(:id => params['id'])

  	 respond_to do |format|
        
      #format.html { render  :controller => "settings", :ation => 'index', :id => params[:id]}
      format.js
    end
  end

  def save
  	@Project = Project.find_by(:id => params['id'])

  	@Project = Project.find_by(:id => params['id'])

  	release_date = params[:project][:release_date].to_date
  	start_date = params[:project][:start_date].to_date
    repo = params[:project][:repo]
    user = params[:project][:user]

  	info = @Project.info

  	if info == nil
  		info = Info.create(:next_release_date => release_date, :start_date => start_date)
  		@Project.info = info
      @Project.user = user
      @Project.repo = repo
  		@Project.save
  	else
  		info.next_release_date = release_date
  		info.start_date = start_date
      @Project.user = user
      @Project.repo = repo
  		@Project.save
  	end
  	respond_to do |format|
        
      format.html { render  :controller => "settings", :ation => 'index', :id => params[:id]}
      format.js
    end
  end
end
