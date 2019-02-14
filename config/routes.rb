
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/dashboard', as: 'rails_admin'
  mount ImageUploader.upload_endpoint(:cache) => "/upload"
  # mount ImageUploader.upload_endpoint(:store) => "public/uploads"
  devise_for :admins
  devise_for :faculties
  devise_for :students
  resources :students do
    member do
      get :confirm_email
    end
  end
    root to: 'homepage#index'

  match '/log_in', to: 'login#index', via: :get
end

