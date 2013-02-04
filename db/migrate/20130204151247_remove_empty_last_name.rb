class RemoveEmptyLastName < ActiveRecord::Migration
  def up
    name = Name.where(:name => '')

    name.each do |n|
      BirthYear.where(:name_id => n.id).delete_all
      District.where(:name_id => n.id).delete_all
    end
  end

  def down
    # do nothing
  end
end
