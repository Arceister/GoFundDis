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

  describe 'GET #index' do
    it "returns a 200 HTTP Status" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "renders #index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "populate array of users" do
      user1 = create(:user, email: "email1@email.com", phone: "089876543210")
      user2 = create(:user, email: "email2@email.com", phone: "089876543211")

      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end 

  describe 'GET #edit' do
    it "returns a 200 HTTP Status" do
      user = create(:user)
      get :edit, params: { id: user }
      expect(response).to have_http_status(:ok)
    end
  end
end