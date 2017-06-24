require 'rails_helper'

describe Profile do
  let(:user)    { FactoryGirl.create(:user, first_name: "david", last_name: "moore", email: "david@moore.com") }
  let(:profile) { Profile.new(user) }

  it "returns a profile for the class it decorates" do
    expect(profile.model_name.name).to eq "Profile"
  end

  it "returns a route_key for the class it decorates" do
    expect(profile.model_name.route_key).to eq "profiles"
  end

end