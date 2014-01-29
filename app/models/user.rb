class User < ActiveRecord::Base
	has_many :tasks, dependent: :destroy

	validates_presence_of :email, :password_digest, unless: :guest?
	validates_uniqueness_of :email, allow_blank: true
	validates_confirmation_of :password
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, on: :create, unless: :guest?

	has_secure_password(validations: false)

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.new_guest
		new { |u| u.guest = true }
	end

	def name
  		guest ? "Guest" : email
	end

	def move_to(user)
  		tasks.update_all(user_id: user.id)
	end

end
