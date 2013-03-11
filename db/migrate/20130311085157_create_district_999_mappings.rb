class CreateDistrict999Mappings < ActiveRecord::Migration
  def up
    connection = ActiveRecord::Base.connection()
		time = Time.now.strftime('%Y-%m-%d %H:%M')

    sql = 'insert into mappings (first_name_id, last_name_id, birth_year, district_id, created_at, updated_at) '
    sql << 'select first_name_id, last_name_id, birth_year, 999, "'
		sql << time
		sql << '", "'
		sql << time
		sql << '" '
    sql << "from mappings where district_id between 1 and 10"
    
    connection.execute(sql)
    
  end

  def down
    Mapping.where(:district_id => 999).delete_all
  end
end
