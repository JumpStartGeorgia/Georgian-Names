class AddBirthYearRank < ActiveRecord::Migration
  def up

    # first name
    puts 'first name ranks'
    birth_year_names = BirthYear.joins(:name).where(:names => {:name_type => Name::TYPE[:first_name]}).order("birth_years.birth_year asc, birth_years.count desc").readonly(false)
    birth_year_names.map{|x| x.birth_year}.uniq.sort.each do |birth_year|
      puts "- birth year = #{birth_year}"
      current_count = 0
      rank = 0
      num_records_same_count = 1
      birth_year_names.select{|x| x.birth_year == birth_year}.each_with_index do |name, index|
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
    birth_year_names = BirthYear.joins(:name).where(:names => {:name_type => Name::TYPE[:last_name]}).order("birth_years.birth_year asc, birth_years.count desc").readonly(false)
    birth_year_names.map{|x| x.birth_year}.uniq.sort.each do |birth_year|
      puts "- birth year = #{birth_year}"
      current_count = 0
      rank = 0
      num_records_same_count = 1
      birth_year_names.select{|x| x.birth_year == birth_year}.each_with_index do |name, index|
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
    BirthYear.update_all(:rank => nil)
  end
end
