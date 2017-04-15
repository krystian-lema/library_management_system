Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # These routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # These routes will be for creating users.
  get '/users_creator' => 'users#new'
  get '/administrators' => 'users#new_admin'
  get '/librarians' => 'users#new_librarian'
  get '/students' => 'users#new_student'
  post '/administrators' => 'users#create_admin'
  post '/librarians' => 'users#create_librarian'
  post '/students' => 'users#create_student'

  get '/users/:id/change_password' => 'users#change_password_view'
  patch '/users/:id/change_password' => 'users#change_password'
  put '/users/:id/change_password' => 'users#change_password'

  resources :users, except: [:new, :create]

  root to: 'users#index'

end
