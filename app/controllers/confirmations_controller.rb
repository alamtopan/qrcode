class ConfirmationsController < ApplicationController
  def create
    @confirmation = Confirmation.new(params_permit)
    @confirmation.user_id = current_user.id
    if @confirmation.save
      redirect_to root_path, notice: 'Konfirmasi pembayaran berhasil dikirim, silahkan tunggu informasi selanjutnya dari kami!'
    else
      redirect_to root_path, alert: @confirmation.errors.full_messages
    end
  end

  private
    def params_permit
        params.require(:confirmation).permit(
                                      :invoice_code, 
                                      :user_id, 
                                      :course_id, 
                                      :payment_date,
                                      :nominal,
                                      :bank_account,
                                      :payment_method,
                                      :sender_name,
                                      :status
                                      )
    end
end