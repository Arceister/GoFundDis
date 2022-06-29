FactoryBot.define do
  factory :donation do
    title { "MyString" }
    current { 1 }
    need { 1 }
    deadline { "2022-06-30 01:11:07" }
  end
end
