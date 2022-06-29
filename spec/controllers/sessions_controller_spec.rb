require 'rails_helper'

RSpec.describe SessionsController do
  describe 'Destroy' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end
  end
end