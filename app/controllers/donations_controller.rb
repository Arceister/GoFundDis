class DonationsController < ApplicationController
  def show
    @donation = Donation.find(params[:id])
  end

  def index
    @donations = Donation.all
  end

  def new
  end
end