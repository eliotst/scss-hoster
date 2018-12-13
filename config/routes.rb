Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'artifacts/test', to: 'artifacts#test'
  resources :artifacts do
    member do
      get 'compiled'
    end
  end
  get 'dist/*other', to: 'artifacts#by_path', format: false

  resources :projects

  root to: 'projects#index'
end
