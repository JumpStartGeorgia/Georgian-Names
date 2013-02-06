class CreatePersonMapping < ActiveRecord::Migration
  def up
    connection = ActiveRecord::Base.connection()
		time = Time.now.strftime('%Y-%m-%d %H:%M')

    index = 0
    Mapping.select('distinct first_name_id').each do |first_name|
      puts "-- index = #{index}" if index%500 == 0
      index = index+1
      
      # create records with count
  		sql = 'insert into people(first_name_id, last_name_id, count, created_at, updated_at) '
  		sql << 'select '
  		sql << 'first_name_id, last_name_id, count(*), "'
  		sql << time
  		sql << '", "'
  		sql << time
  		sql << '" '
  		sql << 'from mappings where first_name_id = '
  		sql << first_name.first_name_id.to_s
  		sql << ' group by first_name_id, last_name_id'
      connection.execute(sql)
=begin
      # create rankings
      current_count = 0
      rank = 0
      num_records_same_count = 1
      Person.where(:first_name_id => first_name.first_name_id).order('count desc').each do |name|
        if name.count == current_count
          # found name with same count
          num_records_same_count += 1 # increase the num of records with this count
        else
          # found new count
          current_count = name.count # save the new count value
          rank = rank + num_records_same_count # increase the rank value
          num_records_same_count = 1 # reset counter
        end
        # save the rank value
        name.rank = rank
        name.save
      end
=end      
    end
  end

  def down
    Person.delete_all
  end
end
