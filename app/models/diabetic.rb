class Diabetic < ActiveRecord::Base

	belongs_to :user
	validate :user_quota, :on => :create  

	private 
  def user_quota
   if user.diabetics.today.count >= 2
     errors.add(:base, "Exceeds daily limit")
   elsif user.diabetics.this_week.count >= 2
     errors.add(:base, "Exceeds weekly limit")
   end
  end

end
