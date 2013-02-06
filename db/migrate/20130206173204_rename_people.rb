class RenamePeople < ActiveRecord::Migration
  def up
    remove_index :people, [:first_name_id, :last_name_id]
    remove_index :people, :birth_year
    remove_index :people, :district_id

    rename_table :people, :mappings

    add_index :mappings, [:first_name_id, :last_name_id]
    add_index :mappings, :birth_year
    add_index :mappings, :district_id
  end

  def down
    remove_index :mappings, [:first_name_id, :last_name_id]
    remove_index :mappings, :birth_year
    remove_index :mappings, :district_id

    rename_table :mappings, :people

    add_index :people, [:first_name_id, :last_name_id]
    add_index :people, :birth_year
    add_index :people, :district_id
  end
end
