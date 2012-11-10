class District < ActiveRecord::Base
	belongs_to :name

	attr_accessible :name_id, :district_id, :count
end
