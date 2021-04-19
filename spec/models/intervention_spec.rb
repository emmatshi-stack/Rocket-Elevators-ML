require 'rails_helper'

RSpec.describe Intervention, type: :model do
  subject {
    described_class.new(author: 1,
                        customer_id: 1,
                        building_id: 1)
  }
# checking the validity of a quote without a author
  it "is not valid without a author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a customer_id
  it "is not valid without a customer_id" do
    subject.customer_id = nil
    expect(subject).to_not be_valid
  end
# checking the validity of a quote without a building_id
  it "is not valid without a building_id" do
    subject.building_id = nil
    expect(subject).to_not be_valid
  end
  
end
