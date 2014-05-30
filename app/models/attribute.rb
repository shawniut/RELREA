class Attribute < ActiveRecord::Base

	belongs_to :project, autosave:true
	
end
