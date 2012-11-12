class AddDistrictRanks < ActiveRecord::Migration
  def up
    # first name
    puts 'first name ranks'
    district_names = District.joins(:name).where(:names => {:name_type => Name::TYPE[:first_name]}).order("districts.district_id asc, districts.count desc").readonly(false)
    district_names.map{|x| x.district_id}.uniq.sort.each do |district_id|
      puts "- district id = #{district_id}"
      current_count = 0
      rank = 0
      num_records_same_count = 1
      district_names.select{|x| x.district_id == district_id}.each_with_index do |name, index|
        puts "-- index = #{index}, count = #{name.count}" if index%500 == 0
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

    # last name
    puts 'last name ranks'
    district_names = District.joins(:name).where(:names => {:name_type => Name::TYPE[:last_name]}).order("districts.district_id asc, districts.count desc").readonly(false)
    district_names.map{|x| x.district_id}.uniq.sort.each do |district_id|
      puts "- district id = #{district_id}"
      current_count = 0
      rank = 0
      num_records_same_count = 1
      district_names.select{|x| x.district_id == district_id}.each_with_index do |name, index|
        puts "-- index = #{index}, count = #{name.count}" if index%500 == 0
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
  end

  def down
    District.update_all(:rank => nil)
  end
end
