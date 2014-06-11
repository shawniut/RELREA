class WeightsController < ApplicationController
  def index
  	@project_id = params[:id]

  	@rattributes = Project.find_by(:id => @project_id).rattributes

  end

  def show
    @project_id = params[:id]

    @rattributes = Project.find_by(:id => @project_id).rattributes

    respond_to do |format|
        
      #format.html { render  :controller => "settings", :ation => 'index', :id => params[:id]}
      format.js
    end
  end

  def create
  	@project_id = params[:id]

  	@rattributes = Project.find_by(:id => @project_id).rattributes

  	@rattributes.each do |r|
  		r.weight = params[r.id.to_s].to_f
      r.label = params["#{r.id}_label"]
  		r.save
  	end

  	respond_to do |format|
			 	
			#format.html { render  :controller => "weights", :ation => 'index', :id => params[:id]}
			format.js
	end

  end
end
