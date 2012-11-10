class CreateNameBirthYears < ActiveRecord::Migration
  def change
    create_table :birth_years do |t|
      t.integer :name_id
      t.integer :birth_year
      t.integer :count

      t.timestamps
    end

		add_index :birth_years, :name_id
  end
end
