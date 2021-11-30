class User < ApplicationRecord
	has_many :appointment
	has_many :comment
	has_many :favorite
	has_many :rate

	validates :email, uniqueness: true, presence: true
	validates :name, presence: true
	validates :password, presence: true
	validates :password, confirmation: { case_sensitive: true }

	has_secure_password
end