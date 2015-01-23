class User < ActiveRecord::Base
	validates :username, uniqueness: true, presence: true, length: { minimum: 6}
	has_secure_password
	validates :password, presence: true, length: { minimum: 8}
end
