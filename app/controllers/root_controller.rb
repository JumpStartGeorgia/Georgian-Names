class RootController < ApplicationController

  def index
    @top_first = Name.top_first_names
    @top_last = Name.top_last_names
    @total_first = NameTotal.first_name
    @total_last = NameTotal.last_name
  end

  def first_name
    @type = Name::TYPE[:first]
    @name = Name.by_first_name(params[:id])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name

    render :name
  end
  
  def last_name 
    @type = Name::TYPE[:last]
    @name = Name.by_last_name(params[:id])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name
    
    render :name
  end

  def search_first_name
    @type = Name::TYPE[:first]
    @name = Name.by_first_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name

    render :name
  end
  
  def search_last_name 
    @type = Name::TYPE[:last]
    @name = Name.by_last_name(params[:name])
    @birth_years = @name.by_years if @name
    @districts = @name.by_districts if @name
    
    render :name
  end

  def year
    @first_names = BirthYear.by_year(params[:id], Name::TYPE[:first_name])
    @total_first_name = NameTotal.first_name_birth_year(params[:id])
    @last_names = BirthYear.by_year(params[:id], Name::TYPE[:last_name])
    @total_last_name = NameTotal.last_name_birth_year(params[:id])

    render :name
  end
  
  def district 
    @first_names = District.by_district(params[:id], Name::TYPE[:first_name])
    @total_first_name = NameTotal.first_name_district(params[:id])
    @last_names = District.by_district(params[:id], Name::TYPE[:last_name])
    @total_last_name = NameTotal.last_name_district(params[:id])
    
    render :name
  end


end
