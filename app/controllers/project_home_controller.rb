class ProjectHomeController < ApplicationController
  def index
  	@Project=Project.find_by(:id=>params["id"])
  end
end
