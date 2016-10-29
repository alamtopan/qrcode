class Backend::TeachersController < Backend::ApplicationController 
  before_action :class_name
  before_filter :draw_password, only: :update

  add_breadcrumb "Teachers", :backend_teachers_path

  def index
    add_breadcrumb "#{params[:action]}"
    @teachers_count = collection.size
    @teachers = collection.page(page).per(per_page)
  end

  def show
    prepare_add_breadcrumb_action
    resource
  end

  def new
    prepare_add_breadcrumb_action
    add_breadcrumb "#{params[:action]}"
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(params_permit)

    if @teacher.save
      redirect_to :back, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def edit
    prepare_add_breadcrumb_action
    add_breadcrumb "#{params[:action]}"
    resource
  end

  def update
    resource

    if @teacher.update(params_permit)
      redirect_to :back, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @teacher.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def multiple_action
    if params[:ids].present?
      if params[:commit] == 'Do Destroy'
        collect = params[:ids]

        Teacher.where(id: collect).each do |c|
          c.destroy
        end

        redirect_to :back, alert: 'Successfully deleted teachers!'
      else
        redirect_to :back, alert: 'Nothing checked!'
      end 
    end
  end

  private
    def resource
      @teacher = Teacher.find(params[:id])
    end

    def collection
      @teachers = Teacher.latest.search_by(params)
    end

    def params_permit
      params.require(:teacher).permit(
                                    :username, 
                                    :email, 
                                    :password, 
                                    :password_confirmation,
                                    :type,
                                    :avatar,
                                    :verified,
                                    :featured,
                                    profile_teacher_attributes: [
                                      :nik,
                                      :teacher_class,
                                      :first_name,
                                      :last_name,
                                      :born,
                                      :gender,
                                      :country,
                                      :province,
                                      :city,
                                      :phone,
                                      :address,
                                      :user_id
                                    ])
    end

    def class_name
      @resource_name = 'teacher'
      @collection_name = 'teachers'
    end

    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:teacher].delete(attr)
      end if params[:teacher] && params[:teacher][:password].blank?
    end
end
