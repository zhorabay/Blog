FactoryBot.define do
  factory :post do
    title { 'Sample Post' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
  end
end