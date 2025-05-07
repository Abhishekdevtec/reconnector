import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table-checkbox-toggle"
export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
  }

  toggle(event) {
    this.checkboxTargets.forEach((t) => t.checked = event.target.checked);
  }
}
