class Attendance < ActiveRecord::Base
  belongs_to :student, foreign_key: 'user_id'

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}
  scope :bonds, ->{eager_load(student: :profile_student)}

  include TheUser::AttendanceSearching
  include TheUser::AttendanceSearchingDetail

  def status?
    if self.status == 'attend'
      return "<label class='label label-success'>Hadir</label>".html_safe
    else
      return "<label class='label label-danger'>Alfa</label>".html_safe
    end
  end

  def self.count_today
    where("DATE(created_at) = DATE(?)", Time.zone.now).count
  end

  def self.count_week
    today = Time.zone.now
    where("DATE(created_at) >= DATE(?) AND DATE(created_at) <= DATE(?)", today.at_beginning_of_week, today.at_end_of_week).count
  end

  def self.count_month
    today = Time.zone.now
    where("DATE(created_at) >= DATE(?) AND DATE(created_at) <= DATE(?)", today.at_beginning_of_month, today.at_end_of_month).count
  end

  def self.count_year
    today = Time.zone.now
    where("DATE(created_at) >= DATE(?) AND DATE(created_at) <= DATE(?)", today.beginning_of_year, today.end_of_year).count
  end

  def self.per_year
    today = Time.zone.now
    where("DATE(created_at) >= DATE(?) AND DATE(created_at) <= DATE(?)", today.beginning_of_year, today.end_of_year)
  end

  def self.per_month
    today = Time.zone.now
    where("DATE(created_at) >= DATE(?) AND DATE(created_at) <= DATE(?)", today.at_beginning_of_month, today.at_end_of_month)
  end
end
