class RawFile < ActiveRecord::Base
	serialize :file, JSON
end
