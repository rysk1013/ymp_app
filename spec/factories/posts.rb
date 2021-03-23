FactoryBot.define do
  factory :post do
    title {'aaaaaaタイトル'}
    overview {'テストテストテストテストテストテストテストテストテストテストテストtesttesttest'}
    programming_languages {'HTML, CSS, Ruby, Ruby on Rails'}
    techs {'AWS, Docker, CircleCI/CD'}
    portfolio_url {Faker::Internet.url(host: 'example.com', path: '/foobar.html')}
    github_url {Faker::Internet.url(host: 'example.com', path: '/foobar.html')}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/sample5.jpeg'), filename: 'sample5.jpeg')
    end
  end
end
