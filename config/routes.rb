require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # Static page routes
  get 'pages/index'
  get 'pages/features'
  get 'pages/pricing'
  resources :access_requests, only: %i[new create show]
  root 'pages#index'

  # Address search
  get 'address_search/index'
  resources 'addresses' do
    collection do
      get :states
      get :cities
    end
  end

  #Suburb and Postal_code Suggestions in Advance Search
  resources :suburbs, only: [] do
    collection do
      get :autocomplete      
      get :postal_codes    
    end
  end

  # Agent routes
  devise_for :agents
  resource :agent, only: %i[show edit update] do
    resource :microsoft_graph_session, only: %i[new create destroy], module: :agents

    # A redirect URL called once the Agent has logged in
    resource :microsoft_graph_auth, only: :new, module: :agents
  end
  get '/dashboard', to: 'dashboard#show', as: 'agent_root' # Generate Devise default model path

  # Contact routes
  resources :businesses,  module: :contacts, path: 'contacts/businesses'
  resources :individuals, module: :contacts, path: 'contacts/individuals'
  resources :search_contacts, only: :index, module: :contacts
  resources :contacts, only: %i[index] do
    resources :property_requirements, only: %i[index show create destroy], module: :contacts
    # resources :matching_properties, only: %i[index], module: :contacts
    resources :matching_properties_emails, only: %i[new create], module: :contacts
  end

  # Property routes
  resources :commercial_properties,  module: :properties, path: 'properties/commercial'
  resources :retail_properties,      module: :properties, path: 'properties/retail'
  resources :industrial_properties,  module: :properties, path: 'properties/industrial'
  resources :residential_properties, module: :properties, path: 'properties/residential'
  resources :archived_properties,    module: :properties, path: 'properties/archived'
  resources :search_properties, only: :index, module: :properties
  resources :property_search_forms, only: %i[new index], module: :properties
  post 'edit_multiple_properties', to: 'properties#edit_multiple'
  resources :properties, only: %i[index show destroy] do
    resource :contract
    resources :property_contacts
    post :contact_filter, to: 'property_contacts#filter'
    resources :listing_enquiries, only: :index, module: :properties
    resources :property_prospects, only: %i[index]
    resources :prospects_properties_emails, only: %i[new create], module: :properties # Email Prospects
    resources :property_activity_logs, only: %i[index]
    resources :images, only: :destroy, module: :properties
    resources :files, only: :destroy, module: :properties
    member do
      patch :unarchive
      resource :share, only: %i[create destroy], module: :properties, as: :share_property # Toggle property sharing
      resource :duplicate_properties, only: :create, module: :properties # Duplicate a property
      resource :griffin_property_com_au_listing, only: %i[new show destroy], module: :properties # GriffinProperty.com.au Listing routes
      resource :rea_listing, only: %i[new show destroy], module: :properties # REA Listing routes
      resource :domain_com_au_listing, only: %i[new show destroy], module: :properties # Domain.com.au Listing routes
    end
  end

  # Property requirements
  namespace :property_requirements do
    resources :search_suburbs, only: :create
  end

  # ListingEnquiries
  resources :listing_enquiries, only: %i[index show destroy] do
    get :read, on: :collection
    get :unread, on: :collection
  end

  # Account mangement
  resource :account, only: %i[edit update] do
    resources :agents, only: %i[index new create edit update], module: :accounts
    resource :microsoft_graph_settings, only: %i[index edit], module: :accounts
    resource :listings, only: %i[edit], module: :accounts
  end

  # Domain.com.au returns a code when accessing the tokens route.
  # See https://developer.domain.com.au/docs/v1/authentication/oauth/authorization-code-grant
  namespace :accounts do
    namespace :domain_com_au do
      resource :access_token, only: :new # Domain.com.au access tokens route
    end
    get ':id/domain_com_au/access_code', to: 'domain_com_au/access_codes#new', as: 'domain_com_au_access_codes'

    # Domain.com.au webhook routes
    get  ':id/domain_com_au/webhooks', to: 'domain_com_au/webhooks#index', as: 'domain_com_au_webhook_verify'
    post ':id/domain_com_au/webhooks', to: 'domain_com_au/webhooks#create', as: 'domain_com_au_webhook'

    # Domain.com.au webhook subscription routes
    delete ':account_id/domain_com_au/webhook_subscriptions/:id', to: 'domain_com_au/webhook_subscriptions#destroy',
                                                                  as: 'delete_domain_com_au_webhook_subscription'
  end

  # Microsoft Graph Auth routes
  match '/auth/:provider/callback', to: 'microsoft/graph/auth#callback', via: %i[get post]

  # Overlord routes
  namespace :console do
    resources :access_requests, only: %i[index show destroy]
    resources :accounts do
      resources :agents
      resources :contacts, except: %i[show create edit update]
      resources :businesses, module: :contacts, only: %i[show create edit update]
      resources :individuals, module: :contacts, only: %i[show create edit update]
      resources :classifiers
      resources :commercial_properties,  module: :properties, path: 'properties/commercial'
      resources :retail_properties,      module: :properties, path: 'properties/retail'
      resources :industrial_properties,  module: :properties, path: 'properties/industrial'
      resources :residential_properties, module: :properties, path: 'properties/residential'
      resources :properties do
        resource :share, only: %i[create destroy], module: :properties, as: :share_property # Toggle property sharing
        resource :contract
        resources :property_contacts
        member do
          get 'real_estate_au'
          resource :rea_listing, only: :show, module: :properties # REA Listing routes
          resource :domain_com_au_listing, only: :show, module: :properties # Domain.com.au Listing routes
        end
      end

      # Property portal webhook routes
      resources :inbound_webhooks, only: %i[index show] do
        get :replay, on: :member
      end
      namespace :domain_com_au do
        resources :webhook_subscriptions, only: %i[index new create show destroy] # , module: :domain_com_au
      end

      # Enquiries
      resources :listing_enquiries, only: %i[index]
      resources :raw_listing_enquiries, only: %i[index]

      # Portal Listings
      resources :portal_listings, only: %i[index show destroy]
    end
    resources :countries do
      resources :states do
        resources :cities
      end
    end
    root 'accounts#index'
  end
  devise_for :overlords

  authenticate :overlord do
    mount Sidekiq::Web => '/sidekiq'
  end
end
