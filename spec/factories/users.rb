FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    write_last_name {"山田"}
    write_first_name {"太郎"}
    read_last_name {"ヤマダ"}
    read_first_name {"タロウ"}
    birth_date {Faker::Date.in_date_period}
    email {Faker::Internet.free_email}
    password = "111aaa"
    password {password}
    password_confirmation {password}
  end
end