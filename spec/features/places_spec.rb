require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("tampere").and_return(
                                 [ Place.new( name:"O'Connell's Irish Bar", id: 1 ),
                                  Place.new( name:"Pyynikin käsityöläispanimo", id: 2 ),
                                  Place.new( name:"Panimoravintola Plevna", id: 3 ) ]
                        )

    visit places_path
    fill_in('city', with: 'tampere')
    click_button "Search"

    expect(page).to have_content "O'Connell's Irish Bar"
    expect(page).to have_content "Pyynikin käsityöläispanimo"
    expect(page).to have_content "Panimoravintola Plevna"
  end

  it "if none is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("vantaa")

    visit places_path
    fill_in('city', with: 'vantaa')
    click_button "Search"

    expect(page).to have_content "No locations"
  end
end