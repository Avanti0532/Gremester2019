
Rails.application.routes.draw do
  mount Thredded::Engine => '/discussion_forum'
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
  authenticated :faculty do
    root 'profiles#fStudentList', as: :authenticated_faculty_root
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
  resources :faculty_evaluations do
    collection do
      match '/:id' => 'faculty_evaluations#create',   via: :post,  :as => :create_faculty_evaluation
      match '/showEvaluations/:id', to: 'faculty_evaluations#showEvaluations',via: :get, :as => 'showEvaluations'
    end
  end
  resources :profiles do
    collection do
      match '/getUndergradUniversityByCountry', to: 'profiles#getUndergradUniversityByCountry',via: :get
      match 'faculty/:id', to: 'profiles#fViewProfile', via: :get, :as => 'fViewProfile'
      match '/deleteUndergradUniversity/:id', to: 'profiles#deleteUndergradUniversity', via: :get, :as => 'deleteUndergradUniversity'
    end
    get :sInterestedSchools, on: :collection
    get :filter, on: :collection
    get :sAdmissionChance, on: :collection
    get :fStudentList, on: :collection
    collection do
      match '/addschools', to: 'profiles#addschools',via: :post
      match '/deleteschools', to: 'profiles#deleteschools',via: :post
      match '/getAdmissionChance', to: 'profiles#getAdmissionChance', via: :post
      post  ":id"  => "profiles#update",  :as => 'update'
      match '/showSchools/:id', to: 'profiles#showschools',via: :get, :as => 'show'
    end
  end

  resources :research_interests
  resources :countries
  resources :rank_types
  resources :undergrad_universities
  resources :applications

  root to: 'homepage#index'


end

