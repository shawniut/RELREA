class ManageValuesController < ApplicationController
	include GitmetricHelper
  
  def index
  	@Project = Project.find_by(:id=>params[:id])
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
