require 'rails_helper'

RSpec.describe Battery, type: :model do
  subject {
    described_class.new(status: 'gh',
                        type_building: 'gh',
                        certificate_operations: "fhg")
  }

  
# checking the validity of a quote without a status
  it "is not valid without a status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a type_building
  it "is not valid without a type_building" do
    subject.type_building = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a certificate_operations
  it "is not valid without a certificate_operations" do
    subject.certificate_operations = nil
    expect(subject).to_not be_valid
  end

  
end
