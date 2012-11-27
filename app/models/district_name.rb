class DistrictName < ActiveRecord::Base
	require 'utf8_converter'
	attr_accessible :name, :id

  has_many :districts

	def name
		if I18n.locale == :ka
			return read_attribute(:name)
		else
			return Utf8Converter.convert_ka_to_en(read_attribute(:name)).titlecase
		end
	end

end
