class User < ApplicationRecord
	has_many :appointments
	has_many :comments, dependent: :destroy
	has_many :favorites
	has_many :rates
	has_many :likes

	validates :email, uniqueness: true, presence: true
	validates :name, presence: true
	validates :password, presence: true, :if => :password
	validates :password, confirmation: { case_sensitive: true }

	has_secure_password
end