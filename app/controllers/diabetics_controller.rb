class DiabeticsController < ApplicationController

	def index
		@diabetics = Diabetic.where("user_id = :user_id and Date(created_at) = :date", { user_id: current_user.id, date: Date.today })
		#@diabetics = Diabetic.where("created_at >= ?", Date.today)
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
        flash[:error] = "fsdgffdhg"
        format.json { render json: @diabetic.errors, status: :unprocessable_entity }
      end
    end
	end

	def month_to_date
		@month_to_date = Diabetic.filter_range(params[:from], params[:to])
		respond_to do |format|
			format.html { render "month_to_date" }
			format.xlsx { render xlsx: "month_to_date", filename: "month_to_date.xlsx" }
		end
	end
	
	 def monthly_report
	 	@diabetics = Diabetic.all
  	@monthly_report = @diabetics.group_by { |t| t.created_at.beginning_of_month }
  	respond_to do |format|
			format.html { render "monthly_report" }
			format.xlsx { render xlsx: "monthly_report", filename: "monthly_report.xlsx" }
		end
	 end

	private

	def user_params
    params.require(:diabetic).permit(:blood_level,:user_id)
  end

  # def month_report
  # 	params.require(:diabetic).permit(:from, :to)
  # end

end
