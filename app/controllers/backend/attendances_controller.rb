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

  def new
    
  end

  def create
    if params[:code].present?
      @student = Student.bonds.where("profile_students.nis =?", params[:code]).last

      if @student.present?
        @check_day_attendance = Attendance.where("attendances.user_id =?", @student.id).where("DATE(created_at) = DATE(?)", Time.zone.now)

        if @check_day_attendance.present?
          redirect_to new_backend_attendance_path, alert: "Gagal, siswa dengan Nis #{@student.profile_student.nis} sudah melakukan absen, hari ini!"
        else
          @attendance = Attendance.new
          @attendance.user_id = @student.id
          @attendance.status = 'attend'
          if @attendance.save
            redirect_to new_backend_attendance_path(nis: @student.profile_student.nis), notice: "Siswa dengan Nis #{@student.profile_student.nis} dengan nama #{@student.profile_student.first_name} #{@student.profile_student.last_name} hadir!"
          else
            redirect_to :back, alert: 'Gagal disimpan!'
          end
        end
      else
        redirect_to new_backend_attendance_path, alert: 'Gagal data siswa tidak ditemukan!}!'
      end
    end
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
