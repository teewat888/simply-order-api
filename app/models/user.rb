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
class User < ApplicationRecord
    has_secure_password 
    belongs_to :role
    validates :email, uniqueness: true

    before_create :gen_auth_token
    def gen_auth_token(force = false)
        self.auth_token ||= SecureRandom.uuid
        # if force, change the auth_token-> logout
        self.auth_token = SecureRandom.uuid if force
    end

    def jwt(exp = 1.days.from_now)
        payload = { exp: exp.to_i, auth_token: self.auth_token }
        JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256'
    end
end
