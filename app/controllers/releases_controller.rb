class ReleasesController < ApplicationController
  def index
  	@Project = Project.find_by(:id => params["id"])
  	@releases = @Project.releases

  	if(@releases.any? == false)
  		@releases = @Project.get_release_info 
  	end

  	respond_to do |format|
      format.js
    end
  end

  def new_release
    name = params[:release][:name]
    start_date = params[:release][:start_date].to_date
    end_date = params[:release][:end_date].to_date

    release = Release.create(:name=>name, :date=>end_date, :start_date => start_date)

    @Project = Project.find_by(:id => params["id"])
    @Project.releases << release
    @Project.save

    respond_to do |format|
      format.js
    end

  end

  def save 
  	@Project = Project.find_by(:id => params["id"])
  	release_count = params["release_count"].to_i

  	(1..release_count).each do |i|
  		release = Release.new
  		release.name = params["#{i-1}_name"]
  		release.date = params["#{i-1}"]
      release.start_date = params["#{i-1}_start_date"]
  		@Project.save_release release
  	end

  	respond_to do |format|
			 	
			#format.html { render  :controller => "weights", :ation => 'index', :id => params[:id]}
			format.js
	end
  end


end
