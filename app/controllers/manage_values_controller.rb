class ManageValuesController < ApplicationController
	include GitmetricHelper
  
  def index
  	@Project = Project.find_by(:id=>params[:id])
  end

  def load_values
    @Project = Project.find_by(:id=>params[:id])
    @releases = @Project.releases 

    respond_to do |format|
      format.js
    end
  end

  def load_and_save_values

    @Project = Project.find_by(:id=>params[:id])
    @releases = @Project.releases
    rattributes = @Project.rattributes

    start_date=  params[:project][:start_date].to_date
    max_date=  params[:project][:end_date].to_date

    metric_id = params["metric_id"]

    release = Release.find_by(:id=>params[:release_id])

    interval = params[:project][:interval].to_i
    end_date = start_date + interval.days

    #r = Rattribute.find_by(:id=>metric_id)

    count = 0
    rattributes.order(:id).each do |r|
      while end_date<= max_date do
        # random = Random.new
        # r.value = random.rand(10..50).to_f
       # if r.values.where(:end_date=>end_date).any? == false
        
          git_metric_value = get_git_metric_value  @Project.repo,  @Project.user, start_date, end_date, r,@Project, release
          value = Value.new(:mvalue=> git_metric_value, :start_date => start_date, :end_date => end_date)
          r.save_value(value)
            count +=1
        #end
        end_date = end_date + interval.days
      end
      end_date = start_date + interval.days
    end
    flash[:notice] = '"Metrics Values loaded successfully!!"'
    respond_to do |format|
      format.js 
    end

  end

  def delete_values

    @Project = Project.find_by(:id=>params[:id])
    @releases = @Project.releases
    
    @Project.rattributes.each do |r|
      r.values.destroy_all
    end

    respond_to do |format|
      format.js 
    end

  end

  def new

  	@start_date = params[:project][:start_date].to_date
  	@end_date = params[:project][:end_date].to_date


  	@Project = Project.find_by(:id=>params[:id])
  	@rattributes = @Project.rattributes

  	@ary = Array.new(@rattributes.length) 

  	i=0

  	@rattributes.each do |r|

      random = Random.new
  		r.value = random.rand(10..50).to_f
  		#@ary.push(get_git_metric_value 'publify', 'publify', @start_date, @end_date, r.metric.name);
  		i+=1
  	end

  	respond_to do |format|
			 	
			format.html { render  :controller => "manage_values", :ation => 'index', :id => params[:id]}
			format.js
	   end

  end

  def create

  	@Project = Project.find_by(:id=>params[:id])
  	rattributes = @Project.rattributes

  	rattributes.each do |r|

  		value = Value.new(:mvalue=> params[r.id.to_s].to_f, :start_date => params["start_date"].to_date, 
  			:end_date => params["end_date"].to_date)
      r.save_value(value)
  	end

  	respond_to do |format|
			 	
			format.html { render  :controller => "manage_values", :ation => 'index', :id => params[:id]}
			format.js
	end

  end
end
