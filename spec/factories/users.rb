FactoryGirl.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end
end

FactoryGirl.define do
  factory :user_admin, class: User do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    role 'admin'
  end
end