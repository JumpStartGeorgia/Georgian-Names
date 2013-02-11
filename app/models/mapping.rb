class Mapping < ActiveRecord::Base
  belongs_to :first_name, :class_name => 'Name', :foreign_key => :first_name_id
  belongs_to :last_name, :class_name => 'Name', :foreign_key => :last_name_id
  belongs_to :district_name, :class_name => 'DistrictName', :foreign_key => :district_id

	attr_accessible :first_name_id, :last_name_id, :birth_year, :district_id
  attr_accessor :district_name, :count, :permalink
	
  def district_name
		if I18n.locale == :ka
      read_attribute(:district_name)
		else
      read_attribute(:district_permalink)
		end
  end

  def district_permalink
    read_attribute(:district_permalink)
  end

  def count
    read_attribute(:count)
  end

  def self.birth_years(first_name_id, last_name_id, sort=false)
    x = select('mappings.birth_year, count(*) as count')
      .where(:first_name_id => first_name_id, :last_name_id => last_name_id)    
      .group('mappings.birth_year')
    x = x.order('mappings.birth_year asc') if sort
    return x
  end  

  def self.districts(first_name_id, last_name_id, sort=false)
    x = select('mappings.district_id, district_names.name as district_name, district_names.name_en as district_permalink, count(*) as count')
      .joins(:district_name).where(:first_name_id => first_name_id, :last_name_id => last_name_id)    
      .group('mappings.district_id, district_names.name')
    x = x.order('mappings.district_id asc') if sort
    return x
  end  
end
