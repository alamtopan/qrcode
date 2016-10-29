class PublicController < ApplicationController
  def home
    if params[:code].present?
      @student = Student.bonds.where("profile_students.nis =?", params[:code]).last

      if @student.present?
        @check_day_attendance = Attendance.where("attendances.user_id =?", @student.id).where("DATE(created_at) = DATE(?)", Time.zone.now)

        if @check_day_attendance.present?
          redirect_to root_path, alert: "Gagal, siswa dengan Nis #{@student.profile_student.nis} sudah melakukan absen, hari ini!"
        else
          @attendance = Attendance.new
          @attendance.user_id = @student.id
          @attendance.status = 'attend'
          if @attendance.save
            redirect_to root_path(nis: @student.profile_student.nis), notice: "Siswa dengan Nis #{@student.profile_student.nis} dengan nama #{@student.profile_student.first_name} #{@student.profile_student.last_name} hadir!"
          else
            redirect_to :back, alert: 'Gagal disimpan!'
          end
        end
      else
        redirect_to root_path, alert: 'Gagal data siswa tidak ditemukan!}!'
      end
    end
  end

  def process_attendance
  end
end