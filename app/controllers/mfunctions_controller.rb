class MfunctionsController < ApplicationController
  def index

  		@Project = Project.find_by(id:params[:id])

  end

  def show

    @Project = Project.find_by(id:params[:id])
    respond_to do |format|
        
      format.html { render  :controller => "settings", :ation => 'index', :id => params[:id]}
      format.js
    end

  end

  def show_mf
    @Project = Project.find_by(id:params[:id])
    mid = params[:metrics_id]
    rattributes = Project.find_by(id:params[:id]).rattributes
    @ra = rattributes.where(:metric_id =>mid)[0]
    @mfunction = @ra.mfunction


    respond_to do |format|
      format.js
    end

  end

  def create

  		@pid = params[:id]
  		@mid = params[:metrics_id]
  		@metric = Project.find_by(:id=>params[:id]).rattributes.where(:metric_id =>@mid)[0]
  		
  		mf_parameter_count = params["mf-parameters"].to_i 

  		@parameters = ""
  		
  		(0..mf_parameter_count-1).each do |i|
  			@parameters += params[i.to_s]+":"
		  end

		  mfunction = Mfunction.create(:name => params["mf-title"], :parameter => @parameters)
		  @metric.mfunction = mfunction
      @metric.save

		  flash[:notice] = "Membership Function Saved ("+ @metric.metric.name+"-"+mfunction.name+")"+@parameters

  		respond_to do |format|
			   format.js
		  end
  end

  def see_past_data
    
    
    respond_to do |format|
      format.js
    end
  end
end
