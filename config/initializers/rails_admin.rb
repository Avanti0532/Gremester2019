RailsAdmin.config do |config|


  module RailsAdmin
    module Config
      module Actions
        class ApproveFaculty < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

    require Rails.root.join('lib', 'rails_admin_approve_faculty.rb')
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.authorize_with do |controller|
    if current_admin.nil?
      redirect_to main_app.root_path
    elsif !current_admin
      redirect_to main_app.root_path
    end
  end

  config.current_user_method(&:current_admin)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Faculty', 'Student']
    end
    bulk_delete
    approve_faculty do
      except ['Student', 'Admin']
    end
    show
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end