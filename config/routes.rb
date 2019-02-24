
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/dashboard', as: 'rails_admin'
  mount ImageUploader.upload_endpoint(:cache) => "/upload"
  devise_for :students, controllers: {
      sessions: 'students/sessions',
      registrations: 'students/registrations'
  }
  resources :students do
    member do
      get :confirm_email
    end
  end
  authenticated :student do
    root 'universities#index', as: :authenticated_student_root
  end

  devise_for :faculties, controllers: {
      sessions: 'faculties/sessions',
      registrations: 'faculties/registrations'
  }

  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
  }

  resources :universities
  resources :profiles

  root to: 'homepage#index'
end

