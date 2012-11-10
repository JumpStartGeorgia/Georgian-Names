class BirthYear < ActiveRecord::Base
	belongs_to :name

	attr_accessible :name_id, :birth_year, :count

end
