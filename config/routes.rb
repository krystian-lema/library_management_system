
Rails.application.routes.draw do

  get 'libraries/new'

  get 'libraries/edit'

  get 'libraries/destroy'

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
  post '/users' => 'json_users#import_users'

  # These routes will be for changing user passwords.
  get '/users/:id/change_password' => 'users#change_password_view'
  patch '/users/:id/change_password' => 'users#change_password'
  put '/users/:id/change_password' => 'users#change_password'
  get '/reset_password' => 'users#reset_password_view'
  post '/reset_password' => 'users#reset_password'
  # put '/reset_password' => 'users#reset_password'

  resources :users, except: [:new, :create]
  resources :libraries, except: [:create] do
    resources :books, except: [:create]
  end
  
  resources :borrows, except: [:create]
  #Libraries
  post '/libraries' => 'libraries#create'
  #get '/addLibrary' => 'libraries#new'
  patch '/updateLibrary/:id' => 'libraries#update'
  post '/library_with_books' => 'json_books#import_library_with_books'

  #Books
  get '/books/new' => 'books#new'
  post '/books' => 'books#create'
  get '/books' => 'books#index'
  get '/books/:id' => 'books#show'
  get '/books/edit' => 'books#edit'
  get '/books/update/:id' => 'books#update'
  get '/books/edit/:id' => 'books#edit'

  get '/libraries/:library_id/books/:book_id/delete' => 'books#delete_book'

  #borrows
  get 'borrows/:book_id' => 'borrows#create'
  get 'borrows/' => 'borrows#index'
  get '/borrows/addBorrow/:id' => 'borrows#addBorrow'
  get '/libraries/:library_id/books/:book_id/confirmBorrow' => 'borrows#confirm_borrow'
  post '/student/add_borrow/' => 'students#add_borrow'
  



  # These routes will be for different user roles.
  get '/administrator' => 'admins#index'
  get '/librarian' => 'librarians#index'
  get '/student' => 'students#index'
  get '/administrator/users' => 'admins#view_all_users'
  get '/librarian/borrows' => 'librarians#borrows'
  get '/librarian/student_borrows/:id' => 'librarians#student_borrows'
  get '/librarian/student_archive_borrows/:id' => 'librarians#student_archive_borrows'
  get '/librarian/users' => 'librarians#view_all_students'
  get '/student/borrows' => 'students#borrows'

  patch 'librarian/confirm_borrow' => 'librarians#confirm_borrow'
  post 'librarian/finish_borrow' => 'librarians#finish_borrow'

  root to: 'users#index'

end
