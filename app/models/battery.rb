class Battery < ApplicationRecord
    belongs_to :building
    has_many :columns
    has_one :intervention
    validates_presence_of :type_building
    validates_presence_of :certificate_operations
    validates_presence_of :status

end
