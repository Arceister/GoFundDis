FactoryBot.define do
  factory :user do
    email { "some@email.com" }
    password_digest { "somepassword" }
    name { "Some Name" }
    phone { "081234567890" }
    birthdate { "2012-06-27 21:03:27" }
    bio { "Some Bio" }
    picture { "MyText" }
  end

  factory :invalid_user, parent: :user do
    email { nil }
    password_digest { nil }
    name { nil }
    phone { nil }
    birthdate { nil }
    bio { "Some Bio" }
    picture { "MyText" }
  end

  factory :user_register, parent: :user do
    email { "some@email.com" }
    password { "somepassword" }
    password_confirmation { "somepassword" }
    name { "Some Name" }
    phone { "081234567890" }
    birthdate { "2012-06-27 21:03:27" }
  end
end
