# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  address_number  :string
#  address_state   :string
#  address_street  :string
#  address_suburb  :string
#  auth_token      :string
#  company_name    :string
#  contact_number  :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role_id         :bigint
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :auth_token
end
