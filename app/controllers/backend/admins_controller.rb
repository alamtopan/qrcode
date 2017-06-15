class Backend::AdminsController < Backend::ApplicationController 
  before_action :class_name
  before_filter :draw_password, only: :update

  add_breadcrumb "Admins", :backend_dashboard_admin_path

  def edit
    prepare_add_breadcrumb_action
    resource
  end

  def update
    resource

    if @admin.update(params_permit)
      redirect_to backend_dashboard_admin_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  private
    def resource
      @admin = Admin.find(params[:id])
    end

    def collection
      @admins = Admin.latest
    end

    def params_permit
      params.require(:admin).permit(
                                    :username, 
                                    :email, 
                                    :password, 
                                    :password_confirmation,
                                    :type,
                                    :photo
                                  )
    end

    def class_name
      @resource_name = 'Admin'
      @collection_name = 'Admins'
    end

    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:admin].delete(attr)
      end if params[:admin] && params[:admin][:password].blank?
    end
end
