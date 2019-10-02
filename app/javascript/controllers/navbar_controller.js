import { Controller } from "stimulus"


export default class extends Controller {
  scroll(){
    if(this.element.classList.contains("navbar-lewagon")) {
      if (window.scrollY >= 100) {
        this.element.classList.add('navbar-lewagon-white');
      } else {
        this.element.classList.remove('navbar-lewagon-white');
      }
    }
  }
}
