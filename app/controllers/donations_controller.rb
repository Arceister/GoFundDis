class DonationsController < ApplicationController
  def show
    @donation = Donation.find(params[:id])
  end

  def index
    @donations = Donation.all
  end

  def new
    if !Current.user
      redirect_to login_path
    end
  end

  def edit
    @donation = Donation.find(params[:id])
    if Current.user
      if Current.user.id == @donation.user_id
      end
    end
  end
end