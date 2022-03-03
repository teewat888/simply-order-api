#reset prmiary key to 1 for each drop
ActiveRecord::Base.connection.reset_pk_sequence!('roles')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

roles = ['admin', 'vendor', 'customer']
roles.each { |role| Role.create(name: role)}

admin = User.create(email: 'teewat@yahoo.com', password: '1111', role_id: 1)

5.times do 
    company_name = Faker::Company.name
    clean_company_name = company_name.downcase.delete(' ,\'') 
    email = clean_company_name + '@' + clean_company_name + '.com'
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: email,
        company_name: company_name,
        address_number: Faker::Address.building_number,
        address_street: Faker::Address.street_name,
        address_suburb: Faker::Address.city,
        address_state: Faker::Address.state,
        contact_number: Faker::PhoneNumber.cell_phone,
        password: '1111',
        role_id: 3
    )
end

5.times do 
    company_name = Faker::Company.name
    clean_company_name = company_name.downcase.delete(' ,\'') 
    email = clean_company_name + '@' + clean_company_name + '.com'
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: email,
        company_name: company_name,
        address_number: Faker::Address.building_number,
        address_street: Faker::Address.street_name,
        address_suburb: Faker::Address.city,
        address_state: Faker::Address.state,
        contact_number: Faker::PhoneNumber.cell_phone,
        password: '1111',
        role_id: 2
    )
end

units = ['Pc(s)','Each','A1 Can','540ml Can','Carton']

100.times do
    Product.create(
        name: Faker::Commerce.product_name,
        brand: Faker::Commerce.brand,
        unit: units.sample,
        vendor_id: rand(7..11)
    )
end