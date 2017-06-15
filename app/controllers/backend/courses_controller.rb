class Backend::CoursesController < Backend::ApplicationController 
  before_action :class_name
  add_breadcrumb "Courses", :backend_courses_path

  def index
    add_breadcrumb "#{params[:action]}"

    @courses_count = collection.size
    @courses = collection.page(page).per(per_page)

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

    if @course.update(params_permit)
      redirect_to backend_courses_path, notice: "Successfully saved #{@resource_name}"
    else
      redirect_to :back
    end
  end

  def destroy
    resource

    if @course.destroy
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
    def resource
      @course = Course.find(params[:id])
    end

    def collection
      @courses = Course.latest.search_by(params)
    end

    def class_name
      @resource_name = 'course'
      @collection_name = 'courses'
    end
end
