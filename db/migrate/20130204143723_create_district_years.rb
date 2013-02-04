class CreateDistrictYears < ActiveRecord::Migration
  def change
    create_table :district_years do |t|
      t.integer :district_id
      t.integer :birth_year
      t.integer :count

      t.timestamps
    end

    add_index :district_years, :district_id
    add_index :district_years, :birth_year

  end
end
