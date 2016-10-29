class ProfileStudent < ActiveRecord::Base
  belongs_to :student, foreign_key: 'user_id'

  # validates :nis, presence: true, uniqueness: { case_sensitive: false }

  def place_info
    [address, province, city].select(&:'present?').join(', ')
  end
end
