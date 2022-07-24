class Vehicle < ApplicationRecord
  enum stock_type: { new: 'new', used: 'used'}, _prefix: true
  enum fuel_type: { electric: 'electric', hybrid: 'hybrid', petrol: 'petrol', diesel: 'diesel'}

  validates :stock_type, presence: true
  validates_numericality_of :co2, :only_integer => true, :greater_than_or_equal_to => 0

  include Vehicle::VehicleTax

  # ...
  # 100s of lines of code deleted, as they are not relevant to this task
  # but if they were included this would be a big model
  # ...

end
