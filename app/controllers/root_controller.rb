# encoding: utf-8
class RootController < ApplicationController
  require 'utf8_converter'
  require 'generate_json'
  require 'add_data_to_json'  

  def index
    @top_first = Name.top_first_names
    @top_last = Name.top_last_names
    @total_first = NameTotal.first_name
    @total_last = NameTotal.last_name

    
    pop = NameTotal.birth_year_population
    pop_sum = pop.map{|x| x.count}.inject(:+)
    gon.chart_age_population = true
    gon.chart_age_pop_title = I18n.t('charts.population.all.title')
    gon.chart_age_pop_subtitle = I18n.t('charts.population.all.subtitle', :count => view_context.number_with_delimiter(pop_sum))
    gon.chart_age_pop_xaxis = "#{I18n.t('charts.population.all.xaxis1')} (#{I18n.t('charts.population.all.xaxis2')})"
    gon.chart_age_pop_yaxis = I18n.t('charts.population.all.yaxis')
    gon.chart_age_pop_popup_total = I18n.t('charts.population.total')
    gon.chart_age_pop_popup_rank = I18n.t('charts.population.rank')
    gon.chart_age_pop_popup_years_old = I18n.t('charts.population.years_old')
    gon.chart_age_pop_popup_birth_year = I18n.t('charts.population.birth_year')
    gon.chart_age_pop_data = pop.map{|x| [x.identifier, x.count]}

    gon.chart_top_fnames = true
    gon.chart_top_fnames_id = 'chart_top_fnames'
    gon.chart_top_fnames_title = I18n.t('charts.name.all.first.title')
    gon.chart_top_fnames_subtitle = I18n.t('charts.name.all.first.subtitle', :count => view_context.number_with_delimiter(@total_first.count))
    gon.chart_top_fnames_yaxis = I18n.t('charts.name.all.first.yaxis')
    gon.chart_top_fnames_yaxis_names = @top_first.map{|x| x.name}
    gon.chart_top_fnames_yaxis_data = @top_first.map{|x| x.count}
    gon.chart_top_fnames_link_names = @top_first.map{|x| x.permalink}

    gon.chart_top_lnames = true
    gon.chart_top_lnames_id = 'chart_top_lnames'
    gon.chart_top_lnames_title = I18n.t('charts.name.all.last.title')
    gon.chart_top_lnames_subtitle = I18n.t('charts.name.all.last.subtitle', :count => view_context.number_with_delimiter(@total_last.count))
    gon.chart_top_lnames_yaxis = I18n.t('charts.name.all.last.yaxis')
    gon.chart_top_lnames_yaxis_names = @top_last.map{|x| x.name}
    gon.chart_top_lnames_yaxis_data = @top_last.map{|x| x.count}
    gon.chart_top_lnames_link_names = @top_last.map{|x| x.permalink}


    # get shape json and add data to json
    district_names = DistrictName.all
    @population = []    
    NameTotal.district_population.each do |count|
      index = district_names.index{|x| x.id == count.identifier}
      @population << {:district_id => count.identifier, :district_name => district_names[index].name, :permalink => district_names[index].permalink, :count => count.count} if index
    end

    if @is_ie
      json = JSON.parse(File.open("#{Rails.root}/public/districts.json", "r") {|f| f.read()})
      AddDataToJson.population(json,@population)
      gon.is_ie = true
    else
      json = GenerateJson.population(district_names,@population)
      gon.is_ie = false
    end
    
    gon.map_population_json_svg = json
    @map_title = I18n.t('charts.map.all.title')
    @map_sub_title1 = I18n.t('charts.map.all.subtitle1', :count => view_context.number_with_delimiter(pop_sum))
    @color_legend = GenerateJson.population_colors

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

  def full_name
    @first_name = Name.by_first_name(params[:first_name])
    @last_name = Name.by_last_name(params[:last_name])

    if @first_name && @last_name
      birth_years = Mapping.birth_years(@first_name.id, @last_name.id, true)
      districts = Mapping.districts(@first_name.id, @last_name.id, true)
      @full_name_count = birth_years.map{|x| x.count}.inject(:+)

      if birth_years.present?
        # build age chart
        years_array = birth_years.map{|x| [x.birth_year, x.count]}
        gon.chart_age_population = true
        gon.chart_age_pop_title = I18n.t('charts.population.full_name.title', :first_name => @first_name.name, :last_name => @last_name.name)
        gon.chart_age_pop_subtitle = I18n.t('charts.population.full_name.subtitle', :first_name => @first_name.name, :last_name => @last_name.name, :count => view_context.number_with_delimiter(@full_name_count))
        gon.chart_age_pop_xaxis = "#{I18n.t('charts.population.full_name.xaxis1')} (#{I18n.t('charts.population.full_name.xaxis2')})"
        gon.chart_age_pop_yaxis = I18n.t('charts.population.full_name.yaxis')
        gon.chart_age_pop_popup_total = I18n.t('charts.population.total')
        gon.chart_age_pop_popup_years_old = I18n.t('charts.population.years_old')
        gon.chart_age_pop_popup_birth_year = I18n.t('charts.population.birth_year')
        gon.chart_age_pop_data = years_array
      end
   
      if districts.present?
        # get shape json and add data to json
        district_names = DistrictName.all
        d = districts.map{|x| {:district_id => x.district_id, :district_name => x.district_name,
                		  :permalink => x.district_permalink, :count => x.count}}

        if @is_ie
          json = JSON.parse(File.open("#{Rails.root}/public/districts.json", "r") {|f| f.read()})
          AddDataToJson.full_name_population(json,d)
          gon.is_ie = true
        else
          json = GenerateJson.full_name_population(district_names,d)
          gon.is_ie = false
        end
        
        gon.map_population_json_svg = json
        @map_title = I18n.t('charts.map.name.title_full', :name => "#{@first_name.name} #{@last_name.name}")
        @map_sub_title1 = I18n.t('charts.map.name.subtitle2', :count => view_context.number_with_delimiter(@full_name_count))
        @color_legend = GenerateJson.full_name_population_colors

      end
    end
  end

  def search_name
    # do search across all names
    # - use name country data tables
    params[:q] = params[:q].gsub(/[^a-zA-Zა-ჰ\s]/, '').strip if params[:q].present?
    gon.initial_name_search = params[:q]
  end

  def year
    @year_first_names = BirthYear.top_names(params[:id], Name::TYPE[:first_name])
    @total_first = NameTotal.first_name_birth_year(params[:id])
    @year_last_names = BirthYear.top_names(params[:id], Name::TYPE[:last_name])
    @total_last = NameTotal.last_name_birth_year(params[:id])
    @population = NameTotal.birth_year_population(params[:id])
    district_years = DistrictYear.by_birth_year(params[:id])

    if !@year_first_names.blank?
      gon.chart_top_fnames = true
      gon.chart_top_fnames_id = 'chart_top_fnames'
      gon.chart_top_fnames_title = I18n.t('charts.name.birth_year.first.title', :year => params[:id])
      gon.chart_top_fnames_subtitle = I18n.t('charts.name.birth_year.first.subtitle', :count => view_context.number_with_delimiter(@total_first.count))
      gon.chart_top_fnames_yaxis = I18n.t('charts.name.birth_year.first.yaxis')
      gon.chart_top_fnames_yaxis_names = @year_first_names.map{|x| x.name.name}
      gon.chart_top_fnames_link_names = @year_first_names.map{|x| x.name.permalink}
      gon.chart_top_fnames_yaxis_data = @year_first_names.map{|x| x.count}
    end

    if !@year_last_names.blank?
      gon.chart_top_lnames = true
      gon.chart_top_lnames_id = 'chart_top_lnames'
      gon.chart_top_lnames_title = I18n.t('charts.name.birth_year.last.title', :year => params[:id])
      gon.chart_top_lnames_subtitle = I18n.t('charts.name.birth_year.last.subtitle', :count => view_context.number_with_delimiter(@total_last.count))
      gon.chart_top_lnames_yaxis = I18n.t('charts.name.birth_year.last.yaxis')
      gon.chart_top_lnames_yaxis_names = @year_last_names.map{|x| x.name.name}
      gon.chart_top_lnames_link_names = @year_last_names.map{|x| x.name.permalink}
      gon.chart_top_lnames_yaxis_data = @year_last_names.map{|x| x.count}
    end

    if !district_years.blank?
      # get shape json and add data to json
      district_names = DistrictName.all
      district_population = []    
      district_years.each do |count|
        index = district_names.index{|x| x.id == count.district_id}
        district_population << {:district_id => count.district_id, :district_name => district_names[index].name, :permalink => district_names[index].permalink, :count => count.count} if index
      end

      if @is_ie
        json = JSON.parse(File.open("#{Rails.root}/public/districts.json", "r") {|f| f.read()})
        AddDataToJson.year_population(json,district_population)
        gon.is_ie = true
      else
        json = GenerateJson.year_population(district_names,district_population)
        gon.is_ie = false
      end

      gon.map_population_json_svg = json
      @map_title = I18n.t('charts.map.year.title', :year => params[:id])
      @map_sub_title1 = I18n.t('charts.map.year.subtitle1', :year => params[:id], :count => view_context.number_with_delimiter(@population.count))
      @color_legend = GenerateJson.year_population_colors
    end
  end

  def district
    @district = DistrictName.find_by_name_en(params[:id])
    if @district
      @district_first_names = District.top_names(@district.id, Name::TYPE[:first_name])
      @total_first = NameTotal.first_name_district(@district.id)
      @district_last_names = District.top_names(@district.id, Name::TYPE[:last_name])
      @total_last = NameTotal.last_name_district(@district.id)
      @population = NameTotal.district_population(@district.id)

      gon.chart_top_fnames = true
      gon.chart_top_fnames_id = 'chart_top_fnames'
      gon.chart_top_fnames_title = I18n.t('charts.name.district.first.title', :name => @district.name)
      gon.chart_top_fnames_subtitle = I18n.t('charts.name.district.first.subtitle', :count => view_context.number_with_delimiter(@total_first.count))
      gon.chart_top_fnames_yaxis = I18n.t('charts.name.district.first.yaxis')
      gon.chart_top_fnames_yaxis_names = @district_first_names.map{|x| x.name.name}
      gon.chart_top_fnames_link_names = @district_first_names.map{|x| x.name.permalink}
      gon.chart_top_fnames_yaxis_data = @district_first_names.map{|x| x.count}

      gon.chart_top_lnames = true
      gon.chart_top_lnames_id = 'chart_top_lnames'
      gon.chart_top_lnames_title = I18n.t('charts.name.district.last.title', :name => @district.name)
      gon.chart_top_lnames_subtitle = I18n.t('charts.name.district.last.subtitle', :count => view_context.number_with_delimiter(@total_last.count))
      gon.chart_top_lnames_yaxis = I18n.t('charts.name.district.last.yaxis')
      gon.chart_top_lnames_yaxis_names = @district_last_names.map{|x| x.name.name}
      gon.chart_top_lnames_link_names = @district_last_names.map{|x| x.name.permalink}
      gon.chart_top_lnames_yaxis_data = @district_last_names.map{|x| x.count}

      pop = DistrictYear.by_district(@district.id)
      @district_count = pop.map{|x| x.count}.inject(:+)
      gon.chart_age_population = true
      gon.chart_age_pop_title = I18n.t('charts.population.district.title', :district => @district.name)
      gon.chart_age_pop_subtitle = I18n.t('charts.population.district.subtitle', :district => @district.name, :count => view_context.number_with_delimiter(@district_count))
      gon.chart_age_pop_xaxis = "#{I18n.t('charts.population.district.xaxis1')} (#{I18n.t('charts.population.district.xaxis2')})"
      gon.chart_age_pop_yaxis = I18n.t('charts.population.district.yaxis')
      gon.chart_age_pop_popup_total = I18n.t('charts.population.total')
      gon.chart_age_pop_popup_years_old = I18n.t('charts.population.years_old')
      gon.chart_age_pop_popup_birth_year = I18n.t('charts.population.birth_year')
      gon.chart_age_pop_data = pop.map{|x| [x.birth_year, x.count]}


    end
  end

  def download
    if params[:type] == 'csv'
      send_file "#{Rails.root}/public/system/georgian_names_csv.zip", :type => "application/zip", :disposition => 'inline'
    elsif params[:type] == 'excel'
      send_file "#{Rails.root}/public/system/georgian_names_excel.zip", :type => "application/zip", :disposition => 'inline'
    end
  end

  protected
  def load_name_variables
    if @name
      name_type = ''
      if @type == Name::TYPE[:first_name]
        name_type = 'first'
      elsif @type == Name::TYPE[:last_name]
        name_type = 'last'
      end

      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts
      
      # build age chart
      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_rank_data = years_array.map{|x| [x[0], x[2], x[1]]}
      gon.chart_age_pop_title = I18n.t("charts.population.name.title_#{name_type}", :name => @name.name)
      gon.chart_age_pop_subtitle = I18n.t("charts.population.name.subtitle_#{name_type}", :name => @name.name, :count => view_context.number_with_delimiter(@name.count))
      gon.chart_age_pop_xaxis = "#{I18n.t('charts.population.name.xaxis1')} (#{I18n.t('charts.population.name.xaxis2')})"
      gon.chart_age_pop_yaxis = I18n.t('charts.population.name.yaxis1')
      gon.chart_age_pop_yaxis2 = I18n.t("charts.population.name.yaxis2_#{name_type}")
      gon.chart_age_pop_popup_total = I18n.t('charts.population.total')
      gon.chart_age_pop_popup_rank = I18n.t("charts.population.rank_#{name_type}")
      gon.chart_age_pop_popup_years_old = I18n.t('charts.population.years_old')
      gon.chart_age_pop_popup_birth_year = I18n.t('charts.population.birth_year')
 
       # get shape json and add data to json
      district_names = DistrictName.all

      if @is_ie
        json = JSON.parse(File.open("#{Rails.root}/public/districts.json", "r") {|f| f.read()})
        AddDataToJson.district_population(json,@districts)
        gon.is_ie = true
      else
        json = GenerateJson.district_population(district_names,@districts)
        gon.is_ie = false
      end

      gon.map_name_json_svg = json
      @map_title = I18n.t("charts.map.name.title_#{name_type}", :name => @name.name)
      @map_sub_title1 = I18n.t('charts.map.name.subtitle2', :count => view_context.number_with_delimiter(@name.count))
      @map_sub_title2 = I18n.t('charts.map.name.subtitle1', :rank => view_context.number_with_delimiter(@name.rank))
      @color_legend = GenerateJson.district_population_colors
