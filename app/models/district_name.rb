class DistrictName < ActiveRecord::Base
	attr_accessible :name, :id

  has_many :districts
end
