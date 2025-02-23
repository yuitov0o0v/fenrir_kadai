Rails.application.routes.draw do
  root 'restaurants#search'
  get 'restaurants/search', to: 'restaurants#search'
  get 'restaurants', to: 'restaurants#index', as: 'restaurants_index'
  get 'restaurants/:id', to: 'restaurants#show', as: 'restaurant'
end
