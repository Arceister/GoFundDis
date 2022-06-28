require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET #show' do
    it "returns a 200 HTTP Status" do
      user = create(:user)
      get :show, params: { id: user }
      expect(response).to have_http_status(:ok)
    end

    it "renders #show template" do
      user = create(:user)
      get :show, params: { id: user }
      expect(response).to render_template(:show)
    end

    it "assign the requested user to @user" do
      user = create(:user)
      get :show, params: { id: user }
      expect(assigns(:user)).to eq user
    end
  end
end