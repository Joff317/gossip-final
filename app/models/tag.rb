class Tag < ApplicationRecord
   has_many :joins
   has_many :gossips, through: :joins
end
