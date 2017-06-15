class Backend::HomeController < Backend::ApplicationController 
  def dashboard
    add_breadcrumb "Home", backend_dashboard_admin_path

    @students = Student.all
  end
end
