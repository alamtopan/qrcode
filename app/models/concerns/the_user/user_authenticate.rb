module TheUser
  module UserAuthenticate
    extend ActiveSupport::Concern
    included do
      attr_accessor :login

      def authenticate(login, password)
        user = where("username = :login OR email = :login", { login: login }).first
        return nil unless user
        return nil unless user.valid_password?(password)
        user
      end

      def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        else
          where(conditions).first
        end
      end

      def login=(login)
        @login = login
      end

      def login
        @login || self.username || self.email
      end
      
    end
  end
end