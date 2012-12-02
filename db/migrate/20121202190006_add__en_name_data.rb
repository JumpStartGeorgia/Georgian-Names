class Add_enNameData < ActiveRecord::Migration
	require 'utf8_converter'
  def up
    puts "starting to add english to names"
    Name.find_in_batches(:batch_size => 100) do |names|
      names.each do |name|
        name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
        name.save
      end
    end
    puts "finished adding english to names"

    puts "starting to add english to districts"
    DistrictName.find_in_batches(:batch_size => 100) do |names|
      names.each do |name|
        name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
        name.save
      end
    end
    puts "finished adding english to districts"
  end

  def down
    Name.update_all(:name_en => nil)
    DistrictName.update_all(:name_en => nil)
  end
end
