class PagesController < ApplicationController
  def home
    @existentes = Home.bike_routes_array("Existente")
    @proyectados = Home.bike_routes_array("Proyectado")
  end
end
