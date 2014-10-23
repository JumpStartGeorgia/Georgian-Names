class DistrictDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, :number_with_delimiter, to: :@view
  delegate :name_id, to: :@name_id

  def initialize(view, name_id)
    @view = view
    @name_id = name_id
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: District.by_name(@name_id).count,
      iTotalDisplayRecords: districts.total_entries,
      aaData: data
    }
  end

private

  def data
    districts.map do |district|
      [
        link_to(district.district_name.name, district_path(:id => district.district_name.permalink, :locale => I18n.locale)),
        number_with_delimiter(district.count),
        number_with_delimiter(district.rank)
      ]
    end
  end

  def districts
    @districts ||= fetch_districts
  end

  def district_name_field
    if I18n.locale == :ka
      "district_names.name"
    else
      "district_names.name_en"
    end
  end

  def fetch_districts
    districts = District.by_name(@name_id).order("#{sort_column} #{sort_direction}")
    districts = districts.page(page).per_page(per_page)
    if params[:sSearch].present?
      districts = districts.where("#{district_name_field} like :search", search: "%#{params[:sSearch].strip}%")
    end
    districts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name districts.count districts.rank]
    # name sure the sorting of name is done for the correct language
    if params[:iSortCol_0].to_i == 0
      district_name_field
    else
      columns[params[:iSortCol_0].to_i]
    end
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
