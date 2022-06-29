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
    context "with logged in user" do
      before :each do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      it "show current user" do
        get :edit
        expect(assigns(:user)).to eq User.find(session[:user_id])
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        get :edit
        expect(response).to redirect_to login_path
      end
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
      post :create, params: {user: attributes_for(:user_register)}
      expect(response).to have_http_status(302)
    end

    context "with valid objects" do
      it "saves new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:user_register)}
        }.to change(User, :count).by(1)
      end

      it "redirects to users#show after creating new user" do
        post :create, params: {user: attributes_for(:user_register)}
        expect(response).to redirect_to(user_path(assigns[:user]))
      end

      it "adds session when creating user success" do
        post :create, params: {user: attributes_for(:user_register)}
        expect(session[:user_id]).not_to be(nil)
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

    it "returns a 302 redirect HTTP status after updated valid user" do
      patch :update, params: {id: @user, user: attributes_for(:user)}
      expect(response).to have_http_status(302)
    end

    context "with valid objects" do
      it "accepts requested @user" do
        patch :update, params: {id: @user, user: attributes_for(:user)}
        expect(assigns(:user)).to eq @user
      end

      it "changes @user" do
        patch :update, params: {id: @user, user: attributes_for(:user, email: 'emailbaru@email.com')}
        @user.reload
        expect(@user.email).to eq('emailbaru@email.com')
      end

      it "redirects to @user #show" do
        patch :update, params: {id: @user, user: attributes_for(:user)}
        expect(response).to redirect_to @user
      end
    end

    context "with invalid objects" do
      it "doesn't save updated user in the database" do
        patch :update, params: {id: @user, user: attributes_for(:user, email: 'emailbaru@email.com', password: nil)}
        expect(@user.email).not_to eq('emailbaru@email.com')
      end

      it "re-renders #edit after updating invalid user" do
        patch :update, params: {id: @user, user: attributes_for(:invalid_user)}
        expect(assigns(:user)).to eq @user
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
    end

    it "returns a 302 HTTP Status" do
      delete :destroy, params: { id: @user }
      expect(response).to have_http_status(302)
    end

    it "deletes user from database" do
      expect{
        delete :destroy, params: { id: @user }
      }.to change(User, :count).by(-1)
    end

    it "redirects to #index after delete" do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to users_url
    end
  end
end