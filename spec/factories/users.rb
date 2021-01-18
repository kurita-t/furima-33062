FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    family_name  {"山田"}
    first_name {"太郎"}
    family_name_kana  {"ヤマダ"}
    first_name_kana {"タロウ"}
    birth_day {"2000-01-01"}
  end
end