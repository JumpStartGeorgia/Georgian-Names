module AddDataToJson
 
  def self.no_data_color
    "#999999"
  end
  
  def self.no_data_text
    I18n.t('app.common.no_data')
  end
  
  def self.rank(json, data)
    if json && data && !data.empty?
      json['features'].each do |value|
        if value['properties']['district_id'] == 0
          value['properties']['rank'] = no_data_text
          value['properties']['rank_formatted'] = no_data_text
          value['properties']['count'] = no_data_text
          value['properties']['count_formatted'] = no_data_text
          value['properties']['color'] = no_data_color
          value['properties']['url'] = nil
        else
          data_record = data.select{|x| x[:district_id] == value['properties']['district_id']}
          if data_record && !data_record.empty?
            value['properties']['district_name'] = data_record.first[:district_name]
            value['properties']['rank'] = data_record.first[:rank]
            value['properties']['rank_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record.first[:rank])
            value['properties']['count'] = data_record.first[:count]
            value['properties']['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record.first[:count])
            value['properties']['color'] = get_rank_color(data_record.first[:rank])
            value['properties']['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record.first[:permalink], :locale => I18n.locale)
          else
            # no data exists
            value['properties']['rank'] = no_data_text
            value['properties']['rank_formatted'] = no_data_text
            value['properties']['count'] = no_data_text
            value['properties']['count_formatted'] = no_data_text
            value['properties']['color'] = no_data_color
            value['properties']['url'] = nil
          end
        end
      end
    end
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
  
  def self.population(json, data)
    if json && data && !data.empty?
      json['features'].each do |value|
        if value['properties']['district_id'] == 0
          value['properties']['count'] = no_data_text
          value['properties']['count_formatted'] = no_data_text
          value['properties']['color'] = no_data_color
          value['properties']['url'] = nil
        else
          data_record = data.select{|x| x[:district_id] == value['properties']['district_id']}
          if data_record && !data_record.empty?
            value['properties']['district_name'] = data_record.first[:district_name]
            value['properties']['count'] = data_record.first[:count]
            value['properties']['count_formatted'] = ActionController::Base.helpers.number_with_delimiter(data_record.first[:count])
            value['properties']['color'] = get_population_color(data_record.first[:count])
            value['properties']['url'] = Rails.application.routes.url_helpers.district_path(:id => data_record.first[:permalink], :locale => I18n.locale)
          else
            # no data exists
            value['properties']['count'] = no_data_text
            value['properties']['count_formatted'] = no_data_text
            value['properties']['color'] = no_data_color
            value['properties']['url'] = nil
          end
        end
      end
    end
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
  
end
