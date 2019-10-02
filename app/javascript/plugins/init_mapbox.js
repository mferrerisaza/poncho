import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const convertRoutesToArray = (route) => {
    const routeArray = []
    route.forEach((pair) => {
      const lat = parseFloat(Object.values(pair)[1], 10);
      const long = parseFloat(Object.values(pair)[0], 10);
      routeArray.push([lat, long])
    })
    return routeArray;
  }

  if (mapElement) { // only build a map if there's a div#map to inject into
    const existentes = JSON.parse(mapElement.dataset.existentes);
    const proyectados = JSON.parse(mapElement.dataset.proyectados);

    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-75.56347005, 6.272682731],
      zoom: 11
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
            'visibility': 'visible',
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
            'visibility': 'visible',
            "line-join": "round",
            "line-cap": "round"
          },
          "paint": {
            "line-color": "#8bcfa3",
            "line-width": 4
          }
        });
        i++
      });
    });
  }
};

export { initMapbox };

