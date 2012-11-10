class CreateNameDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer :name_id
      t.integer :district_id
      t.integer :count

      t.timestamps
    end

		add_index :districts, :name_id
  end
end
