class Attribute < ActiveRecord::Base
	attr_accessor :a
	belongs_to :project, autosave:true

	
end
