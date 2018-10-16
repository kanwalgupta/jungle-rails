class User < ActiveRecord::Base
    has_secure_password
    validates :password, presence: true
    validates_length_of :password, :minimum => 6
    validates :password_confirmation, presence: true
    validates :name, presence: true
    validates :email, presence: true
    validates :password, :confirmation => true
    validates :email, :uniqueness => { :case_sensitive => false }
     def self.authenticate_with_credentials(email, password)
      email = email.gsub(/\s+/, "")
      if(user = User.find_by('lower(email) = ?', email.downcase))
        user.authenticate(password)
      else
        nil
      end
    end
end
