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
  end
end