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

      it "get current user donation details" do
        get :index

        @user2 = create(:user, email: "emailbaru@email.com", phone: "081294111113")

        @donation_detail_1 = create(:donation_detail, 
          user_id: @user.id,
          donation_id: @donation.id,
          )
        
        @donation_detail_2 = create(:donation_detail, 
          user_id: @user2.id,
          donation_id: @donation.id,
          )
        
        expect(assigns(:donation_details)).to match_array([@donation_detail_1])
      end
    end

    context "with not logged in user" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #new' do
    context "with logged in user" do
      before :each do
        @user = create(:user)
        @donation = create(:donation, user_id: @user.id)
  
        session[:user_id] = @user.id
      end
      
      it "recieves id from params" do
        get :new, params: {id: @donation}
        expect(assigns(:donation_id)).to eq(@donation.id.to_s)
      end

      it "renders #index template" do
        get :new, params: {id: @donation}
        expect(response).to render_template(:new)
      end
    end

    context "with not logged in user" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #create' do
    context "with logged in user" do
      before :each do
        @user = create(:user)
        @donation = create(:donation, user_id: @user.id)
  
        session[:user_id] = @user.id
      end

      context "with valid objects" do
        it "saves new donation history in the database" do
          expect{
            post :create, params: {
              id: @donation, 
              donation_detail: attributes_for(:donation_detail)}
          }.to change(DonationDetail, :count).by(1)
        end
      end
    end

    context "with not logged in user" do
      
    end
  end
end