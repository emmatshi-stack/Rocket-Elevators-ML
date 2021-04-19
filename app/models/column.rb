class Column < ApplicationRecord
    belongs_to :battery
    has_many :elevators
    has_one :intervention
    
end
