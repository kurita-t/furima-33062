FactoryBot.define do
  factory :purchase_address do
    postal_code   { '123-4567' }
    prefecture_id { 2 }
    municipality  { '名古屋市中村区' }
    address       { '則武1丁目9-19' }
    building_name { '建物名' }
    phone_number  { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
