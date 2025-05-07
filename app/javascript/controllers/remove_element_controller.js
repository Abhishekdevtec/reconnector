import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-element"
export default class extends Controller {
  static values = {
    element: String
  }

  removeElement(event) {
    // Find the parent element
    const elem = event.currentTarget.closest(this.elementValue);

    // Remove the elem element
    elem.remove();
  }
}
