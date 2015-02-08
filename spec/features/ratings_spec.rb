require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  ## tehtävän 6 lisäykset, joita ei voi käyttää, koska muuten taas
  # testi "when given, is registered to the beer and user who is signed in" ei toimi
  # let!(:rating) { FactoryGirl.create :rating, beer:beer1 }
  # let!(:rating2) { FactoryGirl.create :rating, beer:beer2 }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.rating_average).to eq(15.0)
  end

  it "lists the ratings and their total number" do
    FactoryGirl.create :rating, beer:beer1, user:user
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{Rating.count}"
    save_and_open_page
  end

  it "lists user's ratings and their total number" do
    FactoryGirl.create :beer, name:"testi", brewery:brewery
    FactoryGirl.create :rating, beer:beer1, score:22
    FactoryGirl.create :rating, beer:beer1, user:user
    FactoryGirl.create :rating, beer:beer2, user:user
    visit user_path(user)
    user.ratings.each do |beer_name|
      expect(page).to have_content beer_name
    end
    expect(page).not_to have_content "22"

  end

  it "lists the ratings and their total number" do
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{Rating.count}"

  end

  it "lists user's ratings and their total number" do
    FactoryGirl.create :rating, beer:beer1, user:user
    FactoryGirl.create :rating, beer:beer2, user:user
    visit user_path(user)
    
  end


end