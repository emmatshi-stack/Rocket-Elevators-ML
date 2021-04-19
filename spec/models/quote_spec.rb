require 'rails_helper'

RSpec.describe Quote, type: :model do
  subject {
    described_class.new(quotes_email: 'gh',
                        unit_price:12345,
                        building_type: "fhg")
  }
# checking the validity of a quote without a building type
  it "is not valid without a building_type" do
    subject.building_type = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a unit_price
  it "is not valid without a unit_price" do
    subject.unit_price = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a unit_price  
  it "is not valid without a quotes_email" do
    subject.quotes_email = nil
    expect(subject).to_not be_valid
  end

end
