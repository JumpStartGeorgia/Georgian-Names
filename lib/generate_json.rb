module GenerateJson
 
 #def self.no_data_color
 #  "#999999"
 #end
 
  def self.no_data_classname
    "rank_nodata"
  end
  
  def self.no_data_text
    I18n.t('app.common.no_data')
  end
  
  #########################################

  def self.rank(districts, data)
    json = []
    
    if !districts.blank? && !data.blank?
      districts.each do |district|
        item = Hash.new
        json << item

        item['district_id'] = district.id
        item['district_name'] = district.name

        data_record = data.select{|x| x[:district_id] == district.id}.first
        if data_record
          item['rank'] = data_record[:rank]
          item['rank_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:rank])
          item['count'] = data_record[:count]
          item['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:count])
          item['classname'] = get_rank_color(data_record[:rank])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['rank'] = no_data_text
          item['rank_formatted'] = no_data_text
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['classname'] = no_data_classname
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of rank colors
  def self.rank_colors
    [
      {:classname => 'rq1', :rank => '1'},
      {:classname => 'rq1.5', :rank => '2'},
      {:classname => 'rq2.5', :rank => '3'},
      {:classname => 'rq3', :rank => '4-9'},
      {:classname => 'rq4', :rank => '10-19'},
      {:classname => 'rq5', :rank => '20-29'},
      {:classname => 'rq6', :rank => '30-39'},
      {:classname => 'rq7', :rank => '40-49'},
      {:classname => 'rq7.5', :rank => '50-99'},
      {:classname => 'rq8.5', :rank => '> 100'},
      {:classname => no_data_classname, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the rank value
  def self.get_rank_color(rank)
    case rank
    when 1
      rank_colors[0][:classname]
    when 2
      rank_colors[1][:classname]
    when 3
      rank_colors[2][:classname]
    when 4..9
      rank_colors[3][:classname]
    when 10..19
      rank_colors[4][:classname]
    when 20..29
      rank_colors[5][:classname]
    when 30..39
      rank_colors[6][:classname]
    when 40..49
      rank_colors[7][:classname]
    when 50..99
      rank_colors[8][:classname]
    else
      rank_colors[9][:classname]
    end
  end
  
  #########################################
  
  def self.population(districts, data)
    json = []
    
    if !districts.blank? && !data.blank?
      districts.each do |district|
        item = Hash.new
        json << item

        item['district_id'] = district.id
        item['district_name'] = district.name

        data_record = data.select{|x| x[:district_id] == district.id}.first
        if data_record
          item['count'] = data_record[:count]
          item['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:count])
         #item['classname'] = get_population_color(data_record[:count])
          item['classname'] = get_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['classname'] = no_data_classname
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.population_colors
    [
      {:classname => 'rq1', :rank => '> 150,000'},
      {:classname => 'rq2', :rank => '100,000-150,000'},
      {:classname => 'rq3', :rank => '50,000-100,000'},
      {:classname => 'rq4', :rank => '40,000-50,000'},
      {:classname => 'rq5', :rank => '30,000-40,000'},
      {:classname => 'rq6', :rank => '20,000-30,000'},
      {:classname => 'rq7', :rank => '10,000-20,000'},
      {:classname => 'rq8', :rank => '< 10,000'},
      {:classname => no_data_classname, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_population_color(count)
    case
    when count > 150000
      population_colors[0][:classname]
    when (100001..150000).include?(count)
      population_colors[1][:classname]
    when (50001..100000).include?(count)
      population_colors[2][:classname]
    when (40001..50000).include?(count)
      population_colors[3][:classname]
    when (30001..40000).include?(count)
      population_colors[4][:classname]
    when (20001..30000).include?(count)
      population_colors[5][:classname]
    when (10001..20000).include?(count)
      population_colors[6][:classname]
    else
      population_colors[7][:classname]
    end
  end  


  #########################################
  
  def self.year_population(districts, data)
    json = []
    
    if !districts.blank? && !data.blank?
      districts.each do |district|
        item = Hash.new
        json << item

        item['district_id'] = district.id
        item['district_name'] = district.name

        data_record = data.select{|x| x[:district_id] == district.id}.first
        if data_record
          item['count'] = data_record[:count]
          item['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:count])
          item['classname'] = get_year_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['classname'] = no_data_classname
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.year_population_colors
    [
      {:classname => 'rq1', :rank => '> 3,200'},
      {:classname => 'rq2', :rank => '1,600 - 3,200'},
      {:classname => 'rq3', :rank => '800 - 1,600'},
      {:classname => 'rq4', :rank => '400 - 800'},
      {:classname => 'rq5', :rank => '200 - 400'},
      {:classname => 'rq6', :rank => '100 - 200'},
      {:classname => 'rq7', :rank => '50 - 100'},
      {:classname => 'rq8', :rank => '< 50'},
      {:classname => no_data_classname, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_year_population_color(count)
    case 
    when count > 3200
      year_population_colors[0][:classname]
    when (1601..3200).include?(count)
      year_population_colors[1][:classname]
    when (801..1600).include?(count)
      year_population_colors[2][:classname]
    when (401..800).include?(count)
      year_population_colors[3][:classname]
    when (201..400).include?(count)
      year_population_colors[4][:classname]
    when (101..200).include?(count)
      year_population_colors[5][:classname]
    when (51..100).include?(count)
      year_population_colors[6][:classname]
    else
      year_population_colors[7][:classname]
    end
  end  
  
  #########################################
  
  def self.district_population(districts, data)
    json = []
    
    if !districts.blank? && !data.blank?
      districts.each do |district|
        item = Hash.new
        json << item

        item['district_id'] = district.id
        item['district_name'] = district.name

        data_record = data.select{|x| x[:district_id] == district.id}.first
        if data_record
          item['rank'] = data_record[:rank]
          item['rank_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:rank])
          item['count'] = data_record[:count]
          item['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:count])
          item['classname'] = get_district_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['rank'] = no_data_text
          item['rank_formatted'] = no_data_text
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['classname'] = no_data_classname
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.district_population_colors
    [
      {:classname => 'rq1', :rank => '> 1,600'},
      {:classname => 'rq2', :rank => '800 - 1,600'},
      {:classname => 'rq3', :rank => '400 - 800'},
      {:classname => 'rq4', :rank => '200 - 400'},
      {:classname => 'rq5', :rank => '100 - 200'},
      {:classname => 'rq6', :rank => '50 - 100'},
      {:classname => 'rq7', :rank => '25 - 50'},
      {:classname => 'rq8', :rank => '< 25'},
      {:classname => no_data_classname, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_district_population_color(count)
    case 
    when count > 1600
      district_population_colors[0][:classname]
    when (801..1600).include?(count)
      district_population_colors[1][:classname]
    when (401..800).include?(count)
      district_population_colors[2][:classname]
    when (201..400).include?(count)
      district_population_colors[3][:classname]
    when (101..200).include?(count)
      district_population_colors[4][:classname]
    when (51..100).include?(count)
      district_population_colors[5][:classname]
    when (26..50).include?(count)
      district_population_colors[6][:classname]
    else
      district_population_colors[7][:classname]
    end
  end    

  #########################################
  
  def self.full_name_population(districts, data)
    json = []
    
    if !districts.blank? && !data.blank?
      districts.each do |district|
        item = Hash.new
        json << item

        item['district_id'] = district.id
        item['district_name'] = district.name

        data_record = data.select{|x| x[:district_id] == district.id}.first
        if data_record
          item['count'] = data_record[:count]
          item['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record[:count])
          item['classname'] = get_full_name_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['classname'] = no_data_classname
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.full_name_population_colors
    [
      {:classname => 'rq1'  , :rank => '> 100'},
      {:classname => 'rq2', :rank => '50 - 100'},
      {:classname => 'rq3' , :rank => '25 - 50'},
      {:classname => 'rq4' , :rank => '20 - 25'},
      {:classname => 'rq5' , :rank => '15 - 20'},
      {:classname => 'rq6' , :rank => '10 - 15'},
      {:classname => 'rq7'  , :rank => '5 - 10'},
      {:classname => 'rq8'    , :rank => '< 5'},
      {:classname => no_data_classname, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_full_name_population_color(count)
    case 
    when count > 100
      full_name_population_colors[0][:classname]
    when (51..100).include?(count)
      full_name_population_colors[1][:classname]
    when (26..50).include?(count)
      full_name_population_colors[2][:classname]
    when (21..25).include?(count)
      full_name_population_colors[3][:classname]
    when (16..20).include?(count)
      full_name_population_colors[4][:classname]
    when (11..15).include?(count)
      full_name_population_colors[5][:classname]
    when (6..10).include?(count)
      full_name_population_colors[6][:classname]
    else
      full_name_population_colors[7][:classname]
    end
  end  
  
end
