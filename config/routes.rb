Rails.application.routes.draw do

  get 'libraries/new'

  get 'libraries/edit'

  get 'libraries/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # These routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # These routes will be for signup. The first renders a form in the browse, the second will 
  # receive the form and create a user in our database using the data given to us by the user.
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/users/:id/change_password' => 'users#change_password_view'
  patch '/users/:id/change_password' => 'users#change_password'
  put '/users/:id/change_password' => 'users#change_password'

  resources :users, except: [:new, :create]
  resources :libraries, except: [:create] do
    resources :books, except: [:create]
  end
  resources :borrows, except: [:create]

  #Libraries
  post '/libraries' => 'libraries#create'
  #get '/addLibrary' => 'libraries#new'
  patch '/updateLibrary/:id' => 'libraries#update'

  #Books
  get '/addBook' => 'books#new'
  post '/books' => 'books#create'
  get '/books' => 'books#index'
  get '/books/:id' => 'books#show'
  get '/books/edit' => 'books#edit'
  get '/books/update/:id' => 'books#update'
  get '/books/edit/:id' => 'books#edit'

  #borrows
  get '/addBorrow' => 'borrows#new'
  post '/borrows' => 'borrows#create'
  



  root to: 'users#index'

end
