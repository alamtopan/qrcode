class Teacher < User
  default_scope {where(type: 'Teacher')}
  
  has_one :profile_teacher, foreign_key: 'user_id'
  accepts_nested_attributes_for :profile_teacher
  after_initialize :after_initialized
  
  scope :bonds, ->{eager_load(:profile_teacher)}

  include TheUser::TeacherSearching

  private
    def after_initialized
      self.profile_teacher = ProfileTeacher.new if self.profile_teacher.blank?
    end
end