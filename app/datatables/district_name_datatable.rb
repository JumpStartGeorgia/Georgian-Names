class DistrictNameDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: DistrictName.count,
      iTotalDisplayRecords: district_names.total_entries,
      aaData: data
    }
  end

private

  def data
    district_names.map do |district_name|
      [
        link_to(district_name.name, "#"),
        h(district_name.name_en)
      ]
    end
  end

  def district_names
    @district_names ||= fetch_district_names
  end

  def fetch_district_names
    district_names = DistrictName.order("#{sort_column} #{sort_direction}")
    district_names = district_names.page(page).per_page(per_page)
    if params[:sSearch].present?
      district_names = district_names.where("name like :search or name_en like :search", search: "%#{params[:sSearch]}%")
    end
    district_names
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name name_en]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end