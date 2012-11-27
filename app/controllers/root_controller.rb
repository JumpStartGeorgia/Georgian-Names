# encoding: utf-8
class RootController < ApplicationController

  def index
#    @top_first = Name.top_first_names
#    @top_last = Name.top_last_names
#    @total_first = NameTotal.first_name
#    @total_last = NameTotal.last_name
 
    gon.chart_age_population = true
    gon.chart_age_pop_title = 'Number of People With a Given Age'
    gon.chart_age_pop_subtitle = "Total Population: #{view_context.number_with_delimiter(3613745)}"
    gon.chart_age_pop_xaxis = 'Age'
    gon.chart_age_pop_yaxis = '# of People'
    gon.chart_age_pop_data = [[18,42850],[19,59001],[20,68182],[21,74925],[22,75672],[23,69809],[24,68939],[25,71047],[26,73454],[27,73829],[28,72392],[29,69648],[30,69192],[31,69375],[32,67751],[33,67944],[34,67474],[35,66598],[36,66953],[37,65382],[38,64878],[39,63752],[40,62199],[41,64212],[42,63640],[43,61066],[44,62040],[45,60408],[46,62256],[47,64286],[48,66877],[49,68732],[50,69323],[51,70601],[52,70872],[53,66918],[54,64000],[55,60775],[56,60415],[57,58476],[58,56368],[59,49760],[60,53784],[61,49498],[62,49554],[63,46895],[64,41951],[65,41399],[66,34289],[67,26241],[68,22138],[69,18400],[70,29441],[71,35920],[72,43752],[73,39291],[74,40185],[75,38062],[76,32114],[77,28688],[78,23329],[79,21638],[80,22827],[81,17456],[82,20388],[83,15616],[84,15687],[85,12475],[86,10081],[87,8269],[88,5791],[89,4065],[90,3286],[91,2010],[92,2299],[93,1069],[94,999],[95,564],[96,468],[97,437],[98,299],[99,197],[100,194],[101,56],[102,130],[103,46],[104,45],[105,34],[106,33],[107,26],[108,12],[109,7],[110,12],[111,7],[112,11],[113,1],[115,2],[116,1],[118,1],[122,2],[129,1],[132,1]]
    

    gon.chart_top_fnames = true
    gon.chart_top_fnames_id = 'chart_top_fnames'
    gon.chart_top_fnames_title = 'Top 10 First Names'
    gon.chart_top_fnames_subtitle = "Total First Names: #{view_context.number_with_delimiter(47180)}"
    gon.chart_top_fnames_yaxis = 'Number of People with First Name'
    gon.chart_top_fnames_yaxis_names = ['გიორგი', 'ნინო', 'დავით', 'მაია', 'თამარ', 'ნანა', 'მანანა', 'ნათელა', 'ნათია', 'ზურაბ']
    gon.chart_top_fnames_yaxis_data = [115360, 81036, 48721, 44442, 43021, 37315, 33257, 31958, 30364, 28741]

    gon.chart_top_lnames = true
    gon.chart_top_lnames_id = 'chart_top_lnames'
    gon.chart_top_lnames_title = 'Top 10 Last Names'
    gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(74481)}"
    gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
    gon.chart_top_lnames_yaxis_names = ['ბერიძე', 'კაპანაძე', 'გელაშვილი', 'მაისურაძე', 'გიორგაძე', 'მამედოვი', 'წიკლაური', 'ლომიძე', 'მამედოვა', 'ბოლქვაძე']
    gon.chart_top_lnames_yaxis_data = [21033, 14449, 13912, 12586, 10827, 10250, 9977, 9977, 9184, 9152]
  end

  def first_name
    @type = Name::TYPE[:first_name]
    @name = Name.by_first_name(params[:name])
    if @name
      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts
    
      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_pop_title = "Number of #{params[:name]} With a Given Age"
      gon.chart_age_pop_subtitle = "Number of #{params[:name]}: #{view_context.number_with_delimiter(@name.count)}"
      gon.chart_age_pop_xaxis = 'Age'
      gon.chart_age_pop_yaxis = '# of People'
    end

    render :name
  end
  
  def last_name 
    @type = Name::TYPE[:last_name]
    @name = Name.by_last_name(params[:name])

    if @name
      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts
    
      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_pop_title = "Number of #{params[:name]} With a Given Age"
      gon.chart_age_pop_subtitle = "Number of #{params[:name]}: #{view_context.number_with_delimiter(@name.count)}"
      gon.chart_age_pop_xaxis = 'Age'
      gon.chart_age_pop_yaxis = '# of People'
    end
    
    render :name
  end

  def search_first_name
    @type = Name::TYPE[:first_name]
    @name = Name.by_first_name(params[:name])

    if @name
      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts
    
      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_pop_title = "Number of #{params[:name]} With a Given Age"
      gon.chart_age_pop_subtitle = "Number of #{params[:name]}: #{view_context.number_with_delimiter(@name.count)}"
      gon.chart_age_pop_xaxis = 'Age'
      gon.chart_age_pop_yaxis = '# of People'
    end

    render :name
  end
  
  def search_last_name 
    @type = Name::TYPE[:last_name]
    @name = Name.by_last_name(params[:name])
    if @name
      @birth_years = @name.by_years_hash
      years_array = @name.by_age_array
      @districts = @name.by_districts
    
      gon.chart_age_population = true
      gon.chart_age_pop_data = years_array
      gon.chart_age_pop_title = "Number of #{params[:name]} With a Given Age"
      gon.chart_age_pop_subtitle = "Number of #{params[:name]}: #{view_context.number_with_delimiter(@name.count)}"
      gon.chart_age_pop_xaxis = 'Age'
      gon.chart_age_pop_yaxis = '# of People'
    end

    render :name
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
    gon.chart_top_fnames_yaxis_data = @year_first_names.map{|x| x.count}

    gon.chart_top_lnames = true
    gon.chart_top_lnames_id = 'chart_top_lnames'
    gon.chart_top_lnames_title = 'Top 10 Last Names'
    gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(@total_last.count)}"
    gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
    gon.chart_top_lnames_yaxis_names = @year_last_names.map{|x| x.name.name}
    gon.chart_top_lnames_yaxis_data = @year_last_names.map{|x| x.count}

  end
  
  def district 
    @district = DistrictName.find_by_name(params[:id])
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
      gon.chart_top_fnames_yaxis_data = @district_first_names.map{|x| x.count}

      gon.chart_top_lnames = true
      gon.chart_top_lnames_id = 'chart_top_lnames'
      gon.chart_top_lnames_title = 'Top 10 Last Names'
      gon.chart_top_lnames_subtitle = "Total Last Names: #{view_context.number_with_delimiter(@total_last.count)}"
      gon.chart_top_lnames_yaxis = 'Number of People with Last Name'
      gon.chart_top_lnames_yaxis_names = @district_last_names.map{|x| x.name.name}
      gon.chart_top_lnames_yaxis_data = @district_last_names.map{|x| x.count}
    end
  end


end
