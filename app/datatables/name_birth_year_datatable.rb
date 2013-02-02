class NameBirthYearDatatable
  delegate :params, :h, :link_to, :number_to_currency, :number_with_delimiter, to: :@view
  delegate :birth_year, to: :@birth_year
  delegate :name_type, to: :@name_type

  def initialize(view, name_type, birth_year)
    @view = view
    @name_type = name_type
    @birth_year = birth_year
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: BirthYear.by_year(@birth_year, @name_type).count,
      iTotalDisplayRecords: names.total_entries,
      aaData: data
    }
  end

private

  def data
    names.map do |name|
      [
        name.name.name,
        number_with_delimiter(name.rank),
        number_with_delimiter(name.count)
      ]
    end
  end

  def names
    @names ||= fetch_names
  end

  def name_name_field
    if I18n.locale == :ka
      "names.name"
    else
      "names.name_en"
    end
  end


  def fetch_names
    names = BirthYear.by_year(@birth_year, @name_type).order("#{sort_column} #{sort_direction}")
    names = names.page(page).per_page(per_page)
    if params[:sSearch].present?
      names = names.where("#{name_name_field} like :search", search: "%#{params[:sSearch]}%")
    end
    names
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name birth_years.rank birth_years.count]
    # name sure the sorting of name is done for the correct language
    if params[:iSortCol_0].to_i == 0
      name_name_field
    else
      columns[params[:iSortCol_0].to_i]
    end
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
