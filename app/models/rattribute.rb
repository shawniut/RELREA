class Rattribute < ActiveRecord::Base
	include GitmetricHelper

	belongs_to :project, autosave:true
	belongs_to :metric, :class_name => 'Dataservice::Metric'
	belongs_to :mfunction, :class_name => 'Mfunction'
	has_many :values, :class_name => 'Value'

	

end
