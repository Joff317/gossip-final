Rails.application.routes.draw do
  
  get '/', to: 'index#home'
  
  resources :gossips
  
  resources :users 
  
  resources :cities
  
  resources :gossips do 
    resources :comments
  end

  resources :gossips do 
    resources :likes
  end


  get '/login'     => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	
	# delete action to log out:
	delete '/logout' => 'sessions#destroy'  

    get 'welcome/:first_name', to: 'welcome#show'
    #Route contact
    get '/contact', to: 'index#contact'
  
    #Route team
    get '/team', to: 'index#team'
  
  
  
end
