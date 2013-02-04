class DistrictYear < ActiveRecord::Base

  def self.by_district(district_id)
    where(:district_id => district_id)
  end


  def self.by_birth_year(birth_year)
    where(:birth_year => birth_year)
  end
end
