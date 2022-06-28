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

    it "renders #edit template" do
      user = create(:user)
      get :edit, params: { id: user }
      expect(response).to render_template(:edit)
    end

    it "assign the requested user to @user" do
      user = create(:user)
      get :edit, params: { id: user }
      expect(assigns(:user)).to eq user
    end
  end
  
  describe 'GET #new' do
    it "returns a 200 HTTP Status" do
      get :new
      expect(response).to have_http_status(:ok)
    end

    it "renders #new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it "returns a 302 redirect HTTP status after post valid user" do
      post :create, params: {user: attributes_for(:user)}
      expect(response).to have_http_status(302)
    end

    context "with valid objects" do
      it "saves new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "redirects to users#show after creating new user" do
        post :create, params: {user: attributes_for(:user)}
        expect(response).to redirect_to(user_path(assigns[:user]))
      end
    end

    context "with invalid objects" do
      it "doesn't save new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:invalid_user)}
        }.not_to change(User, :count)
      end

      it "re-renders users#new after creating invalid user" do
        post :create, params: {user: attributes_for(:invalid_user)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @user = create(:user)
    end

    context "with valid objects" do
      
    end
  end
end