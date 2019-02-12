
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ImageUploader.upload_endpoint(:cache) => "/upload"
  # mount ImageUploader.upload_endpoint(:store) => "public/uploads"
  devise_for :admins
  devise_for :faculties, controllers: {
        sessions: 'sessions'
  }

  devise_for :students
    root to: 'homepage#index'

  match '/log_in', to: 'login#index', via: :get
end

