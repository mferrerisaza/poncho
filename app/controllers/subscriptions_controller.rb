class SubscriptionsController < ApplicationController
  def show
    @subscription = Subscription.find(params[:id])
    @payment = JSON.parse(@subscription.payment)
  end
end
