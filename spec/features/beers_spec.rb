require 'rails_helper'

describe "Beers page" do

    it "is added when given valid name" do
      visit new_beer_path
      fill_in('beer_name', with:'B')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "is redirected back to new beer page and not added when not given valid name" do
      visit new_beer_path
      fill_in('beer_name', with:'')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'Name is too short'
    end

  end