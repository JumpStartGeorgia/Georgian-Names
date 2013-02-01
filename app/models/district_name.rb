class DistrictName < ActiveRecord::Base
	attr_accessible :name, :id, :name_en

  has_many :districts

	def name
		if I18n.locale == :ka
			return read_attribute(:name)
		else
			return read_attribute(:name_en)
		end
	end

	def permalink
		read_attribute(:name_en).downcase
	end

end
