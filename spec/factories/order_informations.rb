FactoryBot.define do
  factory :order_information do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
    phone_number { '0123456789' }
    token {"tok_abcdefghijk00000000000000000"}
    association :user, :item
  end
end
