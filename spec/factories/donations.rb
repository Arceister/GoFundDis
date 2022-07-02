FactoryBot.define do
  factory :donation do
    title { "MyString" }
    current { 1 }
    need { 1 }
    deadline { DateTime.now >> 1 }
  end
end
