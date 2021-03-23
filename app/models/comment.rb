class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  with_options presence: true do
    validates :text
    validates :post
    validates :user
  end
end
