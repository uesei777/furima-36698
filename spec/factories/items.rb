FactoryBot.define do
  factory :item do
    product { Faker::Name.name }
    explanation { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 11) }
    status_id { Faker::Number.between(from: 2, to: 7) }
    delivery_fee_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    days_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
