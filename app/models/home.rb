class Home < ApplicationRecord
  self.abstract_class = true

  def self.bike_routes_array(criterio)
    url = 'https://www.medellin.gov.co/mapas/rest/services/ServiciosPlaneacion/POT48_Sistema_colectivo/MapServer/14/query?where=1%3D1&outFields=*&outSR=4326&f=json'
    data_serialize = open(url).read
    data = JSON.parse(data_serialize)

    rutas_existentes = data["features"].select { |ruta| ruta["attributes"]["ESTADO"] == criterio}
    array = rutas_existentes.map { |ruta| coordenadas_ruta_individual(ruta["geometry"]["paths"][0]) }
  end

  def self.coordenadas_ruta_individual(ruta)
    ruta = ruta.map do |marker|
      self.coordenadas_marcador(marker)
    end
  end

  def self.coordenadas_marcador(marker)
    g = Geo::Coord.from_h('LAT' => marker[1], 'LON' => marker[0])
    marker = { "lat" => g.lat, "lng" => g.lon }
  end
end
