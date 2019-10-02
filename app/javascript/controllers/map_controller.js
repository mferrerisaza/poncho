import { Controller } from "stimulus"
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

export default class extends Controller {

  connect() {
    this.initMapbox();
  }

  initMapbox() {
    const mapElement = this.element;
    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    const map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-75.56347005, 6.272682731],
      zoom: 13
    });

    map.on('load',() => {
      this.fetchData("Existente", map, "#8bcfa3", 6, "capa");
      this.fetchData("Proyectado", map, "#999999", 4, "capaP");
    });
  }

  fetchData(criterio, map, color, line, id) {
    fetch(`https://www.medellin.gov.co/mapas/rest/services/ServiciosPlaneacion/POT48_Sistema_colectivo/MapServer/14/query?where=1%3D1&outFields=*&outSR=4326&f=json`)
      .then(response => response.json())
      .then((data) => {
        let newData = data.features.filter(coordinate => coordinate.attributes.ESTADO === criterio);
        let coordinates = newData.map(coordinate => coordinate.geometry.paths[0]);
        let i = 0;
        coordinates.forEach((route) => {
          const array = (route);
          map.addLayer({
            "id": `${id}${i}`,
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
              "line-color": color,
              "line-width": line
            }
          });
          i++
        });
      });
  }
}
