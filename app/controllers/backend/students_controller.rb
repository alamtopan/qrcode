class Backend::StudentsController < Backend::ApplicationController 
  before_action :class_name
  before_filter :draw_password, only: :update

  add_breadcrumb "Students", :backend_students_path

  def index
    add_breadcrumb "#{params[:action]}"

    if current_user.is_teacher?
      @students_count = collection.where("profile_students.student_class =?", current_user.profile_teacher.teacher_class).size
      @students = collection.where("profile_students.student_class =?", current_user.profile_teacher.teacher_class).page(page).per(per_page)
    else
      @students_count = collection.size
      @students = collection.page(page).per(per_page)
    end
  end

  def report
    prepare_add_breadcrumb_action
    
    @student = Student.find(params[:id])

    @query_attendances = Attendance.where(user_id: @student.id).search_by_detail(params)
    @attendances_all = Attendance.where(user_id: @student.id).latest.search_by(params)
    @attendances = @attendances_all.page(page).per(30)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'file_name',
        layout: 'layouts/print_layout.html.erb',
        show_as_html: params[:debug].present?
      end
    end
  end

  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'file_name',
        layout: 'layouts/print_layout.html.erb',
        show_as_html: params[:debug].present?
      end
    end
  end

  def new
    prepare_add_breadcrumb_action
    add_breadcrumb "#{params[:action]}"
    @student = Student.new
  end

  def create
    @student = Student.new(params_permit)
    @student.username = params[:student][:profile_student_attributes][:nis]
    @student.email = params[:student][:profile_student_attributes][:nis] + '@student.com'
    @student.password = 12345678
    @student.password_confirmation = 12345678
    if @student.save
      redirect_to backend_students_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back, alert: @student.errors.full_messages.join("<br>")
    end
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

  def multiple_action
    if params[:ids].present?
      if params[:commit] == 'Do Destroy'
        collect = params[:ids]

        Student.where(id: collect).each do |c|
          c.destroy
        end

        redirect_to :back, alert: 'Successfully deleted students!'
      else
        redirect_to :back, alert: 'Nothing checked!'
      end 
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
                                    :avatar,
                                    :verified,
                                    :featured,
                                    profile_student_attributes: [
                                      :nis,
                                      :student_class,
                                      :first_name,
                                      :last_name,
                                      :born,
                                      :gender,
                                      :country,
                                      :province,
                                      :city,
                                      :phone,
                                      :address,
                                      :parent_name,
                                      :parent_address,
                                      :parent_contact,
                                      :parent_job,
                                      :user_id
                                    ])
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
