IDPApp::Application.routes.draw do
  #Root is for your home page; 'root' is not actually an HTTP action
  root to: "sessions#new"

  #Post and get are HTTP actions. In some sense, 'post' and 'get' are arbitrary
  #names for syntactically identical parameters. By convention, use 'get' when
  # you're only requesting to read a page, and post when you're actually sending information up to the server.
  post '/read_csv', to: 'static_pages#read_csv', as: 'read_csv'
  get '/enter_record', to: 'static_pages#enter_record', as: 'enter_record'
  post '/create_record', to: 'static_pages#create_record', as: 'create_record'

  get '/find_matches', to: 'gold_standard_identities#find_matches', as: 'find_matches'
  get '/search_form', to: 'gold_standard_identities#search_form', as: 'search_form'
  get '/search_fields', to: 'gold_standard_identities#search_fields', as: 'search_fields'
  post '/match_results', to: 'gold_standard_identities#match_results', as: 'match_results'
  get '/test_page', to: 'gold_standard_identities#test_page'

  resources :gold_standard_matches, only: [:create]

  resources :gold_standard_identities, only: [:new, :create, :index, :show]

  resource  :session, only: [:new, :create, :destroy]
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  namespace :api, defaults: { format: :json } do
    resources :iom_identities, only: [:create, :destroy, :update, :show]
    resources :gold_standard_identities, only: [:create, :show, :index] do
      resources :iom_identities, only: [:index]
    end

    get '/iom_identities', to: 'iom_identities#temp_index', as: 'iom_identities_temp'
  end
end
