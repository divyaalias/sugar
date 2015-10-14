class Registration < ActiveRecord::Base

	has_one :card
  accepts_nested_attributes_for :card

  def payment_method
    if card.nil? then "paypal"; else "card"; end
  end

end
