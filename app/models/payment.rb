class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year

  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map {|name, i| ["#{i + 1} - #{name}"] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create email: email, card: token
    # debugger
    Stripe::Charge.create amount: 1000, source: "tok_mastercard", # customer: customer.id,
                          description: "Premium", currency: "usd"
  end
end
# 4012888888881881
