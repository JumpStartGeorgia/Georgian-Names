class AddEnNames < ActiveRecord::Migration
  def up
    add_column :names, :name_en, :string
    add_index :names, :name_en

    add_column :district_names, :name_en, :string
    add_index :district_names, :name_en
  end

  def down
    remove_index :names, :name_en
    remove_column :names, :name_en

    remove_index :district_names, :name_en
    remove_column :district_names, :name_en, :string
  end
end
