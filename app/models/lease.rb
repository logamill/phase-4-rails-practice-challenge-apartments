class Lease < ApplicationRecord
    validates :rent, numericality: { only_integer: true }
    validates :tenant_id, presence: true, numericality: { only_integer: true }
    validates :apartment_id, presence: true, numericality: { only_integer: true }


    belongs_to :tenant
    belongs_to :apartment 
end
