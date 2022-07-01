require 'rails_helper'

RSpec.describe DonationsController do
  describe 'GET #show' do
    it "returns a 200 HTTP Status" do
      @donation = create(:donation)
      get :show, params: {id: @donation}
      expect(response).to have_http_status(:ok)
    end

    it "renders #show template" do
      @donation = create(:donation)
      get :show, params: {id: @donation}
      expect(response).to render_template(:show)
    end

    it "assign the requested donation to @donation" do
      @donation = create(:donation)
      get :show, params: {id: @donation}
      expect(assigns[:donation]).to eq @donation
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

    it "populate array of donations" do
      @donation1 = create(:donation, title: "Some Title")
      @donation2 = create(:donation, title: "Some Title 2")

      get :index
      expect(assigns(:donations)).to match_array([@donation1, @donation2])
    end
  end

  describe 'GET #new' do
    context "with logged in user" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end

      it "renders #new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  end
end