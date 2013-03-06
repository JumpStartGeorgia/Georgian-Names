BootstrapStarter::Application.routes.draw do
	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    match '/sakheli/:name', :to => 'root#first_name', :as => :first_name, :via => :get
    match '/gvari/:name', :to => 'root#last_name', :as => :last_name, :via => :get
    match '/sruli_sakheli/:first_name/:last_name', :to => 'root#full_name', :as => :full_name, :via => :get
    match '/raioni/:id', :to => 'root#district', :as => :district, :via => :get
    match '/dabadebis_tseli/:id', :to => 'root#year', :as => :year, :via => :get
    match '/dzieba', :to => 'root#search_name', :as => :search_name, :via => :get
    match '/chamotvirtva', :to => 'root#download', :as => :download, :via => :get


    # search
    match '/search/birth_years/:name_id', :to => 'search#birth_years', :as => :search_birth_years, :via => :get, :defaults => {:format => 'json'}
    match '/search/districts/:name_id', :to => 'search#districts', :as => :search_districts, :via => :get, :defaults => {:format => 'json'}
    match '/search/names_birth_year/:name_type/:birth_year', :to => 'search#names_birth_year', :as => :search_names_birth_year, :via => :get, :defaults => {:format => 'json'}
    match '/search/names_district/:name_type/:district_id', :to => 'search#names_district', :as => :search_names_district, :via => :get, :defaults => {:format => 'json'}
    match '/search/names_country/:name_type', :to => 'search#names_country', :as => :search_names_country, :via => :get, :defaults => {:format => 'json'}
    match '/search/name/:name_type/:name_id', :to => 'search#names', :as => :search_names, :via => :get, :defaults => {:format => 'json'}
    match '/search/full_name', :to => 'search#full_names', :as => :search_full_names, :via => :get, :defaults => {:format => 'json'}
    match '/search/birth_years_full_name/:first_name_id/:last_name_id', :to => 'search#birth_years_full_name', :as => :search_birth_years_full_name, :via => :get, :defaults => {:format => 'json'}
    match '/search/districts_full_name/:first_name_id/:last_name_id', :to => 'search#districts_full_name', :as => :search_districts_full_name, :via => :get, :defaults => {:format => 'json'}

    # generate image
    match '/png/rank/:rank', :to => 'png#rank', :as => :generate_rank, :via => :get
    match '/png/share_rank/:rank', :to => 'png#share_rank', :as => :generate_share_rank, :via => :get

		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
