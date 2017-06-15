class Backend::StudentsController < Backend::ApplicationController 
  before_action :class_name
  before_filter :draw_password, only: :update

  add_breadcrumb "Students", :backend_students_path

  def index
    add_breadcrumb "#{params[:action]}"

    @students_count = collection.size
    @students = collection.page(page).per(per_page)
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    prepare_add_breadcrumb_action
    add_breadcrumb "#{params[:action]}"
    resource
  end

  def update
    resource

    if @student.update(params_permit)
      redirect_to backend_students_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @student.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
    def resource
      @student = Student.find(params[:id])
    end

    def collection
      @students = Student.latest.search_by(params)
    end

    def params_permit
      params.require(:student).permit(
                                      :username, 
                                      :email, 
                                      :password, 
                                      :password_confirmation,
                                      :type,
                                      :photo,
                                      :first_name,
                                      :last_name,
                                      :born,
                                      :gender,
                                      :phone,
                                      :address,
                                      :parent_name,
                                      :parent_address,
                                      :parent_contact
                                      )
    end

    def class_name
      @resource_name = 'Student'
      @collection_name = 'Students'
    end

    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:student].delete(attr)
      end if params[:student] && params[:student][:password].blank?
    end
end
