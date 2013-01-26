# encoding: utf-8
class AddTbilisi999 < ActiveRecord::Migration
  def up
    start = Time.now
    districts = [1,2,3,4,5,6,7,8,9,10]
    total_types = [2,4,6]
    tbilisi_id = 999

    # add district
    puts 'creating tbilisi district'
    tbilisi = DistrictName.create(:id => tbilisi_id, :name => 'თბილისი', :name_en => 'tbilisi')
    
    # create totals for tbilisi
    puts 'creating counts for tbilisi'
    total_types.each do |total_type|
      count = NameTotal.where(:identifier => districts, :total_type => total_type).sum(:count)
      NameTotal.create(:total_type => total_type, :identifier => tbilisi_id, :count => count)
    end

    # add district records
    # first name
    start_phase = Time.now
    puts 'adding district records for first name'
    # for each distint name in tbilisi districts
    District.select('distinct districts.name_id').joins(:name).where(:names => {:name_type => Name::TYPE[:first_name]}, :districts => {:district_id => districts}).order('districts.name_id asc').each do |name|
       
       # get total for this name id
       count = District.where(:name_id => name.name_id, :district_id => districts).sum(:count)
      
      # create district record for this name
      District.create(:district_id => tbilisi_id, :name_id => name.name_id, :count => count)
    end
    puts "- took #{Time.now-start_phase} seconds"
    
    # last name
    start_phase = Time.now
    puts 'adding district records for last name'
    # for each distint name in tbilisi districts
    District.select('distinct districts.name_id').joins(:name).where(:names => {:name_type => Name::TYPE[:last_name]}, :districts => {:district_id => districts}).order('districts.name_id asc').each do |name|
       
       # get total for this name id
       count = District.where(:name_id => name.name_id, :district_id => districts).sum(:count)
      
      # create district record for this name
      District.create(:district_id => tbilisi_id, :name_id => name.name_id, :count => count)
    end
    puts "- took #{Time.now-start_phase} seconds"
    
    # create ranks for district records
    # first name
    start_phase = Time.now
    puts 'creating rank for first name'
    current_count = 0
    rank = 0
    num_records_same_count = 1
    district_names = District.joins(:name).where(:names => {:name_type => Name::TYPE[:first_name]}, :districts => {:district_id => tbilisi_id}).order("districts.count desc").readonly(false).each do |name|

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
    puts "- took #{Time.now-start_phase} seconds"
    
    # last name
    start_phase = Time.now
    puts 'creating rank for last name'
    current_count = 0
    rank = 0
    num_records_same_count = 1
    district_names = District.joins(:name).where(:names => {:name_type => Name::TYPE[:last_name]}, :districts => {:district_id => tbilisi_id}).order("districts.count desc").readonly(false).each do |name|

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
    puts "- took #{Time.now-start_phase} seconds"

    puts "finished: #{Time.now-start} seconds"
    
  end
  
  
  def down
    tbilisi_id = 999
    total_types = [2,4,6]

    District.where(:district_id => tbilisi_id).delete_all
    NameTotal.where(:identifier => tbilisi_id, :total_type => total_types).delete_all
    DistrictName.delete(tbilisi_id)
    
  end
end
