class Student < User
  default_scope {where(type: 'Student')}
  
  include TheUser::StudentSearching

  def self.count_today
    where("DATE(users.created_at) = DATE(?)", Time.zone.now).count
  end

  def self.count_week
    today = Time.zone.now
    where("DATE(users.created_at) >= DATE(?) AND DATE(users.created_at) <= DATE(?)", today.at_beginning_of_week, today.at_end_of_week).count
  end

  def self.count_month
    today = Time.zone.now
    where("DATE(users.created_at) >= DATE(?) AND DATE(users.created_at) <= DATE(?)", today.at_beginning_of_month, today.at_end_of_month).count
  end

  def self.count_year
    today = Time.zone.now
    where("DATE(users.created_at) >= DATE(?) AND DATE(users.created_at) <= DATE(?)", today.beginning_of_year, today.end_of_year).count
  end

  def self.per_year
    today = Time.zone.now
    where("DATE(users.created_at) >= DATE(?) AND DATE(users.created_at) <= DATE(?)", today.beginning_of_year, today.end_of_year)
  end

  def self.per_month
    today = Time.zone.now
    where("DATE(users.created_at) >= DATE(?) AND DATE(users.created_at) <= DATE(?)", today.at_beginning_of_month, today.at_end_of_month)
  end
end