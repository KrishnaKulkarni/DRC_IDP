IDPApp::Application.routes.draw do
  #Root is for your home page; 'root' is not actually an HTTP action
  root to: "static_pages#process_data"
  
  #Post and get are HTTP actions. In some sense, 'post' and 'get' are arbitrary
  #names for syntactically identical parameters. By convention, use 'get' when
  # you're only requesting to read a page, and post when you're actually sending information up to the server.
  post '/read_csv', to: 'static_pages#read_csv', as: 'read_csv'
  get '/enter_record', to: 'static_pages#enter_record', as: 'enter_record'
  
  post '/create_record', to: 'static_pages#create_record', as: 'create_record'
  
  resources :test_idps, only: [:create, :new,]
  get '/find_matches', to: 'test_idps#find_matches', as: 'find_matches'
  
end
