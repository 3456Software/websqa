# == Route Map (Updated 2013-11-05 19:56)
#
#        Prefix Verb   URI Pattern                  Controller#Action
#         users GET    /users(.:format)             users#index
#               POST   /users(.:format)             users#create
#      new_user GET    /users/new(.:format)         users#new
#     edit_user GET    /users/:id/edit(.:format)    users#edit
#          user GET    /users/:id(.:format)         users#show
#               PATCH  /users/:id(.:format)         users#update
#               PUT    /users/:id(.:format)         users#update
#               DELETE /users/:id(.:format)         users#destroy
#      sessions POST   /sessions(.:format)          sessions#create
#   new_session GET    /sessions/new(.:format)      sessions#new
#       session DELETE /sessions/:id(.:format)      sessions#destroy
#      projects GET    /projects(.:format)          projects#index
#               POST   /projects(.:format)          projects#create
#   new_project GET    /projects/new(.:format)      projects#new
#  edit_project GET    /projects/:id/edit(.:format) projects#edit
#       project GET    /projects/:id(.:format)      projects#show
#               PATCH  /projects/:id(.:format)      projects#update
#               PUT    /projects/:id(.:format)      projects#update
#               DELETE /projects/:id(.:format)      projects#destroy
#          root GET    /                            static_pages#home
#          help GET    /help(.:format)              static_pages#help
#         about GET    /about(.:format)             static_pages#about
#       contact GET    /contact(.:format)           static_pages#contact
#        signup GET    /signup(.:format)            users#new
#        signin GET    /signin(.:format)            sessions#new
#       signout DELETE /signout(.:format)           sessions#destroy
#  project_home GET    /project_home(.:format)      mockups#project_home
# project_admin GET    /project_admin(.:format)     mockups#project_admin
#     user_home GET    /user_home(.:format)         mockups#user_home
#   staff_admin GET    /staff_admin(.:format)       mockups#staff_admin
#

Websqa::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :projects
  root 'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/project_home',  to: 'mockups#project_home',  via: 'get'
  match '/project_admin', to: 'mockups#project_admin', via: 'get'
  match '/user_home',     to: 'mockups#user_home',     via: 'get'
  match '/staff_admin',   to: 'mockups#staff_admin',   via: 'get'
end
