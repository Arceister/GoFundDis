class DonationDetailsController < ApplicationController
  def show
    @donation_detail = DonationDetail.find(params[:id])
  end
end