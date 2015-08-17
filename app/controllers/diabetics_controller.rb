class DiabeticsController < ApplicationController

	def index
		@diabetics = Diabetic.where(user_id: current_user.id)
	end

	def new
		@diabetic = Diabetic.new
	end

	def create
		#debugger
		@diabetic = Diabetic.new(user_params)
    	respond_to do |format|
      if @diabetic.save
        format.html { redirect_to diabetics_path, notice: 'successfully created.' }
      #  format.json { render :show, status: :created, location: @diabetic }
      else
        format.html { render :new }
        format.json { render json: @diabetic.errors, status: :unprocessable_entity }
      end
    end
	end

	def month_to_date
		@month_to_date = Diabetic.where("created_at between (?) and (?)", params[:from], params[:to])
		#debugger
	end
	
	 def monthly_report
		#@month_to_date = Diabetic.where(:created_at => :from &&  :updated_at => :to)
	 end

	private

	def user_params
    params.require(:diabetic).permit(:blood_level,:user_id)
  end

  def month_report
 # 	params.require(:diabetic).permit(:created_at => :from, :updated_at => :to)
  end

end
