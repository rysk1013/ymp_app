FactoryBot.define do
  factory :user do
    nickname {'ユーザー'}
    email {'user@email.com'}
    password {'111aaa'}
    password_confirmation {password}
    profile {'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト'}
  end
end
