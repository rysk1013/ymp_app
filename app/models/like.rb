class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  with_options presence: true do
    validates :user_id
    validates :post_id
  end
end
