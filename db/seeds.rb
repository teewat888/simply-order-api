#reset prmiary key to 1 for each drop
ActiveRecord::Base.connection.reset_pk_sequence!('roles')

roles = ['admin', 'vendor', 'customer']
roles.each { |role| Role.create(name: role)}

admin = User.create(email: 'teeat@yahoo.com', password: '111111', role_id: 1)

