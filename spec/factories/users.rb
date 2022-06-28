FactoryBot.define do
  factory :user do
    email { "some@email.com" }
    password { "123456abc" }
    name { "Some Name" }
    phone { "081234567890" }
    birthdate { "2012-06-27 21:03:27" }
    bio { "Some Bio" }
    picture { "MyText" }
  end
end
