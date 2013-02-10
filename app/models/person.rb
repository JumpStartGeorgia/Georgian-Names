class Person < ActiveRecord::Base

  belongs_to :first_name, :class_name => 'Name', :foreign_key => :first_name_id
  belongs_to :last_name, :class_name => 'Name', :foreign_key => :last_name_id


	attr_accessible :first_name_id, :last_name_id, :count, :rank
	
	def self.by_name(name_type, name_id)
	  if name_type.to_s == Name::TYPE[:first_name].to_s
      includes(:last_name).where(:people => {:first_name_id => name_id})
	  elsif name_type.to_s == Name::TYPE[:last_name].to_s
      includes(:first_name).where(:people => {:last_name_id => name_id})
	  end
	end
	
	def self.top_names(name_type, name_id, limit = 10)
    by_name(name_type, name_id).order("people.count desc").limit(limit)
	end

  def self.by_full_name
    includes(:first_name, :last_name)
  end
end
