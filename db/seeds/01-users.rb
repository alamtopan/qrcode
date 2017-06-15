module SeedUser
  def self.seed
    User.find_or_create_by!(email: "admin@example.com") do |user|
      user.username = "adminmaster"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.type = "Admin"
    end
  end
end