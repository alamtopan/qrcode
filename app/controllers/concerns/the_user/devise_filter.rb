module TheUser
  module DeviseFilter
    extend ActiveSupport::Concern

    included do
      after_filter :store_location
    end

    def store_location
      return if !request.get? || request.xhr?
      return if request.fullpath.match("/users")
      if request.format == "text/html" || request.content_type == "text/html"
        session[:previous_url] = request.fullpath
        session[:last_request_time] = Time.now.utc.to_i
      end
    end

    def after_sign_in_path_for(resource)
      if current_user.present? && current_user.is_admin?
        return backend_dashboard_admin_path
      else 
        session[:previous_url] || root_path
      end
    end

    def authenticate_this_user!
      unless current_user.present?
        redirect_to root_path, alert: "Can't Access this page"
      end 
    end

    def after_sign_out_path_for(resource_or_scope)
      root_url
    end

  end
end