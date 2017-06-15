class Confirmation < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  PAID = 'paid'.freeze
  PENDING = 'pending'.freeze
  CANCEL = 'cancel'.freeze

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}

  include TheUser::ConfirmationSearching
end
