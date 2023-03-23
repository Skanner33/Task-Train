Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #user
  post '/register', to: "users#register"
  post '/users/login', to: "users#login"
  delete '/users/logout', to: "users#logout"
  get '/users/login/check', to: "users#check_login_status"

  #todos
  post '/todos', to: 'todos#create'
  put '/todos/:id', to: "todos#update"
end
