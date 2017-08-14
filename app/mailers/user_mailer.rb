class UserMailer < ActionMailer::Base
  default from: 'movies.series.com@gmail.com'

  def send_confirmation(user, course)
    @user = user
    @course = course
    @subject = "Konfirmasi Pembayaran Kursus #{@course.code}"
    mail(to: @user.email, subject: @subject, content_type: "text/html")
  end

end
