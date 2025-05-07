import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property--requirement-search-suburb"
export default class extends Controller {
  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 400)
  }
}