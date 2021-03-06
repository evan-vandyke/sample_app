class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	before_save { self.email = email.downcase}
	before_create :create_remember_token
	validates :name,presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
					  uniqueness: { case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		#returns random string of length 16, composed of characters A-Z, a-z, 0-9,"-","_"
		SecureRandom.urlsafe_base64
	end

	def feed
		#this is prelimary - see following users for full implementation
		Micropost.where("user_id = ?", id)
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private 

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
