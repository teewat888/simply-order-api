require 'csv'

#reset prmiary key to 1 for each drop
ActiveRecord::Base.connection.reset_pk_sequence!('roles')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

roles = ['admin', 'vendor', 'customer']
roles.each { |role| Role.create(name: role)}

User.create(email: 'teewat@yahoo.com', password: '1111', role_id: 1, company_name: 'myself',first_name: 'Tee', last_name: 'Tee') #id=1
User.create(email: 'teewat76-aroyd@yahoo.com', password: '1111', role_id: 3, company_name: 'Aroy-D Thai restaurant',first_name: 'Aroy-D Thai restaurant', last_name: 'Aroy-D Thai restaurant') #id=2
User.create(email: 'teewat76-tangola@yahoo.com', password: '1111', role_id: 2, company_name: 'Tangola',first_name: 'Tangola', last_name: 'Tangola')#id=3
User.create(email: 'teewat76-vegetable@yahoo.com', password: '1111', role_id: 2, company_name: 'Vegetable',first_name: 'Vegetable', last_name: 'Vegetable')#id=4
User.create(email: 'teewat76-meat@yahoo.com', password: '1111', role_id: 2, company_name: 'Meat',first_name: 'Meat', last_name: 'Meat')#id=5
User.create(email: 'teewat76-container@yahoo.com', password: '1111', role_id: 2, company_name: 'Container',first_name: 'Container', last_name: 'Container')#id=6
User.create(email: 'teewat76-seafood@yahoo.com', password: '1111', role_id: 2, company_name: 'Seafood',first_name: 'Seafood', last_name: 'Seafood')#id=7


#import product from csv
text = File.read("products_all.csv")
csv = CSV.parse(text, :headers => true)
csv.each do |row|
  row = row.to_hash.with_indifferent_access
  Product.create!(row.to_hash.symbolize_keys)
end

# 5.times do 
#     company_name = Faker::Company.name
#     clean_company_name = company_name.downcase.delete(' ,\'') 
#     email = clean_company_name + '@' + clean_company_name + '.com'
#     User.create(
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name,
#         email: email,
#         company_name: company_name,
#         address_number: Faker::Address.building_number,
#         address_street: Faker::Address.street_name,
#         address_suburb: Faker::Address.city,
#         address_state: Faker::Address.state,
#         contact_number: Faker::PhoneNumber.cell_phone,
#         password: '1111',
#         role_id: 3
#     )
# end

# 5.times do 
#     company_name = Faker::Company.name
#     clean_company_name = company_name.downcase.delete(' ,\'') 
#     email = clean_company_name + '@' + clean_company_name + '.com'
#     User.create(
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name,
#         email: email,
#         company_name: company_name,
#         address_number: Faker::Address.building_number,
#         address_street: Faker::Address.street_name,
#         address_suburb: Faker::Address.city,
#         address_state: Faker::Address.state,
#         contact_number: Faker::PhoneNumber.cell_phone,
#         password: '1111',
#         role_id: 2
#     )
# end

# units = ['Pc(s)','Each','A1 Can','540ml Can','Carton']

# 100.times do
#     Product.create(
#         name: Faker::Commerce.product_name,
#         brand: Faker::Commerce.brand,
#         unit: units.sample,
#         vendor_id: rand(7..11)
#     )
# end