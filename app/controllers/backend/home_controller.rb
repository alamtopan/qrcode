class Backend::HomeController < Backend::ApplicationController 
  def dashboard
    add_breadcrumb "Home", backend_dashboard_admin_path

    if current_user.is_teacher?
      @attendances = Attendance.search_by(params).where("profile_students.student_class =?", current_user.profile_teacher.teacher_class)
    else
      @attendances = Attendance
    end
  end
end
