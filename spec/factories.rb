#By using a symbol :user will let Factory_Girl simulate the User model
FactoryGirl.define do
  factory :user do |user|
    user.name 'lenin george'
    user.email 'lening@email.com'
    user.password 'test_pass'
    user.password_confirmation 'test_pass'
  end
end