=begin
      # get top 10 related names
      type = nil
  		x = "placeholder"
      top_names = Person.top_names(@name.name_type, @name.id)
      names_count = Person.by_name(@name.name_type, @name.id).count

  		gon.last_name_path = last_name_path(x).gsub(x, "")
  	  if @name.name_type == Name::TYPE[:first_name]
        type = 'last_for_first'
  		  gon.name_path = last_name_path(x).gsub(x, "")
        gon.chart_top_names_yaxis_names = top_names.map{|x| x.last_name.name}
        gon.chart_top_names_link_names = top_names.map{|x| x.last_name.permalink}
  	  elsif @name.name_type == Name::TYPE[:last_name]
        type = 'first_for_last'
  		  gon.name_path = first_name_path(x).gsub(x, "")
        gon.chart_top_names_yaxis_names = top_names.map{|x| x.first_name.name}
        gon.chart_top_names_link_names = top_names.map{|x| x.first_name.permalink}
  	  end
      gon.chart_top_names_yaxis_data = top_names.map{|x| x.count}
      gon.chart_top_names = true
      gon.chart_top_names_id = 'chart_top_names'
      gon.chart_top_names_title = I18n.t("charts.name.#{type}.title", :name => @name.name)
      gon.chart_top_names_subtitle = I18n.t("charts.name.#{type}.subtitle", :count => view_context.number_with_delimiter(names_count))
      gon.chart_top_names_yaxis = I18n.t("charts.name.#{type}.yaxis", :name => @name.name)
=end
    end
  end
  
end
