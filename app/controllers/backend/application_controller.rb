class Backend::ApplicationController < ApplicationController
  layout 'admin_lte_2'

  before_filter :authenticate_admin!

  add_breadcrumb "Dashboard", :backend_dashboard_admin_path

  def authenticate_admin!
    unless current_user.present? && (current_user.is_admin? || current_user.is_teacher?)
      redirect_to root_path, alert: "Can't Access This Page!"
    end
  end

  protected
    def per_page
      params[:per_page] ||= 36
    end

    def page
      params[:page] ||= 1
    end

    def prepare_add_breadcrumb_action
      add_breadcrumb "#{params[:action]}"
    end
end
