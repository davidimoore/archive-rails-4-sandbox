class ProfilesController < ApplicationController
  def show
    @profile = Profile.new(current_user)
  end
end
