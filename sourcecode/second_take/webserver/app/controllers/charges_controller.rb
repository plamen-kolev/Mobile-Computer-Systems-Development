class ChargesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    # Amount in cents
    @amount = 0

    puts "hithere"
    orders = params[:order]
    orders.each do | order |
      @amount += ((order[:price].to_f * order[:quantity].to_i) * 100).to_i
    end

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
