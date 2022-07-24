require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it 'works' do
    vehicle = Vehicle.new(stock_type: :new, fuel_type: :electric)
    expect(vehicle.stock_type_new?).to be true
  end

  describe "Validations" do
    context 'valid attributes' do
      let(:vehicle1) { Vehicle.new(stock_type: "new", co2: 0) }
      specify do
        expect(vehicle1.valid?).to be_truthy
      end
    end

    context 'invalid attributes' do
      let(:vehicle2) { Vehicle.new(stock_type: "new", co2: -1) }
      specify do
        expect(vehicle2.valid?).to be_falsey
      end
    end
  end 
  
  describe "Calculate_tax" do
    context "used vehicles" do
      let(:used_vehicle) { Vehicle.create(stock_type: "used", co2: 0) }

      it "tax for used vehicle is eq to 0" do
        expect(used_vehicle.vehicle_tax).to eql(0)
      end
    end

    context "new vehicles" do
      let(:new_commercial_vehicle_diesel) { Vehicle.create(stock_type: "new", commercial_vehicle: true, co2: 0, fuel_type: "diesel") }

      it "tax for new commercial vehicle (petrol or diesel) is eq to £290 + £55 = £345" do
        expect(new_commercial_vehicle_diesel.vehicle_tax).to eql(345)
      end

      let(:new_commercial_vehicle_electric) { Vehicle.create(stock_type: "new", commercial_vehicle: true, co2: 0, fuel_type: "electric") }

      it "tax for new commercial vehicle (electric) is eq to £55 (just registration fee)" do
        expect(new_commercial_vehicle_electric.vehicle_tax).to eql(55)
      end

      let(:new_non_commercial_vehicle_petrol) { Vehicle.create(stock_type: "new", commercial_vehicle: false, co2: 255 , fuel_type: "petrol") }

      it "tax for new non-commercial vehicle (petrol) with co2 emission of 255 is eq to £2015 + £55 = £2070" do
        expect(new_non_commercial_vehicle_petrol.vehicle_tax).to eql(2070)
      end

      let(:new_non_commercial_vehicle_hybrid) { Vehicle.create(stock_type: "new", commercial_vehicle: false, co2: 255 , fuel_type: "hybrid") }

      it "tax for new non-commercial vehicle (hybrid) with co2 emission of 255 is eq to £2005 + £55 = £2060" do
        expect(new_non_commercial_vehicle_hybrid.vehicle_tax).to eql(2060)
      end

      let(:new_non_commercial_vehicle_diesel) { Vehicle.create(stock_type: "new", commercial_vehicle: false, co2: 100 , fuel_type: "diesel") }

      it "tax for new non-commercial vehicle (diesel) with co2 emission of 100 is eq to £150 + £55 = £205" do
        expect(new_non_commercial_vehicle_diesel.vehicle_tax).to eql(205)
      end

      let(:new_non_commercial_vehicle_electric) { Vehicle.create(stock_type: "new", commercial_vehicle: false, co2: 100 , fuel_type: "electric") }

      it "tax for new non-commercial vehicle (electric) with co2 emission of 100 is eq to £140 + £55 = £195" do
        expect(new_non_commercial_vehicle_electric.vehicle_tax).to eql(195)
      end
    end
  end
end
