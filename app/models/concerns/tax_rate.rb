module TaxRate
  extend ActiveSupport::Concern

  included do
    TC48_AND_TC49_CO2_TAX_RATES = [
      0, 10, 25, 120, 150, 170, 190, 230, 585, 945, 1420, 2015, 2365 
    ]

    TC59_CO2_TAX_RATES = [
      0, 0, 15, 110, 140, 160, 180, 220, 575, 935, 1410, 2005, 2355
    ]

    TC39_TAX_RATE = [
      290
    ]

    REGISTRATION_FEE = [
      55
    ]

  end
end
