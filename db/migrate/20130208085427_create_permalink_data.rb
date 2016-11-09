class CreatePermalinkData < ActiveRecord::Migration
	require 'utf8_converter'
  def up
    puts "starting to add english to names"
    index = 0

    Name.all.each do |name|
      puts "-- index = #{index}" if index%500 == 0
      index = index+1

      name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
      name.permalink = Utf8Converter.generate_permalink(name[:name])
      name.save
    end

=begin
    Name.find_in_batches(:batch_size => 1000) do |names|
      names.each do |name|
        puts "-- index = #{index}" if index%500 == 0
        index = index+1

        name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
        name.permalink = Utf8Converter.generate_permalink(name[:name])
        name.save
      end
    end
=end
    puts "finished adding english to names"
  end

  def down
    Name.update_all(:permalink => nil)
  end
end
