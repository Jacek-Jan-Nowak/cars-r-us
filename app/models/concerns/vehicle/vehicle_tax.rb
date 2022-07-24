module Vehicle::VehicleTax
  extend ActiveSupport::Concern
  include TaxRate

  included do
    before_save :calculate_tax
  end

  private

  def calculate_tax
    self.stock_type_new? ? new_vehicle_tax : used_vehicle_tax
  end

  def used_vehicle_tax
    self.vehicle_tax = 0
  end

  def new_vehicle_tax
    self.commercial_vehicle ? new_vehicle_tax_commercial : new_vehicle_tax_non_commercial
    self.vehicle_tax += TaxRate::REGISTRATION_FEE[0]
  end

  def new_vehicle_tax_non_commercial
    new_vehicle_tax_non_commercial_petror_or_diesel if self.petrol? || self.diesel?
    new_vehicle_tax_non_commercial_electric_or_hybrid if self.electric? || self.hybrid?
  end

  def new_vehicle_tax_commercial
    new_vehicle_tax_commercial_petror_or_diesel if self.petrol? || self.diesel?
    new_vehicle_tax_commercial_electric_or_hybrid if self.electric? || self.hybrid?
  end

  def new_vehicle_tax_non_commercial_petror_or_diesel
    self.vehicle_tax =  TaxRate::TC48_AND_TC49_CO2_TAX_RATES[
      calculate_tax_rate_for_co2_emission
    ] 
  end

  def new_vehicle_tax_non_commercial_electric_or_hybrid
    self.vehicle_tax = TaxRate::TC59_CO2_TAX_RATES[
      calculate_tax_rate_for_co2_emission
    ] 
  end

  def new_vehicle_tax_commercial_petror_or_diesel
    self.vehicle_tax = TaxRate::TC39_TAX_RATE[0] 
  end

  def new_vehicle_tax_commercial_electric_or_hybrid
    self.vehicle_tax = 0
  end

  def calculate_tax_rate_for_co2_emission
    case self.co2
      when 0
        0
      when 1..50
        1
      when 51..75
        2
      when 76..90
        3
      when 91..100
        4
      when 101..110
        5
      when 111..130
        6
      when 131..150
        7
      when 151..170
        8
      when 171..190
        9
      when 191..225
        10
      when 226..255
        11
      else
        12
    end
  end
end