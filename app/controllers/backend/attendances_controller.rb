class Backend::AttendancesController < Backend::ApplicationController 
  before_action :class_name
  add_breadcrumb "Attendances", :backend_attendances_path

  def index
    add_breadcrumb "#{params[:action]}"

    if current_user.is_teacher?
      @attendances_count = collection.where("profile_students.student_class =?", current_user.profile_teacher.teacher_class).size
      @attendances = collection.where("profile_students.student_class =?", current_user.profile_teacher.teacher_class).page(page).per(per_page)
    else
      @attendances_count = collection.size
      @attendances = collection.page(page).per(per_page)
    end
  end

  def show
    prepare_add_breadcrumb_action
    resource
  end

  def update
    resource

    if @attendance.update(params_permit)
      redirect_to backend_attendances_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @attendance.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def multiple_action
    if params[:ids].present?
      if params[:commit] == 'Do Destroy'
        collect = params[:ids]

        Attendance.where(id: collect).each do |c|
          c.destroy
        end

        redirect_to :back, alert: 'Successfully deleted attendances!'
      else
        redirect_to :back, alert: 'Nothing checked!'
      end 
    end
  end

  private
    def resource
      @attendance = Attendance.find(params[:id])
    end

    def collection
      @attendances = Attendance.latest.search_by(params)
    end

    def params_permit
      params.require(:attendance).permit(:user_id, :status)
    end

    def class_name
      @resource_name = 'Attendance'
      @collection_name = 'Attendances'
    end

end
