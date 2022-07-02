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
      if Current.user.id != @donation.user_id
        render :file => "#{Rails.root}/public/401.html",  layout: false, status: 401
      end
    else
      redirect_to login_path, notice: "You must be logged in to see this page!"
    end
  end

  def create
    if Current.user
      @params = donation_params
      @params[:user_id] = Current.user.id
      @donation = Donation.new(@params)
      respond_to do |format|
        if @donation.save
          format.html { redirect_to donation_url(@donation), notice: "Donation was successfully created." }
          format.json { render :show, status: :created, location: @donation }
        else
          format.html { render :new, status: :unprocessable_entity, notice: "Register error!" }
          format.json { render json: @donation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to login_path, notice: "You must be logged in to see this page!"
    end
  end

  def update
    @donation = Donation.find(params[:id])
    if Current.user
      if @donation.user_id === Current.user.id
        respond_to do |format|
          if @donation.update(donation_params)
            format.html { redirect_to donation_url(@donation), notice: "Donation was successfully updated." }
            format.json { render :show, status: :ok, location: @donation }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @donation.errors, status: :unprocessable_entity }
          end
        end
      else
        render :file => "#{Rails.root}/public/401.html",  layout: false, status: 401
      end
    else
      redirect_to login_path, notice: "You must be logged in to see this page!"
    end
  end

  def destroy
    @donation = Donation.find(params[:id])
    if Current.user
      if @donation.user_id === Current.user.id
        @donation.destroy

        respond_to do |format|
          format.html { redirect_to donations_url, notice: "Donation successfully deleted!" }
          format.json { head :no_content }
        end
      else
        render :file => "#{Rails.root}/public/401.html",  layout: false, status: 401
      end
    else
      redirect_to login_path, notice: "You must be logged in to see this page!"
    end
  end

  private
    def donation_params
      params.require(:donation).permit(:title, :current, :need, :deadline)
    end
end