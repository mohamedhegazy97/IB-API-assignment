class Chat < ApplicationRecord
  belongs_to :application
  has_many :message
  validates_uniqueness_of :number
end
