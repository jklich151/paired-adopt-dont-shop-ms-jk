Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index';
  get '/shelters', to: 'shelters#index';
  get '/shelters/new', to: 'shelters#new';
  post '/shelters', to: 'shelters#create';
  get '/shelters/:id', to: 'shelters#show';
  get '/shelters/:id/edit', to: 'shelters#edit';
  patch '/shelters/:id', to: 'shelters#update';
  delete '/shelters/:id', to: 'shelters#destroy';

  get '/pets', to: 'pets#index';
  get '/shelters/:shelter_id/pets', to: 'pets#index';
  get '/pets/:id', to: 'pets#show';
  get '/shelters/:shelter_id/pets/new', to: 'pets#new';
  post '/shelters/:shelter_id/pets', to: 'pets#create';
  get '/pets/:id/edit', to: 'pets#edit';
  patch '/pets/:id', to: 'pets#update';
  delete '/pets/:id', to: 'pets#destroy';

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new';
  post '/shelters/:shelter_id', to: 'reviews#create';
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit';
  patch 'shelters/:shelter_id/reviews/:review_id', to: 'reviews#update';
  delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy';

  get '/favorites', to: 'favorites#index'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'
  get '/pets/:pet_id/applications', to: 'applications#index'
  patch '/pets/:pet_id/applications/:applications_id', to: 'pets#update_status'
end
