FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password123' }
    name { 'Assem' }
    posts_counter { 0 }
  end
end
