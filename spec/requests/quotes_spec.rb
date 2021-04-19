require 'rails_helper'

RSpec.describe "Quotes", type: :request do
  quotef = Quote.create(
    number_of_apartments:500,
    number_of_floors:89,
    quotes_company_name:"codeboxx",
    number_of_basements:6,
    number_of_companies:40,
    number_of_corporations:3,
    number_of_parking:300,
    number_of_elevators:20,
    maximum_occupancy:80,
    business_hours:24,
    product_line:"gh",
    install_fees:4000,
    total_price:300000,
    unit_price:12345,
    building_type:"commercial",
    final_price:300000000,
    elevator_amount:20,
    quotes_name:"tdd",
    quotes_email: "gggggggggg",
    quotes_company_name:'tdd'
  )
  it 'should contains some important field' do
    expect(quotef.elevator_amount).to be_a(Integer) 
    
  end

  it 'should contains some important field' do
    
    expect(quotef.building_type).to include("commercial")
  end

end

