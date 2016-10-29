class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  devise  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
          :validatable, :lockable, :timeoutable, :authentication_keys => [:login]

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  has_many :attendances

  mount_uploader :avatar, ImageUploader

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}
  scope :by_name, ->{order(username: :asc)}

  include TheUser::UserAuthenticate

  def is_teacher?
    self.type == "Teacher"
  end

  def is_student?
    self.type == "Student"
  end

  def is_admin?
    self.type == "Admin"
  end
end
