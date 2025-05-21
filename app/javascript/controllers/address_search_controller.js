import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"
// import { get } from "@rails/request.js"

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
    const searchQuery = event.target.value;
    if (searchQuery.length < 3) {
      return this._clearResults();
    }

    const params = new URLSearchParams();
    params.append(this.paramValue, searchQuery);
    params.append("target", this.resultsTarget.id);
    const requestUrl = `${this.urlValue}?${params}`;

    fetch(requestUrl, {
      headers: { "Accept": "text/vnd.turbo-stream.html" },
      credentials: "same-origin"
    })
      .then(response => {
        if (!response.ok) throw new Error(response.statusText);
        return response.text();
      })
      .then(html => {
        // This will run the Turbo Stream tags and update your DOM
        Turbo.renderStreamMessage(html);
      })
      .catch(error => {
        console.error("Address search fetch failed:", error);
      });
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
    this.resultsTarget.innerHTML = "";
  }
}