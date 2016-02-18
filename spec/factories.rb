FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'

    # if needed
    # is_active true
  end

  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email "#{Faker::Internet.user_name}@#{Faker::Internet.domain_name}"
    country Faker::Address.country
    city Faker::Address.city
    postal_code Faker::Address.postcode
    region Faker::Address.state
    address_code Faker::Address.street_address
    organisation_name Faker::Company.name
  end
end