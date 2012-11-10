class CreateNameTotals < ActiveRecord::Migration
  def change
    create_table :name_totals do |t|
      t.integer :name_type
      t.integer :count

      t.timestamps
    end

		add_index :name_totals, :name_type
  end
end
