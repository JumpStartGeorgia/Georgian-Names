# encoding: utf-8
class SearchController < ApplicationController
  
  def birth_years
    respond_to do |format|
      format.json { render json: BirthYearDatatable.new(view_context, params[:name_id]) }
    end
  end

  def districts
    respond_to do |format|
      format.json { render json: DistrictDatatable.new(view_context, params[:name_id]) }
    end
  end

  def names_country
    respond_to do |format|
      format.json { render json: NameCountryDatatable.new(view_context, params[:name_type]) }
    end
  end

  def names_birth_year
    respond_to do |format|
      format.json { render json: NameBirthYearDatatable.new(view_context, params[:name_type], params[:birth_year]) }
    end
  end

  def names_district
    respond_to do |format|
      format.json { render json: NameDistrictDatatable.new(view_context, params[:name_type], params[:district_id]) }
    end
  end

  def names
    respond_to do |format|
      format.json { render json: NameDatatable.new(view_context, params[:name_type], params[:name_id]) }
    end
  end

  def full_names
    respond_to do |format|
      format.json { render json: FullNameDatatable.new(view_context) }
    end
  end


end
