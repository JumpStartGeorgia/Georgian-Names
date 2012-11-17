class CreateDistrictNames < ActiveRecord::Migration
  def change
    create_table :district_names do |t|
      t.string :name

      t.timestamps
    end

    add_index :district_names, :name
  end  
end
