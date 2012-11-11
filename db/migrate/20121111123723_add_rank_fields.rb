class AddRankFields < ActiveRecord::Migration
  def change
    add_column :names, :rank, :integer
    add_column :birth_years, :rank, :integer
    add_column :districts, :rank, :integer
  end

end
