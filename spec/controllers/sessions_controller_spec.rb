require 'rails_helper'

RSpec.describe SessionsController do
  describe 'Destroy' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it "empties user id sessions" do
      delete :destroy
      expect(session[:user_id]).to be(nil)
    end

    it "redirects to users path after destroyed" do
      delete :destroy
      expect(response).to redirect_to users_path
    end
  end
end