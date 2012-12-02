class Add_enNameData < ActiveRecord::Migration
	require 'utf8_converter'
  def up
    puts "starting to add english to names"
    Name.find_in_batches(:batch_size => 100) do |name|
      name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
      name.save
    end
    puts "finished adding english to names"

    puts "starting to add english to districts"
    DistrictName.find_in_batches(:batch_size => 100) do |name|
      name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
      name.save
    end
    puts "finished adding english to districts"
  end

  def down
    Name.all.update_all(:name_en => nil)
    DistrictName.all.update_all(:name_en => nil)
  end
end
