class District < ActiveRecord::Base
	belongs_to :name
	belongs_to :district_name, :class_name => "DistrictName", :foreign_key => "district_id"

	attr_accessible :name_id, :district_id, :count
	attr_accessible :district_count
	
  def self.by_district(district, name_type)
    includes(:name).where(:districts => {:district_id => district}, :names => {:name_type => name_type})
  end
	
  def self.by_name(name_id)
    joins(:district_name).where(:name_id => name_id)
  end
	
=begin
  def self.by_district(district, name_type, limit=10)
    if district && name_type
      includes(:name).where(:districts => {:district_id => district}, :names => {:name_type => name_type})
      .order("districts.count desc, names.name asc").limit(limit)
    end
  end
=end	

end
