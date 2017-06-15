class AddResultTestInCourse < ActiveRecord::Migration
  def change
    add_column :courses, :result_test, :integer, default: 0
  end
end
