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
      redirect_to root_path
      flash[:notice] = "Gracias por registrarte, pronto nos comunicaremos contigo"
    else
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :email, :plan)
  end
end
