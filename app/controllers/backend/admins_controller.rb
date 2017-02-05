class Backend::AdminsController < Backend::ApplicationController 
  before_action :class_name
  before_filter :draw_password, only: :update

  add_breadcrumb "Admins", :backend_admins_path

  def index
    @admins = collection.page(page).per(per_page)
  end

  def show
    prepare_add_breadcrumb_action
    resource
  end

  def new
    prepare_add_breadcrumb_action
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_permit)
    @admin.type = "Admin"
    @admin.confirmation_token = nil
    @admin.confirmed_at = Time.now
    if @admin.save
      redirect_to backend_admins_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def edit
    prepare_add_breadcrumb_action
    resource
  end

  def update
    resource

    if @admin.update(params_permit)
      redirect_to backend_admins_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @admin.destroy
      redirect_to :back
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
                                    :avatar
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
