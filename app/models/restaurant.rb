class Restaurant < ApplicationRecord
	has_many :tables
	has_many :comments
	has_many :favorites
	has_many :rates

	validates :name, uniqueness: true, presence: true
end
