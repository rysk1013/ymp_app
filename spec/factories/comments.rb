FactoryBot.define do
  factory :comment do
    text {'コメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメント'}
    association :user
    association :post
  end
end
