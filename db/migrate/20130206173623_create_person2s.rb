class CreatePerson2s < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :first_name_id
      t.integer :last_name_id
      t.integer :count
      t.integer :rank

      t.timestamps
    end
    
    add_index :people, :first_name_id
    add_index :people, :last_name_id
  end
end
