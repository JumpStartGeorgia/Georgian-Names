class Mapping < ActiveRecord::Base
  belongs_to :first_name, :class_name => 'Name', :foreign_key => :first_name_id
  belongs_to :last_name, :class_name => 'Name', :foreign_key => :last_name_id


	attr_accessible :first_name_id, :last_name_id, :birth_year, :district_id
  attr_accessor :name, :count, :permalink
	
	def name
		if I18n.locale == :ka
			return read_attribute(:name)
		else
			return read_attribute(:permalink).titlecase
		end
	end
	
	def permalink
	  return read_attribute(:permalink)
	end
	
	def count
	  return read_attribute(:count)
	end
	
	def self.top_names(name_type, name_id, limit = 10)
    sql = build_sql(name_type)
    sql << "order by count desc limit :limit"
    find_by_sql([sql, :name_id => name_id, :limit => limit])
	end

	def self.by_name(name_type, name_id)
    find_by_sql([build_sql(name_type), :name_id => name_id])
	end
	
	def self.datatable(name_type, name_id, sort_col, sort_dirn, page, per_page, search=nil)
    add_search = search.present? ? true : false
    offset = (page-1) * per_page
    sql = build_sql(name_type, add_search)    
    sql << "order by #{sort_col} #{sort_dirn} "
    sql << "limit :per_page offset :offset "
    find_by_sql([sql, :name_id => name_id, :search => "%#{search}%", :sort => "", 
        :per_page => per_page, :offset => offset])
	end
	
	def self.datatable_count(name_type, name_id, search=nil)
    add_search = search.present? ? true : false
    x = find_by_sql([build_sum_sql(name_type, add_search), :name_id => name_id, :search => "%#{search}%"])
    return x.blank? ? 0 : x.first.count
	end
	
private

  def self.build_sql(name_type, add_search=false)
    sql = "select names.name, names.name_en as permalink, count(*) as count "
	  if name_type.to_s == Name::TYPE[:first_name].to_s
      sql << "from people inner join names on names.id = people.last_name_id "
      sql << "where people.first_name_id = :name_id "
	  elsif name_type.to_s == Name::TYPE[:last_name].to_s
      sql << "from people inner join names on names.id = people.first_name_id "
      sql << "where people.last_name_id = :name_id "
	  end
	  sql << " and names.name like :search " if add_search
	  sql << "group by names.name, names.name_en "
    return sql
  end

  def self.build_sum_sql(name_type, add_search=false)
    sql = "select count(*) as count from (select names.name, names.name_en "
	  if name_type.to_s == Name::TYPE[:first_name].to_s
      sql << "from people inner join names on names.id = people.last_name_id "
      sql << "where people.first_name_id = :name_id "
	  elsif name_type.to_s == Name::TYPE[:last_name].to_s
      sql << "from people inner join names on names.id = people.first_name_id "
      sql << "where people.last_name_id = :name_id "
	  end
	  sql << " and names.name like :search " if add_search
	  sql << "group by names.name, names.name_en) as x "
    return sql
  end
end
