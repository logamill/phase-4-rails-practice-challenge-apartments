class Apartment < ApplicationRecord
    validates :number, numericality: {only_integer: true}
    
    has_many :leases 
    has_many :tenants, through: :leases
end
