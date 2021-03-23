class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  with_options presence: true do
    validates :post_id
    validates :tag_id
  end
end
