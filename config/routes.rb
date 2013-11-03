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

  match '/project', to: 'mockups#project',      via: 'get'
  match '/project_admin', to: 'mockups#project_admin', via: 'get'
end
