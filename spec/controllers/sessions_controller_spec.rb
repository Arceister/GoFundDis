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
    end
  end
end