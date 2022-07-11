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
    if !Current.user
      redirect_to login_path
    end
  end

  def create
    if Current.user
      @params = donation_detail_params
      @params[:user_id] = Current.user.id
      @params[:donation_id] = params[:id]
      @donation_detail = DonationDetail.new(@params)
      respond_to do |format|
        if @donation_detail.save
          format.html { redirect_to donationdetails_path, notice: "Donate succesful! Thanks for your donation." }
          format.json { render :show, status: :created, location: donationdetails_path }
        else
          format.html { render :new, status: :unprocessable_entity, notice: "Register error!" }
          format.json { render json: @donation_detail.errors, status: :unprocessable_entity }
        end
      end
    end 
  end

  private
    def donation_detail_params
      params.require(:donation_detail).permit(:metode, :value, :doa, :anonymous)
    end
end