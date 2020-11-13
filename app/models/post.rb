class Post < ApplicationRecord
  has_many :comment #dependent: :destroy
end
