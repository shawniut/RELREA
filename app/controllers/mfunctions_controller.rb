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
  		@metric = Project.find_by(id:params[:id]).rattributes.where(:metric_id =>@mid)[0]
  		#ratts = Project.find_by(id:params[:id]).rattributes.where(:metric_id =>@mid)
  		mf_parameter_count = params["mf-parameters"].to_i 

  		@parameters = ""
  		i=0
  		
  		for counter in 0..(mf_parameter_count-1)
  			@parameters+=params[i.to_s]+":"
  			i+=1
		end

		mfunction = Mfunction.create(:name => params["mf-title"], :parameter => @parameters)
		@metric.mfunction = mfunction

		message = "Membership Function Saved ("+@metric.metric.name+"-"+mfunction.name+")"

		@metric.save
  		respond_to do |format|
			 	
			format.html { render  :controller => "mfunctions", :ation => 'index', :id => params[:id], :notice => message}
			format.js
		end
  end

  def see_past_data
    
    
    respond_to do |format|
      format.js
    end
  end
end
