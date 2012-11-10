class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
			t.integer :name_type
      t.string :name

      t.timestamps
    end

		add_index :names, [:name_type, :name], :name => 'idx_names'
  end
end
