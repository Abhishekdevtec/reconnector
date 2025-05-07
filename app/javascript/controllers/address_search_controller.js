import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["searchPalette", "focus", "results", "streetNumber", "streetName", "suburb", "postcode", "state", "country"];
  static values  = {
    classes: String,
    url: String,
    param: String
  };

  toggle() {
    // Display or hide the search palette
    this.classesValue.split(' ').forEach(klass => {
      this.searchPaletteTargets.forEach((t) => t.classList.toggle(klass));
    });

    // Grab the keyboard focus
    this.focusTargets[0].focus();
  }

  search() {}

  // Manage standard input
  input(event) {
    let searchQuery = event.target.value
    if (searchQuery.length >= 10 && searchQuery[searchQuery.length-1] == ' ') {
      let params = new URLSearchParams()
      params.append(this.paramValue, searchQuery)
      params.append("target", this.resultsTarget.id)
      get(`${this.urlValue}?${params}`, {
        responseKind: "turbo-stream"
      })
    }
    else if (searchQuery.length < 10) {
      this._clearResults()
    }
  }

  // Manage escape and enter keys
  manage_keypress(event) {
    if (event.key == "Escape") {
      this.close();
    }

    if (event.key == "Enter") {
      this.search();
      this.close();
      event.stopImmediatePropagation();
      event.stopPropagation();
      event.preventDefault();
      return false;
    }
  }

  close() {
    this.toggle();
  }

  set_fields(event) {
    this.streetNumberTarget.value = event.target.dataset.addressSearchStreetNumberValue;
    this.streetNameTarget.value   = event.target.dataset.addressSearchStreetNameValue;
    this.suburbTarget.value       = event.target.dataset.addressSearchSuburbValue;
    this.postcodeTarget.value     = event.target.dataset.addressSearchPostcodeValue;
    this.stateTarget.value        = event.target.dataset.addressSearchStateValue;
    this.countryTarget.value      = event.target.dataset.addressSearchCountryValue;
    this.close();
  }

  _clearResults() {

  }
}