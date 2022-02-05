class Apartment < ApplicationRecord

    validates :number, uniqueness: true

    has_many :leases
    has_many :tenants, through: :leases
    
end
