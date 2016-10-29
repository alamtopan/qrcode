module SeedTeacher
  def self.seed
    (1..20).each do |v|
      Teacher.find_or_create_by!(username: "teacher_#{v}") do |s|
        s.email = "teacher_#{v}@yahoo.com"
        s.password = "12345678"
        s.password_confirmation = "12345678"
        s.type = "Teacher"
        s.confirmation_token = nil
        s.confirmed_at = Time.now
        s.avatar = File.new("#{Rails.root}/app/assets/images/default.png")

        if s.save
          p = ProfileTeacher.find_or_create_by(user_id: s.id)
          p.nik = "NIK00#{v}"
          p.teacher_class = ['kelas1', 'kelas2', 'kelas3'].shuffle.sample
          p.first_name = "First_#{v}"
          p.last_name = "Last_#{v}"
          p.born = Date.today - 20.year
          p.gender = 'Male'
          p.province = 'Jawa Barat'
          p.city = 'Sukabumi'
          p.phone = rand(0000..9999).to_s.rjust(12, "0")
          p.address = "Jl.lembursitu #{v}"
          p.save
        end
      end
    end
  end
end