class RawFilesController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
  	respond_to do |format|
      format.js
    end
  end
  def download_save_files
  	@Project = Project.find_by(:id=>params["id"])
     r= Rattribute.find_by(:id=>params[:ra_id])


  	#@Project.rattributes.each do |r|
      #if(r.raw_file == nil)
  		  r.download_and_save_json_file @Project.repo, @Project.user, @Project
        flash[:notice] = "Data downloaded successfully for "+r.metric.name
     # end
  	#end

  	respond_to do |format|
      format.js
    end

  end
end
