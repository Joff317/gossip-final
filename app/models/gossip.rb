class Gossip < ApplicationRecord
   validates :title, length: {minimum: 3, maximum: 50}, presence: true
   validates :content, presence: true
   belongs_to :user
   has_many :tags
   has_many :comments
   has_many :likes, dependent: :destroy
end
