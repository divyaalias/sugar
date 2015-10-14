class RegistrationsController < ApplicationController


	def new
		@registration = Registration.new
    @registration.build_card
    @course = Course.find_by id: params["course_id"]
	end

	def create
    @registration = Registration.new(registration_params)
    @registration.card.ip_address = request.remote_ip
    if @registration.save
      case params['payment_method']
        when "paypal"
          redirect_to @registration.paypal_url(registration_path(@registration))
        when "card"
          if @registration.card.purchase
            redirect_to registration_path(@registration), notice: @registration.card.card_transaction.message
          else
            redirect_to registration_path(@registration), alert: @registration.card.card_transaction.message
          end
      end
    else
      render :new
    end
  end

  def show
  end

	private

  def registration_params
    params.require(:registration).permit(:course_id, :full_name, :company, :email, :telephone,
                                          card_attributes: [
                                              :first_name, :last_name, :card_type, :card_number,
                                              :card_verification, :card_expires_on])
  end


end
