
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
   resources :profiles do
     collection do
       match '/getUndergradUniversityByCountry', to: 'profiles#getUndergradUniversityByCountry',via: :get
     end
     get :sInterestedSchools, on: :collection
     get :fStudentList, on: :collection
       collection do
         match '/addschools', to: 'profiles#addschools',via: :post
         match '/deleteschools', to: 'profiles#deleteschools',via: :post
         post  ":id"  => "profiles#update",  :as => 'update'
         match '/showSchools/:id', to: 'profiles#showschools',via: :get, :as => 'show'
       end
   end
  resources :applications
  
  root to: 'homepage#index'

end

