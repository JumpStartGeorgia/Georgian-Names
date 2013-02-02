BootstrapStarter::Application.routes.draw do
	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
=begin
		match '/admin', :to => 'admin#index', :as => :admin, :via => :get
		devise_for :users
		namespace :admin do
			resources :users
		end
=end
    match '/sakheli/:name', :to => 'root#first_name', :as => :first_name, :via => :get
    match '/gvari/:name', :to => 'root#last_name', :as => :last_name, :via => :get
    match '/district/:id', :to => 'root#district', :as => :district, :via => :get
    match '/year/:id', :to => 'root#year', :as => :year, :via => :get
    match '/search_sakheli', :to => 'root#search_first_name', :as => :search_first_name, :via => :get
    match '/search_gvari', :to => 'root#search_last_name', :as => :search_last_name, :via => :get


    # search
    match '/search/birth_years/:name_id', :to => 'search#birth_years', :as => :search_birth_years, :via => :get, :defaults => {:format => 'json'}
    match '/search/districts/:name_id', :to => 'search#districts', :as => :search_districts, :via => :get, :defaults => {:format => 'json'}
    match '/search/names_birth_year/:name_type/:birth_year', :to => 'search#names_birth_year', :as => :search_names_birth_year, :via => :get, :defaults => {:format => 'json'}
    match '/search/names_district/:name_type/:district_id', :to => 'search#names_district', :as => :search_names_district, :via => :get, :defaults => {:format => 'json'}

    # generate image
    match '/png/rank/:rank', :to => 'png#rank', :as => :generate_rank, :via => :get

		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
