class Course < ActiveRecord::Base
  belongs_to :user
  has_many :confirmations

  PAID = 'paid'.freeze
  PENDING = 'pending'.freeze
  CANCEL = 'cancel'.freeze

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}

  before_create :prepare_code

  include TheUser::CourseSearching
  

  def english?
    self.name == 'Bahasa Inggris'
  end

  def computer?
    self.name == 'Komputer'
  end

  def grade?
    grade = self.result_test
    case grade
    when 1..6
      return 'BASIC'
    when 7..8
      return 'MEDIUM'
    when 9..10
      return 'ADVANCE'
    else
      return 'BELUM TEST'
    end
  end

  private
    def prepare_code
      self.code = '#'+ 5.times.map{Random.rand(10)}.join
    end
end
