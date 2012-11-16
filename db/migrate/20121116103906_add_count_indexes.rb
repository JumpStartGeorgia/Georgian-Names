class AddCountIndexes < ActiveRecord::Migration
  def change
    add_index :birth_years, :count
    add_index :districts, :count
    add_index :names, :count
    add_index :name_totals, :count
  end

end
