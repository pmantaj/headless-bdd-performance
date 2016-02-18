# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Customer.count == 0
  20000.times do |i|
    Customer.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}",
        country: Faker::Address.country,
        city: Faker::Address.city,
        postal_code: Faker::Address.postcode,
        region: Faker::Address.state,
        address_code: Faker::Address.street_address,
        organisation_name: Faker::Company.name
    )
  end
end