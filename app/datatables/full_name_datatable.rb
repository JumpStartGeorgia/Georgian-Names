class FullNameDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, :number_with_delimiter, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Person.by_full_name.count,
      iTotalDisplayRecords: people == [] ? 0 : people.total_entries,
      aaData: data
    }
  end

private

  def data
    people.map do |person|
      [
        link_to(I18n.t('helpers.links.view'), full_name_path(:first_name => person.first_name.permalink, :last_name => person.last_name.permalink, :locale => I18n.locale), :class => 'datatable_link'),
        person.first_name.name,
        person.last_name.name,
        number_with_delimiter(person.count)
      ]
    end
  end

  def people
    @people ||= fetch_people
  end

  def first_name_field
    if I18n.locale == :ka
      "names.name"
    else
      "names.name_en"
    end
  end

  def last_name_field
    if I18n.locale == :ka
      "last_names_people.name"
    else
      "last_names_people.name_en"
    end
  end

  # only include the text before the first space
  def first_name_value
    names = params[:sSearch].split(' ')
    name = ''
    if names.length > 1
      name = names[0]
    end
    return name
  end

  # include all text after the first space
  def last_name_value
    names = params[:sSearch].split(' ')
    name = ''
    if names.length > 1
      name = names[1..names.length-1].join(' ')
    end
    return name
  end

  def fetch_people
    people = []
    if params[:sSearch].present? && params[:sSearch].index(' ')
      people = Person.by_full_name.order("#{sort_column} #{sort_direction}")
      people = people.page(page).per_page(per_page)
      people = people.where(["#{first_name_field} like :first_search and #{last_name_field} like :last_search", 
                :first_search => "%#{first_name_value}%", :last_search => "%#{last_name_value}%"])
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
    columns = %w[nothing first_name_field last_name_field people.count]
    # person sure the sorting of person is done for the correct language
    if params[:iSortCol_0].to_i == 1
      first_name_field
    elsif params[:iSortCol_0].to_i == 2
      last_name_field
    else
      columns[params[:iSortCol_0].to_i]
    end
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
