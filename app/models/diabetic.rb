class Diabetic < ActiveRecord::Base

  belongs_to :user
	validate :user_quota, :on => :create

  scope :filter_range,->(from, to) { where("created_at >= :from AND created_at <= :to", from: DateTime.parse(from).beginning_of_day, to: DateTime.parse(to).end_of_day) if from && to }
 #  scope :filter_range,->(from, to) { where("created_at >= :from AND created.at <= :to", from: Time.zone.parse(from).beginning_of_day, to: Time.zone.parse(to).end_of_day) if from && to }  

 # scope :filter_range,->(from, to) { where("orders.created >= :from AND orders.created <= :to", from: Time.zone.parse(from).beginning_of_day, to: Time.zone.parse(to).end_of_day) if from && to }
  
	private 
  def user_quota
    if user.diabetics.today.count >= 4
      errors.add(:base, "Exceeds daily limit. Daily limit is 4")
    end
  end

end
