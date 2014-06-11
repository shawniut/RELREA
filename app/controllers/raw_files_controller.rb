class RawFilesController < ApplicationController
  def index
  	@Project = Project.find_by(:id=>params["id"])
  	respond_to do |format|
      format.js
    end
  end
  def download_save_files
  	@Project = Project.find_by(:id=>params["id"])

  	@Project.rattributes.each do |r|
      #if(r.raw_file == nil)
  		  r.download_and_save_json_file @Project.repo, @Project.user
     # end
  	end

  	respond_to do |format|
      format.js
    end

  end
end
