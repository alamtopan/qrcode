class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include TheUser::DeviseFilter

  protected
    def per_page
      params[:per_page] ||= 20
    end

    def page
      params[:page] ||= 1
    end
end
