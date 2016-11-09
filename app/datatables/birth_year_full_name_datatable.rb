class BirthYearFullNameDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, :number_with_delimiter, to: :@view
  delegate :first_name_id, to: :@first_name_id
  delegate :last_name_id, to: :@last_name_id

  def initialize(view, first_name_id, last_name_id)
    @view = view
    @first_name_id = first_name_id
    @last_name_id = last_name_id
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Mapping.birth_years(@first_name_id, @last_name_id).count,
      iTotalDisplayRecords: birth_years.total_entries,
      aaData: data
    }
  end

private

  def data
    birth_years.map do |birth_year|
      [
        link_to(birth_year.birth_year, year_path(:id => birth_year.birth_year, :locale => I18n.locale)),
        (2016 - birth_year.birth_year),
        number_with_delimiter(birth_year.count)
      ]
    end
  end

  def birth_years
    @birth_years ||= fetch_birth_years
  end

  def fetch_birth_years
    birth_years = Mapping.birth_years(@first_name_id, @last_name_id).order("#{sort_column} #{sort_direction}")
    birth_years = birth_years.page(page).per_page(per_page)
    if params[:sSearch].present?
      birth_years = birth_years.where("birth_year like :search", search: "%#{params[:sSearch].strip}%")
    end
    birth_years
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[mappings.birth_year mappings.birth_year count(*)]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    # if the sort column is the age, reverse the sort order of birth year
    if params[:iSortCol_0].to_i == 1
      params[:sSortDir_0] == "desc" ? "asc" : "desc"
    else
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
  end
end
