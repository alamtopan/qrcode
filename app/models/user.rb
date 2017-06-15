class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  devise  :database_authenticatable, :registerable, :authentication_keys => [:login]

  validates :username, presence: true
  validates :email, presence: true
  validates_uniqueness_of :username, :email

  mount_uploader :photo, ImageUploader

  has_many :courses
  has_many :confirmations

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}
  scope :by_name, ->{order(username: :asc)}

  include TheUser::UserAuthenticate

  def is_student?
    self.type == "Student"
  end

  def is_admin?
    self.type == "Admin"
  end
end
