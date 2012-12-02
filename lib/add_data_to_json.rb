module AddDataToJson
  
  def self.rank(json, data)
    if json && data && !data.empty?
      json['features'].each do |value|
        if value['properties']['district_id'] == 0
          value['properties']['rank'] = 'No Data'
          value['properties']['count'] = 'No Data'
          value['properties']['color'] = '#666666'
        else
          data_record = data.select{|x| x[:district_id] == value['properties']['district_id']}
          if data_record && !data_record.empty?
            value['properties']['rank'] = data_record.first[:rank]
            value['properties']['count'] = data_record.first[:count]
            value['properties']['color'] = get_rank_color(data_record.first[:rank])
          else
            # no data exists
            value['properties']['rank'] = 'No Data'
            value['properties']['count'] = 'No Data'
            value['properties']['color'] = '#666666'
          end
        end
      end
    end
  end
  
  # array of rank colors
  def self.rank_colors
    [
      {:color => '#D9D919', :rank => '1'},
      {:color => '#C0C0C0', :rank => '2'},
      {:color => '#8C7853', :rank => '3'},
      {:color => '#084594', :rank => '4-9'},
      {:color => '#2171B5', :rank => '10-19'},
      {:color => '#4292C6', :rank => '20-29'},
      {:color => '#6BAED6', :rank => '30-39'},
      {:color => '#9ECAE1', :rank => '40-49'},
      {:color => '#C6DBEF', :rank => '50-99'},
      {:color => '#EFF3FF', :rank => '> 100'},
      {:color => '#666666', :rank => 'No Data'}
    ]
  end
  
  # get the color that corresponds to the rank value
  def self.get_rank_color(rank)
    case rank
    when 1
      '#D9D919' #gold
    when 2
      '#C0C0C0' #silver
    when 3
      '#8C7853' #bronze
    when 4..9
      '#084594'
    when 10..19
      '#2171B5'
    when 20..29
      '#4292C6'
    when 30..39
      '#6BAED6'
    when 40..49
      '#9ECAE1'
    when 50..99
      '#C6DBEF'
    else
      '#EFF3FF'
    end
  end
  
end
