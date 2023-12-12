FactoryBot.define do
  factory :comment do
    text { 'This is a comment.' }
    association :user, factory: :user
    association :post, factory: :post
  end
end
