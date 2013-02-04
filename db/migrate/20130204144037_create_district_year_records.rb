class CreateDistrictYearRecords < ActiveRecord::Migration
  def up

    connection = ActiveRecord::Base.connection()
		time = Time.now.strftime('%Y-%m-%d %H:%M')

    puts 'creating records'

		sql = 'insert into district_years(district_id, birth_year, count, created_at, updated_at) '
		sql << 'select district_id, birth_year, count(*), "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from people  '
    sql << 'group by district_id, birth_year '
    sql << 'order by district_id, birth_year '
    connection.execute(sql)


    puts 'creating tbilisi records'
		sql = 'insert into district_years(district_id, birth_year, count, created_at, updated_at) '
		sql << 'select 999, birth_year, count(*), "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
		sql << 'from people  '
    sql << 'where district_id between 1 and 10 '
    sql << 'group by birth_year '
    sql << 'order by birth_year '
    connection.execute(sql)
  
  end

  def down
    DistrictYear.delete_all
  end
end

