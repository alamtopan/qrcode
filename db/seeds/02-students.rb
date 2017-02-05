module SeedStudent
  def self.seed
    (1..20).each do |v|
      Student.find_or_create_by!(username: "student_#{v}") do |s|
        s.email = "student_#{v}@yahoo.com"
        s.password = "12345678"
        s.password_confirmation = "12345678"
        s.type = "Student"
        s.confirmation_token = nil
        s.confirmed_at = Time.now
        s.avatar = File.new("#{Rails.root}/app/assets/images/default.png")

        if s.save
          p = ProfileStudent.find_or_create_by(user_id: s.id)
          p.nis = "AIB00#{v}"
          p.student_class = StudentClass.to_a.map{|c| c[0]}.shuffle.sample
          p.first_name = "First_#{v}" 
          p.last_name = "Last_#{v}"
          p.born = Date.today - 20.year
          p.gender = 'Male'
          p.province = 'Jawa Barat'
          p.city = 'Sukabumi'
          p.phone = rand(0000..9999).to_s.rjust(12, "0")
          p.address = "Jl.lembursitu #{v}"
          p.parent_name = "Parent_#{v}"
          p.parent_address = "Jl.lembursitu #{v}"
          p.parent_contact = rand(0000..9999).to_s.rjust(12, "0")
          p.parent_job = 'Wirausaha'
          if p.save
            (1..320).each do |v|
              a = Attendance.new
              a.user_id = s.id
              a.status = 'attend'
              a.created_at = Date.today - v.day
              a.save
            end
          end
        end
      end
    end
  end
end