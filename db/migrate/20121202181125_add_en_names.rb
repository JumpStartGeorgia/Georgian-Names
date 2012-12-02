class AddEnNames < ActiveRecord::Migration
	require 'utf8_converter'
  def up
    add_column :names, :name_en, :string
    add_index :names, :name_en

    add_column :district_names, :name_en, :string
    add_index :district_names, :name_en

    Name.all.each do |name|
      name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
      name.save
    end

    DistrictName.all.each do |name|
      name.name_en = Utf8Converter.convert_ka_to_en(name[:name])
      name.save
    end
  end

  def down
    remove_index :names, :name_en
    remove_column :names, :name_en

    remove_index :district_names, :name_en
    remove_column :district_names, :name_en, :string
  end
end
