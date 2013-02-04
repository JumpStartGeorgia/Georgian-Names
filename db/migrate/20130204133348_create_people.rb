class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :first_name_id
      t.integer :last_name_id
      t.integer :birth_year
      t.integer :district_id

      t.timestamps
    end

    add_index :people, [:first_name_id, :last_name_id]
    add_index :people, :birth_year
    add_index :people, :district_id
  end
end
