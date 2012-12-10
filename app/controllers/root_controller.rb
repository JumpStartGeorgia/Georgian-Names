# encoding: utf-8
class RootController < ApplicationController
  require 'utf8_converter'
  require 'add_data_to_json'
  
  def index
    @top_first = Name.top_first_names
    @top_last = Name.top_last_names
    @total_first = NameTotal.first_name
    @total_last = NameTotal.last_name
    @population = NameTotal.district_population.map{|x| {:district_id => x.identifier, :district_name => "???", 
		  :permalink => "#", :count => x.count}}
    
    pop = NameTotal.birth_year_population
    pop_sum = pop.map{|x| x.count}.inject(:+)
    gon.chart_age_population = true
    gon.chart_age_pop_title = 'Age of the Population'
    gon.chart_age_pop_subtitle = "Total Population: #{view_context.number_with_delimiter(pop_sum)}"
    gon.chart_age_pop_xaxis = 'Birth Year<br />(Age)'
    gon.chart_age_pop_yaxis = '# of People'
    gon.chart_age_pop_data = pop.map{|x| [x.identifier, x.count]}

    gon.chart_top_fnames = true
    gon.chart_top_fnames_id = 'chart_top_fnames'
    gon.chart_top_fnames_title = 'Top 10 First Names'
    gon.chart_top_fnames_subtitle = "Total First Names: #{view_context.number_with_delimiter(@total_first)}"
    gon.chart_top_fnames_yaxis = 'Number of People with First Name'
    gon.chart_top_fnames_yaxis_names = @top_first.map{|x| x.name}
    gon.chart_top_fnames_yaxis_data = @top_first.map{|x| x.count}
    gon.chart_top_fnames_link_names = @top_first.map{|x| x.permalink}

    gon.chart_top_lnames = true
    gon.chart_top_lnames_id = 'chart_top_lnames'
    gon.chart_top_lnames_title = 'Top 10 Last Names'
    gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(@total_last)}"
    gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
    gon.chart_top_lnames_yaxis_names = @top_last.map{|x| x.name}
    gon.chart_top_lnames_yaxis_data = @top_last.map{|x| x.count}
    gon.chart_top_lnames_link_names = @top_last.map{|x| x.permalink}


    # get shape json and add data to json
    json = JSON.parse(File.open("#{Rails.root}/public/geo_districts.json", "r") {|f| f.read()})
    AddDataToJson.population(json,@population)
    
    gon.map_population_json = json
    gon.map_title = "Population by District"
    gon.map_sub_title1 = "Overall Total: #{view_context.number_with_delimiter(pop_sum)}"
    @color_legend = AddDataToJson.population_colors

  end

  def first_name
    @type = Name::TYPE[:first_name]
    @name = Name.by_first_name(params[:name])
    load_name_variables
    render :name
  end

  def last_name
    @type = Name::TYPE[:last_name]
    @name = Name.by_last_name(params[:name])
    load_name_variables

    render :name
  end

  def search_first_name
    @type = Name::TYPE[:first_name]
    en_name = Utf8Converter.convert_ka_to_en(params[:name])
    @name = Name.search_by_first_name(en_name)

    if @name
      redirect_to first_name_path(@name.permalink) 
    else
      render :name
    end
  end

  def search_last_name
    @type = Name::TYPE[:last_name]
    en_name = Utf8Converter.convert_ka_to_en(params[:name])
    @name = Name.search_by_last_name(en_name)

    if @name
      redirect_to last_name_path(@name.permalink) 
    else
      render :name
    end
  end

  def year
    @year_first_names = BirthYear.by_year(params[:id], Name::TYPE[:first_name])
    @total_first = NameTotal.first_name_birth_year(params[:id])
    @year_last_names = BirthYear.by_year(params[:id], Name::TYPE[:last_name])
    @total_last = NameTotal.last_name_birth_year(params[:id])
    @population = NameTotal.birth_year_population(params[:id])

    gon.chart_top_fnames = true
    gon.chart_top_fnames_id = 'chart_top_fnames'
    gon.chart_top_fnames_title = 'Top 10 First Names'
    gon.chart_top_fnames_subtitle = "Total First Names: #{view_context.number_with_delimiter(@total_first.count)}"
    gon.chart_top_fnames_yaxis = 'Number of People with First Name'
    gon.chart_top_fnames_yaxis_names = @year_first_names.map{|x| x.name.name}
    gon.chart_top_fnames_link_names = @year_first_names.map{|x| x.name.permalink}
    gon.chart_top_fnames_yaxis_data = @year_first_names.map{|x| x.count}

    gon.chart_top_lnames = true
    gon.chart_top_lnames_id = 'chart_top_lnames'
    gon.chart_top_lnames_title = 'Top 10 Last Names'
    gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(@total_last.count)}"
    gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
    gon.chart_top_lnames_yaxis_names = @year_last_names.map{|x| x.name.name}
    gon.chart_top_lnames_link_names = @year_last_names.map{|x| x.name.permalink}
    gon.chart_top_lnames_yaxis_data = @year_last_names.map{|x| x.count}

  end

  def district
    @district = DistrictName.find_by_name_en(params[:id])
    if @district
      @district_first_names = District.by_district(@district.id, Name::TYPE[:first_name])
      @total_first = NameTotal.first_name_district(@district.id)
      @district_last_names = District.by_district(@district.id, Name::TYPE[:last_name])
      @total_last = NameTotal.last_name_district(@district.id)
      @population = NameTotal.district_population(@district.id)

      gon.chart_top_fnames = true
      gon.chart_top_fnames_id = 'chart_top_fnames'
      gon.chart_top_fnames_title = 'Top 10 First Names'
      gon.chart_top_fnames_subtitle = "Total First Names: #{view_context.number_with_delimiter(@total_first.count)}"
      gon.chart_top_fnames_yaxis = 'Number of People with First Name'
      gon.chart_top_fnames_yaxis_names = @district_first_names.map{|x| x.name.name}
      gon.chart_top_fnames_link_names = @district_first_names.map{|x| x.name.permalink}
      gon.chart_top_fnames_yaxis_data = @district_first_names.map{|x| x.count}

      gon.chart_top_lnames = true
      gon.chart_top_lnames_id = 'chart_top_lnames'
      gon.chart_top_lnames_title = 'Top 10 Last Names'
      gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(@total_last.count)}"
      gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
      gon.chart_top_lnames_yaxis_names = @district_last_names.map{|x| x.name.name}
      gon.chart_top_lnames_link_names = @district_last_names.map{|x| x.name.permalink}
      gon.chart_top_lnames_yaxis_data = @district_last_names.map{|x| x.count}
    end
  end

  protected
  def load_name_variables
    if @name
      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts

      # get shape json and add data to json
      json = JSON.parse(File.open("#{Rails.root}/public/geo_districts.json", "r") {|f| f.read()})
      AddDataToJson.rank(json,@districts)

      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_rank_data = years_array.map{|x| [x[0], x[2], x[1]]}
      gon.chart_age_pop_title = "Number of '#{@name.name}' With a Given Age"
      gon.chart_age_pop_subtitle = "Number of '#{@name.name}': #{view_context.number_with_delimiter(@name.count)}"
      gon.chart_age_pop_xaxis = 'Birth Year<br />(Age)'
      gon.chart_age_pop_yaxis = '# of People'
      gon.chart_age_pop_yaxis2 = 'Name Rank'
      
      gon.map_name_json = json
      gon.map_title = "'#{@name.name}' Rank by District"
      gon.map_sub_title1 = "Overall Rank: #{view_context.number_with_delimiter(@name.rank)}"
      gon.map_sub_title2 = "Overall Total: #{view_context.number_with_delimiter(@name.count)}"
      @color_legend = AddDataToJson.rank_colors
    end
  end
  
end
