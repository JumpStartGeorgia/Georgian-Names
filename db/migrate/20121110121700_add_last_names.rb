class AddLastNames < ActiveRecord::Migration
  def up
		puts "***************************"
		puts "*** This migration script assumes there is a database called voter_list_names"
		puts "***   which has the raw data from the voter list."
		puts "*** The user for this database must have select permission for the voter_list_names database."
		puts "*** Look in the db/raw_data folder for the sql file to create this database."
		puts "***************************"

    connection = ActiveRecord::Base.connection()
		time = Time.now.strftime('%Y-%m-%d %H:%M')

		# add distinct last_names
		puts "adding distinct last name"
		sql = 'insert into names(name_type, name, created_at, updated_at) '
		sql << 'select distinct '
		sql << Name::TYPE[:last_name].to_s
		sql << ', last_name, "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from voter_list_names.last_names_district '
		sql << 'where last_name != "---" and last_name != "–––––" and last_name != "––––––" '
		sql << 'order by last_name '
    connection.execute(sql)

		# add name total
		puts "adding total of distinct last name"
		total = Name.where(:name_type => Name::TYPE[:last_name]).count
		NameTotal.create(:name_type => Name::TYPE[:last_name], :count => total)

		# add birth year records
		puts "adding last names by birth year"
		sql = 'insert into birth_years(name_id, birth_year, count, created_at, updated_at) '
		sql << 'select n.id, vl.year, vl.name_count, "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from voter_list_names.last_names_birth_date as vl inner join names as n on n.name = vl.last_name '
		sql << 'where n.name_type = '
		sql << Name::TYPE[:last_name].to_s
		sql << ' order by n.id, vl.year '
    connection.execute(sql)

		# add district records
		puts "adding last names by district"
		sql = 'insert into districts(name_id, district_id, count, created_at, updated_at) '
		sql << 'select n.id, vl.district, vl.name_count, "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from voter_list_names.last_names_district as vl inner join names as n on n.name = vl.last_name '
		sql << 'where n.name_type = '
		sql << Name::TYPE[:last_name].to_s
		sql << ' order by n.id, vl.district '
    connection.execute(sql)

  end

  def down
		# delete all name records
		ByBirthYear.delete_all
		ByDistrict.delete_all
		Name.delete_all
		NameTotal.delete_all
  end
end
