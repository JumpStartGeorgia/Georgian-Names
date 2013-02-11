class DistrictFullNameDatatable
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
      iTotalRecords: Mapping.districts(@first_name_id, @last_name_id).count,
      iTotalDisplayRecords: districts.total_entries,
      aaData: data
    }
  end

private

  def data
    districts.map do |district|
      [
        link_to(district.district_name, district_path(:id => district.district_permalink, :locale => I18n.locale)),
        number_with_delimiter(district.count)
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
    districts = Mapping.districts(@first_name_id, @last_name_id).order("#{sort_column} #{sort_direction}")
    districts = districts.page(page).per_page(per_page)
    if params[:sSearch].present?
      districts = districts.where("#{district_name_field} like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[name count(*)]
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
