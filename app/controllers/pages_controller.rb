class PagesController < ApplicationController
  def home
    @is_full_path = false
    # @existentes = Home.bike_routes_array("Existente")
    # @proyectados = Home.bike_routes_array("Proyectado")
  end

  def plans
    @is_full_path = true
    @subscription = Subscription.new
  end

  def create_subscription
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      # service = Bancolombia.new(
      #   client_id: ENV['BANCOLOMBIA_CLIENT_ID'],
      #   client_secret: ENV['BANCOLOMBIA_CLIENT_SECRET']
      # )
      # amount = subscription_params[:plan] == "bike" ? 150_000 : 120_000
      # @subscription.update(payment: service.call(amount))
      # redirect_to subscription_path @subscription
      redirect_to root_path
      flash[:notice] = "Gracias por registrarte, pronto nos comunicaremos contigo"
    else
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(
      :name,
      :email,
      :plan,
      :id_type,
      :tax_id,
      :account_type,
      :account_number,
      :country,
      :city,
      :address,
    )
  end
end
