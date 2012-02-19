Widgets::Application.routes.draw do

  root :to => "widgets#index"

  resources :widgets

end
