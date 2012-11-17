class BirthYear < ActiveRecord::Base
	belongs_to :name

	attr_accessible :name_id, :birth_year, :count
  attr_accessible :birth_year_count
  
  def self.by_year(year, name_type, limit=10)
    if year && name_type
      includes(:name).where(:birth_years => {:birth_year => year}, :names => {:name_type => name_type})
      .order("birth_years.count desc, names.name asc").limit(limit)
    end
  end
end
