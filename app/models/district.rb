class District < ActiveRecord::Base
	belongs_to :name

	attr_accessible :name_id, :district_id, :count
	attr_accessible :district_count
	
  def self.by_district(district, name_type, limit=10)
    if district && name_type
      includes(:name).where(:districts => {:district_id => district}, :names => {:name_type => name_type})
      .order("districts.count desc, names.name asc").limit(limit)
    end
  end
	
end
