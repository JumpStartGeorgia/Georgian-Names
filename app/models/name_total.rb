class NameTotal < ActiveRecord::Base
	attr_accessible :total_type, :identifier, :count
	
	
	TYPE = {:name => 1, :first_name_district => 2, :first_name_birth_year => 3, :last_name_district => 4, :last_name_birth_year => 5}
end
