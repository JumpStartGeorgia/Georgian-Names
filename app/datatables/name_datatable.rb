class NameDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, :number_with_delimiter, to: :@view
  delegate :name_type, to: :@name_type
  delegate :name_id, to: :@name_id

  def initialize(view, name_type, name_id)
    @view = view
    @name_type = name_type
    @name_id = name_id
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Person.by_name(@name_type, @name_id).count,
      iTotalDisplayRecords: people.total_entries,
      aaData: data
    }
  end

private

  def data
    people.map do |person|
      [
        name_link(person),
        number_with_delimiter(person.count)
      ]
    end
  end

  def people
    @people ||= fetch_people
  end

  def name_link (person)
    if @name_type.to_s == Name::TYPE[:first_name].to_s
      link_to person.last_name.name, last_name_path(:name => person.last_name.permalink, :locale => I18n.locale)
    elsif  @name_type.to_s == Name::TYPE[:last_name].to_s
      link_to person.first_name.name, first_name_path(:name => person.first_name.permalink, :locale => I18n.locale)
    end
  end

  def fetch_people
    people = Person.by_name(@name_type, @name_id).order("#{sort_column} #{sort_direction}")
    people = people.page(page).per_page(per_page)
    if params[:sSearch].present?
      people = people.where("names.name like :search", search: "%#{params[:sSearch]}%")
    end
    people
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[names.name people.count]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
