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
    x = Name.find_by_id(@name_id)
    if x
      if @name_type.to_s == Name::TYPE[:first_name].to_s
        link_to person.last_name.name, full_name_path(:first_name => x.permalink, :last_name => person.last_name.permalink, :locale => I18n.locale)
      elsif  @name_type.to_s == Name::TYPE[:last_name].to_s
        link_to person.first_name.name, full_name_path(:first_name => person.first_name.permalink, :last_name => x.permalink, :locale => I18n.locale)
      end
    else
      if @name_type.to_s == Name::TYPE[:first_name].to_s
        link_to person.last_name.name, last_name_path(:name => person.last_name.permalink, :locale => I18n.locale)
      elsif  @name_type.to_s == Name::TYPE[:last_name].to_s
        link_to person.first_name.name, first_name_path(:name => person.first_name.permalink, :locale => I18n.locale)
      end
    end
  end

  def name_name_field
    if I18n.locale == :ka
      "names.name"
    else
      "names.name_en"
    end
  end

  def fetch_people
    people = Person.by_name(@name_type, @name_id).order("#{sort_column} #{sort_direction}")
    people = people.page(page).per_page(per_page)
    if params[:sSearch].present?
      people = people.where("#{name_name_field} like :search", search: "%#{params[:sSearch].strip}%")
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
    columns = %w[name people.count]
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
