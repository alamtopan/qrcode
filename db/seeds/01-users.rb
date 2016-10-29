module SeedUser
  def self.seed
    User.find_or_create_by!(email: "admin@yahoo.com") do |user|
      user.username = "adminmaster"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.type = "Admin"
      user.confirmation_token = nil
      user.confirmed_at= Time.now
    end
  end
end