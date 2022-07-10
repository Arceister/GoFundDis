class DonationDetailsController < ApplicationController
  def show
    @donation_detail = DonationDetail.find(params[:id])
  end

  def index
    if Current.user
      @donation_details = Current.user.donation_details
    else
      redirect_to login_path
    end
  end

  def new
    @donation_id = params[:id]
  end
end