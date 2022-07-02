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

    context "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #edit' do
    context "with logged in user" do
      context "with valid creator user_id" do
        before :each do
          user = create(:user)
          session[:user_id] = user.id
        end

        it "renders #edit template" do
          donation = create(:donation, user_id: session[:user_id])
          get :edit, params: {id: donation}
          expect(response).to render_template :edit
        end
      end

      context "with invalid creator user_id" do
        before :each do
          user = create(:user)
          session[:user_id] = user.id
        end

        it "shows 401 unauthorized page" do
          user2 = create(:user, email: "another@email.com", phone: "081244343435")
          donation = create(:donation, user_id: user2.id)
          get :edit, params: {id: donation}
          expect(response).to have_http_status(401)
        end
      end
    end

    context "with not logged in user" do
      it "redirects to login page" do
        user = create(:user)
        donation = create(:donation, user_id: user.id)
        get :edit, params: {id: donation}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #create' do
    context "with logged in user" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
      end
      
      context "with valid pbjects" do
        it "saves new donation in the database" do
          expect{
            post :create, params: {donation: attributes_for(:donation)}
          }.to change(Donation, :count).by(1)
        end

        it "redirects to donation page" do
          post :create, params: {donation: attributes_for(:donation)}
          expect(response).to redirect_to(donation_path(assigns[:donation]))
        end
      end

      context "with invalid objects" do
        it "doesn't save new donation in the database" do
          expect{
            post :create, params: {donation: attributes_for(:donation, title: nil)}
          }.not_to change(Donation, :count)
        end

        it "re-renders #new after create with invalid object" do
          post :create, params: {donation: attributes_for(:donation, title: nil)}
          expect(response).to render_template :new
        end
      end
    end

    context "with not logged in user" do
      it "redirects user to login page" do
        post :create, params: {donation: attributes_for(:donation)}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'PATCH #update' do
    context "with logged in user" do
      before :each do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      context "with correct user" do
        before :each do
          @donation = create(:donation, user_id: session[:user_id])
        end

        context "with valid object" do
          it "changes @donation" do
            patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Bantu Jagad Beli PS5")}
            @donation.reload
            expect(@donation.title).to eq("Bantu Jagad Beli PS5")
          end

          it "redirects to @donation #show" do
            patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Bantu Jagad Beli PS5")}
            expect(response).to redirect_to @donation
          end
        end
  
        context "with invalid object" do
          it "doesn't save updated donation in the database" do
            patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Title Donasi", need: nil)}
            expect(@donation.title).not_to eq("Title Donasi")
          end

          it "re-renders #edit" do
            patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Title Donasi", need: nil)}
            expect(assigns(:donation)).to eq @donation
            expect(response).to render_template :edit
          end
        end
      end

      context "with incorrect user" do
        before :each do
          @user2 = create(:user, email: "emailbaru2@email.com", phone: "08129333333333")
          @donation = create(:donation, user_id: @user2.id)
        end

        it "returns 401 HTTP status" do
          patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Bantu Jagad Beli PS5")}
          expect(response).to have_http_status(401)
        end
      end
    end

    context "with not logged in user" do
      before :each do
        @user = create(:user)
        @donation = create(:donation, user_id: @user.id)
      end

      it "redirects to login page" do
        patch :update, params: {id: @donation, donation: attributes_for(:donation, title: "Bantu Jagad Beli PS5")}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context "with logged in user" do
      before :each do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      context "with valid user id" do
        before :each do
          @donation = create(:donation, user_id: session[:user_id])
        end

        it "deletes donation from database" do
          expect{
            delete :destroy, params: {id: @donation}
          }.to change(Donation, :count).by(-1)
        end

        it "redirects to #index after delete" do
          delete :destroy, params: {id: @donation}
          expect(response).to redirect_to donations_url
        end
      end

      context "with invalid user id" do
        before :each do
          @user2 = create(:user, email: "emailbaru2@email.com", phone: "08129333333333")
          @donation = create(:donation, user_id: @user2.id)
        end

        it "returns 401 http status" do
          delete :destroy, params: {id: @donation}
          expect(response).to have_http_status(401)
        end
      end
    end

    context "with not logged in user" do
      before :each do
        @user = create(:user)
        @donation = create(:donation, user_id: @user.id)
      end

      it "redirects to login page" do
        delete :destroy, params: {id: @donation}
        expect(response).to redirect_to login_path
      end
    end
  end
end