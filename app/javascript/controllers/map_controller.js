import { Controller } from "stimulus"
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

export default class extends Controller {

  connect() {
    this.initMapbox();
  }

  initMapbox() {
    const mapElement = this.element;
    const convertRoutesToArray = (route) => {
      const routeArray = []
      route.forEach((pair) => {
        const long = parseFloat(Object.values(pair)[0], 10);
        const lat = parseFloat(Object.values(pair)[1], 10);
        routeArray.push([lat, long])
      })
      return routeArray;
    }

    if (mapElement) {
      const existentes = this.fetchData("En Estudio");
      const proyectados = JSON.parse(mapElement.dataset.proyectados);

      mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [-75.56347005, 6.272682731],
        zoom: 13
      });
      map.on('load', function () {
        let i = 0;
        proyectados.forEach((route) => {
          const array = convertRoutesToArray(route);
          map.addLayer({
            "id": `capaP${i}`,
            "type": "line",
            "source": {
              "type": "geojson",
              "data": {
                "type": "Feature",
                "properties": {},
                "geometry": {
                  "type": "LineString",
                  "coordinates": array
                }
              }
            },
            "layout": {
              "line-join": "round",
              "line-cap": "round"
            },
            "paint": {
              "line-color": "#999999",
              "line-width": 4
            }
          });
          i++
        });
        existentes.forEach((route) => {
          const array = convertRoutesToArray(route);
          map.addLayer({
            "id": `capa${i}`,
            "type": "line",
            "source": {
              "type": "geojson",
              "data": {
                "type": "Feature",
                "properties": {},
                "geometry": {
                  "type": "LineString",
                  "coordinates": array
                }
              }
            },
            "layout": {
              "line-join": "round",
              "line-cap": "round"
            },
            "paint": {
              "line-color": "#8bcfa3",
              "line-width": 6
            }
          });
          i++
        });
      });
    }
  }

  fetchData(criterio) {
    fetch(`https://www.medellin.gov.co/mapas/rest/services/ServiciosPlaneacion/POT48_Sistema_colectivo/MapServer/14/query?where=1%3D1&outFields=*&outSR=4326&f=json`)
      .then(response => response.json())
      .then((data) => {
        let newData = data.features.filter(coordinate => coordinate.attributes.ESTADO === criterio);
        let coordinates = newData.map(coordinate => coordinate.geometry.paths[0]);
        console.log(coordinates);
      });
  }
}
