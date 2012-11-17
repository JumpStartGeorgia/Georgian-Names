class FixYearDistrictTotals < ActiveRecord::Migration
  def up
    # remove existing total records
    puts "removing existing year/district name total records"
    NameTotal.where("total_type != 1").delete_all
    
    # add district totals
    puts "getting district totals"
    # - first name
    puts " - district first name totals"
    sql = "select d.district_id, count(*) as district_count "
    sql << "from names as n inner join districts as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:first_name].to_s
    sql << " group by d.district_id "
    sql << "order by d.district_id "
    District.find_by_sql(sql).each do |district|
      NameTotal.create(:total_type => NameTotal::TYPE[:first_name_district],
        :identifier => district.district_id,
        :count => district.district_count
      )
    end

    # - last name
    puts " - district last name totals"
    sql = "select d.district_id, count(*) as district_count "
    sql << "from names as n inner join districts as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:last_name].to_s
    sql << " group by d.district_id "
    sql << "order by d.district_id "    
    District.find_by_sql(sql).each do |district|
      NameTotal.create(:total_type => NameTotal::TYPE[:last_name_district],
        :identifier => district.district_id,
        :count => district.district_count
      )
    end
    
    # add birth year totals
    puts "getting birth year totals"
    # - first name
    puts " - birth year first name totals"
    sql = "select d.birth_year, count(*) as birth_year_count "
    sql << "from names as n inner join birth_years as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:first_name].to_s
    sql << " group by d.birth_year "
    sql << "order by d.birth_year "
    BirthYear.find_by_sql(sql).each do |birth_year|
      NameTotal.create(:total_type => NameTotal::TYPE[:first_name_birth_year],
        :identifier => birth_year.birth_year,
        :count => birth_year.birth_year_count
      )
    end

    # - last name
    puts " - birth year last name totals"
    sql = "select d.birth_year, count(*) as birth_year_count "
    sql << "from names as n inner join birth_years as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:last_name].to_s
    sql << " group by d.birth_year "
    sql << "order by d.birth_year "
    BirthYear.find_by_sql(sql).each do |birth_year|
      NameTotal.create(:total_type => NameTotal::TYPE[:last_name_birth_year],
        :identifier => birth_year.birth_year,
        :count => birth_year.birth_year_count
      )
    end
    
  end

  def down
    # do nothing
  end
end
