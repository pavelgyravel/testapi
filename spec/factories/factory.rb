FactoryBot.define do
  factory :user do
    login {"#{Faker::Name.first_name}_#{Faker::Name.last_name}"}
    initialize_with { new(attributes) }
  end

  factory :post do
    title {Faker::Lorem.word}
    content {Faker::Lorem.sentence(word_count: rand(100))}
    author_ip {Faker::Internet.ip_v4_address}
    user
  end
end