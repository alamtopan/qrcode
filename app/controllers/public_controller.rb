class PublicController < ApplicationController
  def home
    @courses = current_user.courses.latest if current_user.present?
  end
end