require 'rails_helper'

RSpec.describe DonationDetailsController do
  describe 'GET #show' do
    before :each do
      @user = create(:user)
      @donation = create(:donation, user_id: @user.id)

      @donation_detail = create(:donation_detail, 
        user_id: @user.id,
        donation_id: @donation.id,
        )
    end

    it "returns a 200 HTTP Status" do
      get :show, params: {id: @donation_detail}
      expect(response).to have_http_status(:ok)
    end

    it "renders #show template" do
      get :show, params: {id: @donation_detail}
      expect(response).to render_template(:show)
    end

    it "assign the requested @donation_detail" do
      get :show, params: {id: @donation_detail}
      expect(assigns[:donation_detail]).to eq @donation_detail
    end
  end

  describe 'GET #index' do
    context "with logged in user" do
      before :each do
        @user = create(:user)
        @donation = create(:donation, user_id: @user.id)
  
        session[:user_id] = @user.id
      end

      it "returns a 200 HTTP Status" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "renders #index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "with not logged in user" do
      
    end
  end
end