require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is created if name and style are set" do
    beer = Beer.create name:"Lapin kulta", style:"Lager"

    expect(Beer.count).to eq(1)
    expect(beer).to be_valid
  end

  it "is not created without name" do
    beer = Beer.create style:"Lager"

    expect(Beer.count).to eq(0)
    expect(beer).not_to be_valid
  end

  it "is not created without style" do
    beer = Beer.create name:"Lapin kulta"

    expect(Beer.count).to eq(0)
    expect(beer).not_to be_valid
  end
end
