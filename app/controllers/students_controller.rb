class StudentsController < ApplicationController
  def create
    @student = Student.new(params_permit)
    if @student.save
      prepare_course(params)
      UserMailer.send_confirmation(@student, @course).deliver!
      redirect_to root_path, notice: 'Anda Berhasil Terdaftar, Silahkan Cek Email Anda dan Lakukan Konfirmasi Pembayaran Segera!'
    else
      redirect_to root_path, alert: @student.errors.full_messages
    end
  end

  def skill_test
    @course = Course.find(params[:test_id])
    @course.result_test = check_skill_test(params[:test])
    if @course.save
      redirect_to root_path, notice: "Test sudah diselesaikan, hasil test anda adalah #{@course.result_test} = #{@course.grade?}"
    else
      redirect_to root_path, alert: @course.errors.full_messages
    end
  end

  private
    def prepare_course(params)
      @course = Course.new
      @course.user_id = @student.id
      @course.name = params[:course]
      @course.schedule = params[:schedule]
      @course.price = 1200000
      byebug
      @course.save
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

    def check_skill_test(params)
      question1 = params[:question1]
      if question1 == 'A'
        question1 = 1
      else
        question1 = 0
      end

      question2 = params[:question2]
      if question2 == 'B'
        question2 = 1
      else
        question2 = 0
      end

      question3 = params[:question3]
      if question3 == 'B'
        question3 = 1
      else
        question3 = 0
      end

      question4 = params[:question4]
      if question4 == 'C'
        question4 = 1
      else
        question4 = 0
      end

      question5 = params[:question5]
      if question5 == 'A'
        question5 = 1
      else
        question5 = 0
      end

      question5 = params[:question5]
      if question5 == 'A'
        question5 = 1
      else
        question5 = 0
      end

      question6 = params[:question6]
      if question6 == 'A'
        question6 = 1
      else
        question6 = 0
      end

      question7 = params[:question7]
      if question7 == 'A'
        question7 = 1
      else
        question7 = 0
      end

      question8 = params[:question8]
      if question8 == 'A'
        question8 = 1
      else
        question8 = 0
      end

      question9 = params[:question9]
      if question9 == 'A'
        question9 = 1
      else
        question9 = 0
      end

      question10 = params[:question10]
      if question10 == 'B'
        question10 = 1
      else
        question10 = 0
      end

      result = question1 + question2 + question3 + question4 + question5 + question6 + question7 + question8 + question9 + question10
      return result
    end
end