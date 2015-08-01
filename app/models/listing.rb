class Listing < ActiveRecord::Base
  belongs_to :user
  validates :user, presence:  true
  has_many :offers
end
