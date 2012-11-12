class RootController < ApplicationController

  def index
    @top_first = Name.top_first_names
    @top_last = Name.top_last_names
  end

  def first_name
    @type = Name::TYPE[:first]
    @name = Name.by_first_name(params[:id])
    @birth_years = @name.by_years
    @districts = @name.by_districts

    render :name
  end
  
  def last_name 
    @type = Name::TYPE[:last]
    @name = Name.by_last_name(params[:id])
    @birth_years = @name.by_years
    @districts = @name.by_districts
    
    render :name
  end

end
