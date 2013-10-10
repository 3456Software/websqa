Websqa::Application.routes.draw do
  root 'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  # for demo pages
  match '/signin',  to: 'demo_pages#signin',    via: 'get'
  match '/signup',  to: 'demo_pages#signup',    via: 'get'
end
