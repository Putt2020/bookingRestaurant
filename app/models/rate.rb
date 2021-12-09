class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  #validates :rate_score, :inclusion => 0..5
  validates :rate_score, inclusion: { in: 0..5, message: "out of range(0-5)"}
  validates :rate_score, numericality: { only_integer: true, message: "only integer allow" }

end
