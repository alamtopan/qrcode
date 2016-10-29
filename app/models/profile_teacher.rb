class ProfileTeacher < ActiveRecord::Base
  belongs_to :teacher, foreign_key: 'user_id'

  # validates :nik, presence: true, uniqueness: { case_sensitive: false }

  def place_info
    [address, province, city].select(&:'present?').join(', ')
  end
end
