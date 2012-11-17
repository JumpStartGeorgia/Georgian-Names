class AddYearDistrictPopulation < ActiveRecord::Migration
  def up
    # add district population
    puts "getting district population"
    sql = "select d.district_id, sum(d.count) as district_count "
    sql << "from names as n inner join districts as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:first_name].to_s
    sql << " group by d.district_id "
    sql << "order by d.district_id "
    District.find_by_sql(sql).each do |district|
      NameTotal.create(:total_type => NameTotal::TYPE[:district_population],
        :identifier => district.district_id,
        :count => district.district_count
      )
    end

    # add birth year population
    puts "getting birth year population"
    sql = "select d.birth_year, sum(d.count) as birth_year_count "
    sql << "from names as n inner join birth_years as d on d.name_id = n.id "
    sql << "where n.name_type = "
    sql << Name::TYPE[:first_name].to_s
    sql << " group by d.birth_year "
    sql << "order by d.birth_year "
    BirthYear.find_by_sql(sql).each do |birth_year|
      NameTotal.create(:total_type => NameTotal::TYPE[:birth_year_population],
        :identifier => birth_year.birth_year,
        :count => birth_year.birth_year_count
      )
    end
  end

  def down
    NameTotal.where(:total_type => NameTotal::TYPE[:district_population]).delete_all
    NameTotal.where(:total_type => NameTotal::TYPE[:birth_year_population]).delete_all
  end
end
