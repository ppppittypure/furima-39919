FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { 1 }
    municipalities { '東京都' }
    street_address { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { '00000000000' }
    token { "tok_abcdefghijk00000000000000000" }
  end
end
