class UpdateNameTotals < ActiveRecord::Migration
  def up
		remove_index :name_totals, :name_type
    add_column :name_totals, :total_type, :integer
    rename_column :name_totals, :name_type, :identifier
		add_index :name_totals, [:total_type, :identifier]
    
  end

  def down
		remove_index :name_totals, [:total_type, :name_type]
    drop_column :name_totals, :total_type
    rename_column :name_totals, :identifier, :name_type
		add_index :name_totals, :name_type

  end
end
