import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="restaurant-server"
export default class extends Controller {
  static targets = ["ordered"]

  connect() {
    setInterval(() => { this.updateSinceOrdered() }, 60000);
  }

  updateSinceOrdered() {
    this.orderedTarget.innerHTML = parseInt(this.orderedTarget.innerHTML, 10) + 1
  }
}
