class AddNameRanks < ActiveRecord::Migration
  def up
    # first name
    puts 'first name ranks'
    current_count = 0
    rank = 0
    num_records_same_count = 1

    Name.where(:name_type => Name::TYPE[:first_name]).order("count desc").each_with_index do |name, index|
      puts "index = #{index}, count = #{name.count}" if index%500 == 0
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

    # last name
    puts 'last name ranks'
    current_count = 0
    rank = 0
    num_records_same_count = 1

    Name.where(:name_type => Name::TYPE[:last_name]).order("count desc").each_with_index do |name, index|
      puts "index = #{index}, count = #{name.count}" if index%500 == 0
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

  end

  def down
    Name.update_all(:rank => nil)
  end
end
