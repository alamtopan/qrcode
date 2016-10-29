class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    super do
      resource.type = 'Student'
      resource.save
    end
  end
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u|
        u.permit(
                  :username,
                  :email,
                  :password,
                  :password_confirmation,
                  :type,
                  :slug
                )
      }
      devise_parameter_sanitizer.permit(:sign_in) { |u|
        u.permit(:login, :username, :email, :password, :remember_me, :type, :slug)
      }
    end
end
