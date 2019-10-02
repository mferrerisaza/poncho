import "bootstrap";
import Turbolinks from 'turbolinks';
import "controllers"
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';

initMapbox();

Turbolinks.start()
