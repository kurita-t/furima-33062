FactoryBot.define do
  factory :product do
    name             {"SONY MODEL:WH-900N ヘッドホン"}
    description      {Faker::Lorem.sentence}
    category_id      {2}
    condition_id     {2}
    shipping_cost_id {2}
    prefecture_id    {5}
    shipping_day_id  {2}
    price            {3000}

    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
