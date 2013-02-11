module GenerateJson
 
  def self.no_data_color
    "#999999"
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
          item['color'] = get_rank_color(data_record[:rank])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['rank'] = no_data_text
          item['rank_formatted'] = no_data_text
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['color'] = no_data_color
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of rank colors
  def self.rank_colors
    [
      {:color => '#000000', :rank => '1'},
      {:color => '#08306B', :rank => '2'},
      {:color => '#08519C', :rank => '3'},
      {:color => '#2171B5', :rank => '4-9'},
      {:color => '#4292C6', :rank => '10-19'},
      {:color => '#6BAED6', :rank => '20-29'},
      {:color => '#9ECAE1', :rank => '30-39'},
      {:color => '#C6DBEF', :rank => '40-49'},
      {:color => '#DEEBF7', :rank => '50-99'},
      {:color => '#F7FBFF', :rank => '> 100'},
      {:color => no_data_color, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the rank value
  def self.get_rank_color(rank)
    case rank
    when 1
      rank_colors[0][:color]
    when 2
      rank_colors[1][:color]
    when 3
      rank_colors[2][:color]
    when 4..9
      rank_colors[3][:color]
    when 10..19
      rank_colors[4][:color]
    when 20..29
      rank_colors[5][:color]
    when 30..39
      rank_colors[6][:color]
    when 40..49
      rank_colors[7][:color]
    when 50..99
      rank_colors[8][:color]
    else
      rank_colors[9][:color]
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
          item['color'] = get_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['color'] = no_data_color
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.population_colors
    [
      {:color => '#000000', :rank => '> 150,000'},
      {:color => '#084594', :rank => '100,000-150,000'},
      {:color => '#2171B5', :rank => '50,000-100,000'},
      {:color => '#4292C6', :rank => '40,000-50,000'},
      {:color => '#6BAED6', :rank => '30,000-40,000'},
      {:color => '#9ECAE1', :rank => '20,000-30,000'},
      {:color => '#C6DBEF', :rank => '10,000-20,000'},
      {:color => '#EFF3FF', :rank => '< 10,000'},
      {:color => no_data_color, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_population_color(count)
    case 
    when count > 150000
      population_colors[0][:color]
    when (100001..150000).include?(count)
      population_colors[1][:color]
    when (50001..100000).include?(count)
      population_colors[2][:color]
    when (40001..50000).include?(count)
      population_colors[3][:color]
    when (30001..40000).include?(count)
      population_colors[4][:color]
    when (20001..30000).include?(count)
      population_colors[5][:color]
    when (10001..20000).include?(count)
      population_colors[6][:color]
    else
      population_colors[7][:color]
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
          item['color'] = get_year_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['color'] = no_data_color
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.year_population_colors
    [
      {:color => '#000000', :rank => '> 3,200'},
      {:color => '#084594', :rank => '1,600 - 3,200'},
      {:color => '#2171B5', :rank => '800 - 1,600'},
      {:color => '#4292C6', :rank => '400 - 800'},
      {:color => '#6BAED6', :rank => '200 - 400'},
      {:color => '#9ECAE1', :rank => '100 - 200'},
      {:color => '#C6DBEF', :rank => '50 - 100'},
      {:color => '#EFF3FF', :rank => '< 50'},
      {:color => no_data_color, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_year_population_color(count)
    case 
    when count > 3200
      year_population_colors[0][:color]
    when (1601..3200).include?(count)
      year_population_colors[1][:color]
    when (801..1600).include?(count)
      year_population_colors[2][:color]
    when (401..800).include?(count)
      year_population_colors[3][:color]
    when (201..400).include?(count)
      year_population_colors[4][:color]
    when (101..200).include?(count)
      year_population_colors[5][:color]
    when (51..100).include?(count)
      year_population_colors[6][:color]
    else
      year_population_colors[7][:color]
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
          item['color'] = get_district_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['rank'] = no_data_text
          item['rank_formatted'] = no_data_text
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['color'] = no_data_color
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.district_population_colors
    [
      {:color => '#000000', :rank => '> 1,600'},
      {:color => '#084594', :rank => '800 - 1,600'},
      {:color => '#2171B5', :rank => '400 - 800'},
      {:color => '#4292C6', :rank => '200 - 400'},
      {:color => '#6BAED6', :rank => '100 - 200'},
      {:color => '#9ECAE1', :rank => '500 - 100'},
      {:color => '#C6DBEF', :rank => '25 - 50'},
      {:color => '#EFF3FF', :rank => '< 25'},
      {:color => no_data_color, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_district_population_color(count)
    case 
    when count > 1600
      district_population_colors[0][:color]
    when (801..1600).include?(count)
      district_population_colors[1][:color]
    when (401..800).include?(count)
      district_population_colors[2][:color]
    when (201..400).include?(count)
      district_population_colors[3][:color]
    when (101..200).include?(count)
      district_population_colors[4][:color]
    when (51..100).include?(count)
      district_population_colors[5][:color]
    when (26..50).include?(count)
      district_population_colors[6][:color]
    else
      district_population_colors[7][:color]
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
          item['color'] = get_full_name_population_color(data_record[:count])
          item['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record[:permalink], :locale => I18n.locale)
        else
          # no data exists
          item['count'] = no_data_text
          item['count_formatted'] = no_data_text
          item['color'] = no_data_color
          item['url'] = nil
        end
      end
    end

    return json
  end
  
  # array of population colors
  def self.full_name_population_colors
    [
      {:color => '#000000', :rank => '> 100'},
      {:color => '#084594', :rank => '50 - 100'},
      {:color => '#2171B5', :rank => '25 - 50'},
      {:color => '#4292C6', :rank => '20 - 25'},
      {:color => '#6BAED6', :rank => '15 - 20'},
      {:color => '#9ECAE1', :rank => '10 - 15'},
      {:color => '#C6DBEF', :rank => '5 - 10'},
      {:color => '#EFF3FF', :rank => '< 5'},
      {:color => no_data_color, :rank => no_data_text}
    ]
  end
    
  # get the color that corresponds to the population value
  def self.get_full_name_population_color(count)
    case 
    when count > 100
      full_name_population_colors[0][:color]
    when (51..100).include?(count)
      full_name_population_colors[1][:color]
    when (26..50).include?(count)
      full_name_population_colors[2][:color]
    when (21..25).include?(count)
      full_name_population_colors[3][:color]
    when (16..20).include?(count)
      full_name_population_colors[4][:color]
    when (11..15).include?(count)
      full_name_population_colors[5][:color]
    when (6..10).include?(count)
      full_name_population_colors[6][:color]
    else
      full_name_population_colors[7][:color]
    end
  end  
  
end
