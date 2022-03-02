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
    has_many :products, foreign_key: "vendor_id"
    has_many :order_templates
    has_many :orders
    validates :email, uniqueness: true


    before_create :gen_auth_token

    def gen_auth_token(force = false)
        self.auth_token ||= SecureRandom.uuid
        # if force, change the auth_token-> logout
        self.auth_token = SecureRandom.uuid if force
    end

end
