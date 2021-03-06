Simplecrowd::Application.routes.draw do
  root 'home#index'

  resources :projects
  #get "/projects", to: "projects#index", as: "projects"

  #
  # Use the 'routing-filter' gem to do its magic with locale-based routes. The default locale doesn't need a special
  # URL, so for the default locale the "project ... new" URL can just be: /projects/new however, for another locale
  # (let's say 'de') you would get: "/de/projects/new".
  #
  # For this 'magic' to work you need the routing filter gem with the "filter :locale" option (see below), plus some
  # code in application_controller.rb ('set_locale' and 'default_url_options' methods).
  #
  # Technique taken from:
  #
  # http://stackoverflow.com/questions/5261521/how-to-avoid-adding-the-default-locale-in-generated-urls
  # https://github.com/svenfuchs/routing-filter
  #
  # and the reason why we did it this way was that the 'standard way' explained in the Rails guides (see:
  # http://guides.rubyonrails.org/i18n.html#setting-the-locale-from-the-url-params) did NOT work for whatever reason.
  #
  # Finally for this to work we've also added the following lines to config/application.rb:
  #
  # I18n.available_locales = [:en, :nl]
  # config.i18n.default_locale = :nl
  # config.i18n.fallbacks = [:en]
  #
  filter :locale

  devise_for :users

  namespace :admin do
    root "base#index"

    resources :users

    resources :projects
  end

  # 'Pages'

  get "inside", to: "pages#inside", as: "inside"
  get "signed_off", to: "pages#signed_off", as: "signed_off"

  get "/how_it_works", to: "pages#how_it_works", as: "how_it_works"
  get "/about_us", to: "pages#about_us", as: "about_us"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  get "/sitemap", to: "pages#sitemap", as: "sitemap"

  #========================================================================================
  # THE ROUTE CONFIGURATIONS BELOW SHOULD GO AWAY AT SOME POINT !
  #
  # ** BEGIN ** TO BE REMOVED
  #----------------------------------------------------------------------------------------
  if Rails.env.development?
     # catch-all, for easy testing of arbitrary views without having to add routes (or controller mappings) for them
     get ':controller(/:action(/:id(.:format)))'
  #
  #   # /assets is symlinked into public/assets, this construct is used for SASS source maps (with FF/Chrome dev tools)
  #   get "/assets" => redirect("http://localhost:3002/public/assets")
  end
  #----------------------------------------------------------------------------------------
  # ** END ** TO BE REMOVED
  #========================================================================================
end
