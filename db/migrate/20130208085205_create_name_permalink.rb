class CreateNamePermalink < ActiveRecord::Migration
  def change
    add_column :names, :permalink, :string
    add_index :names, :permalink
  end
end
