class RootController < ApplicationController

  def index
    @top_first = Name.top_first_names
    @top_last = Name.top_last_names
    @total_first = NameTotal.first_name
    @total_last = NameTotal.last_name
  end

  def first_name
    @type = Name::TYPE[:first_name]
    @name = Name.by_first_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name

    render :name
  end
  
  def last_name 
    @type = Name::TYPE[:last_name]
    @name = Name.by_last_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name
    
    render :name
  end

  def search_first_name
    @type = Name::TYPE[:first_name]
    @name = Name.by_first_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name

    render :name
  end
  
  def search_last_name 
    @type = Name::TYPE[:last_name]
    @name = Name.by_last_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name
    logger.debug "type = #{@type}"
    render :name
  end

  def year
    @year_first_names = BirthYear.by_year(params[:id], Name::TYPE[:first_name])
    @total_first = NameTotal.first_name_birth_year(params[:id])
    @year_last_names = BirthYear.by_year(params[:id], Name::TYPE[:last_name])
    @total_last = NameTotal.last_name_birth_year(params[:id])
    @population = NameTotal.birth_year_population(params[:id])
  end
  
  def district 
    @district = DistrictName.find_by_name(params[:id])
    if @district
      @district_first_names = District.by_district(@district.id, Name::TYPE[:first_name])
      @total_first = NameTotal.first_name_district(@district.id)
      @district_last_names = District.by_district(@district.id, Name::TYPE[:last_name])
      @total_last = NameTotal.last_name_district(@district.id)
      @population = NameTotal.district_population(@district.id)
    end
  end


end
