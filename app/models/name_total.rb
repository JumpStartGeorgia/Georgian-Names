class NameTotal < ActiveRecord::Base
	attr_accessible :total_type, :identifier, :count
	
	
	TYPE = {:name => 1, :first_name_district => 2, :first_name_birth_year => 3, :last_name_district => 4, :last_name_birth_year => 5}
	
	def self.first_name
	  where(:total_type => NameTotal::TYPE[:name], :identifier => Name::TYPE[:first_name]).first
	end

	def self.last_name
	  where(:total_type => NameTotal::TYPE[:name], :identifier => Name::TYPE[:last_name]).first
	end
	
	def self.first_name_birth_year(year)
	  if year
	    where(:total_type => NameTotal::TYPE[:first_name_birth_year], :identifier => year).first
	  end
  end

	def self.last_name_birth_year(year)
	  if year
	    where(:total_type => NameTotal::TYPE[:last_name_birth_year], :identifier => year).first
	  end
  end

	def self.first_name_district(district)
	  if district
	    where(:total_type => NameTotal::TYPE[:first_name_district], :identifier => district).first
	  end
  end

	def self.last_name_district(district)
	  if district
	    where(:total_type => NameTotal::TYPE[:last_name_district], :identifier => district).first
	  end
  end
end
