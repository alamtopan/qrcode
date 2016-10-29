class Student < User
  default_scope {where(type: 'Student')}
  
  has_one :profile_student, foreign_key: 'user_id'
  accepts_nested_attributes_for :profile_student
  after_initialize :after_initialized

  has_many :attendances, foreign_key: 'user_id'
  scope :bonds, ->{eager_load(:profile_student)}

  include TheUser::StudentSearching

  def get_barcode?
    if self.profile_student.present? && self.profile_student.nis.present?
      RQRCode::QRCode.new("#{self.profile_student.nis}").to_img.resize(200, 200).to_data_url
    end
  end

  private
    def after_initialized
      self.profile_student = ProfileStudent.new if self.profile_student.blank?
    end
end