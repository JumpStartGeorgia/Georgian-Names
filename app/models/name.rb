class Name < ActiveRecord::Base
	has_many :birth_years
	has_many :districts

	attr_accessible :name_type, :name, :count, :permalink, :gender

  TYPE = {:first_name => 1, :last_name => 2}

	def name
		if I18n.locale == :ka
			return read_attribute(:name)
		else
			return read_attribute(:name_en).titlecase
		end
	end

	def self.by_name(name_type)
		where("name_type = ? and name is not null and name != ''", name_type)
	end

	def self.by_first_name(first_name)
		if first_name
			x = where(:name_type => Name::TYPE[:first_name], :permalink => first_name)
			return x.first if x.present?
		end
	end

	def self.by_last_name(last_name)
		if last_name
			x = where(:name_type => Name::TYPE[:last_name], :permalink => last_name)
			return x.first if x.present?
		end
	end

	def self.search_name(name)
		if name
			select("name_en, name_type").where(:name_en => name)
		end
	end

	def self.search_by_first_name(first_name)
		if first_name
			x = select("name_en").where(:name_type => Name::TYPE[:first_name], :name_en => first_name)
			return x.first if x.present?
		end
	end

	def self.search_by_last_name(last_name)
		if last_name
			x = select("name_en").where(:name_type => Name::TYPE[:last_name], :name_en => last_name)
			return x.first if x.present?
		end
	end


  def self.top_first_names(limit=10)
    where(:name_type => Name::TYPE[:first_name]).order("count desc").limit(limit)
  end

  def self.top_last_names(limit=10)
    where(:name_type => Name::TYPE[:last_name]).order("count desc").limit(limit)
  end

	def by_years_hash
		birth_years.map{|x| {:birth_year => x.birth_year, :count => x.count, :rank => x.rank}}
	end

	def by_age_array
		birth_years.map{|x| [x.birth_year, x.count, x.rank]}.sort{|a,b| a[0] <=> b[0]}
	end

	def by_districts
		districts.includes(:district_name).order("district_names.name")
		.map{|x| {:district_id => x.district_id, :district_name => x.district_name.name, 
		  :permalink => x.district_name.permalink, :count => x.count, :rank => x.rank}}
	end



  ########################
  ## add gender to names from spreadsheet
  ########################
  def self.assign_gender(file)
    require 'csv'
		start = Time.now
    infile = file.read
    n = 0
    idx_gender = 0
    idx_name = 1
    names_not_found = []

		original_locale = I18n.locale
    I18n.locale = :en

    Name.transaction do
		  CSV.parse(infile) do |row|
        startRow = Time.now
		    n += 1
        puts "@@@@@@@@@@@@@@@@@@ processing row #{n}"
        
        if n > 1
          # if name exists, add gender
          x = Name.where(:name => row[idx_name], :name_type => TYPE[:first_name]).update_all(:gender => row[idx_gender])

          # if no names were updated, then record the name
          if x == 0
            names_not_found << [n, row[idx_name]]
          end
        end
      
      	puts "******** time to process row: #{Time.now-startRow} seconds"
        puts "************************ total time so far : #{Time.now-start} seconds"
      end    
    end
    
  	puts "****************** time to process csv: #{Time.now-start} seconds"

		# reset the locale
		I18n.locale = original_locale

    return names_not_found
  end

end
