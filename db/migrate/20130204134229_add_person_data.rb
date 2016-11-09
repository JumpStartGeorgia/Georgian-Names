class AddPersonData < ActiveRecord::Migration
  def up
		puts "***************************"
		puts "*** This migration script assumes there is a database called voter_list_names_2016"
		puts "***   which has the raw data from the voter list."
		puts "*** The user for this database must have select permission for the voter_list_names_2016 database."
		puts "*** Look in the db/raw_data folder for the sql file to create this database."
		puts "***************************"

    connection = ActiveRecord::Base.connection()
		time = Time.now.strftime('%Y-%m-%d %H:%M')

		sql = 'insert into people(first_name_id, last_name_id, birth_year, district_id, created_at, updated_at) '
		sql << 'select '
		sql << 'first_names.id, last_names.id, map.birth_year, map.district_id_old, "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from voter_list_names_2016.raw as map '
    sql << 'inner join `mashasadame_2016`.names as first_names on first_names.name = map.first_name '
    sql << 'inner join `mashasadame_2016`.names as last_names on last_names.name = map.last_name '
		sql << 'where first_names.name_type = 1 and last_names.name_type = 2 '
    connection.execute(sql)

  end

  def down
    Person.delete_all
  end
end

