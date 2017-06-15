class Backend::ConfirmationsController < Backend::ApplicationController 
  before_action :class_name
  add_breadcrumb "Confirmations", :backend_confirmations_path

  def index
    add_breadcrumb "#{params[:action]}"

    @confirmations_count = collection.size
    @confirmations = collection.page(page).per(per_page)

    respond_to do |format|
      format.html
      format.xls {@collection = collection}
    end
  end

  def show
    resource
  end

  def update
    resource
    update_course(params, @confirmation)
    if @confirmation.update(params_permit)
      redirect_to backend_confirmations_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @confirmation.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
    def resource
      @confirmation = Confirmation.find(params[:id])
    end

    def collection
      @confirmations = Confirmation.latest.search_by(params)
    end

    def class_name
      @resource_name = 'confirmation'
      @collection_name = 'confirmations'
    end

    def params_permit
      params.require(:confirmation).permit(:status)
    end

    def update_course(params, confirmation)
      course = Course.find_by(code: confirmation.invoice_code)
      course.status = params[:confirmation][:status]
      course.save
    end
end
