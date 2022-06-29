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
    context "with valid credentials" do
      it "assign email to params" do
        @user = create(:user_register, email: "contoh@gmail.com")
        post :create, params: {email: "contoh@gmail.com"}
        expect(assigns(:user)).to eq @user
      end

      it "gives session when login" do
        @user = create(:user_register, email: "contoh@gmail.com", password: "123", password_confirmation: "123")
        post :create, params: {email: "contoh@gmail.com", password: "123"}
        expect(session[:user_id]).to eq(@user.id)
      end

      it "redirects after successful login" do
        @user = create(:user_register, email: "contoh@gmail.com", password: "123", password_confirmation: "123")
        post :create, params: {email: "contoh@gmail.com", password: "123"}
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid credentials" do
      it "didn't give session" do
        @user = create(:user_register, email: "contoh@gmail.com", password: "123", password_confirmation: "123")
        post :create, params: {email: "contoh@gmail.com", password: "1234"}
        expect(session[:user_id]).to eq(nil)
      end

      it "redirects to login after failed login" do
        @user = create(:user_register, email: "contoh@gmail.com", password: "123", password_confirmation: "123")
        post :create, params: {email: "contoh@gmail.com", password: "1234"}
        expect(response).to redirect_to login_path
      end
    end
  end
end