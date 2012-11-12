class AddMissingNameTotalIdentifiers < ActiveRecord::Migration
  def up
    total = NameTotal.find(1)
    total.identifier = Name::TYPE[:first_name]
    total.save
    total = NameTotal.find(2)
    total.identifier = Name::TYPE[:last_name]
    total.save
  end

  def down
    total = NameTotal.find(1)
    total.identifier = nil
    total.save
    total = NameTotal.find(2)
    total.identifier = nil
    total.save
  end
end
