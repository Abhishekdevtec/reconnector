import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  connect() {
    window.addEventListener("suburb:selected", this.loadPostalCodes.bind(this));
  }

  loadPostalCodes(event) {
    const suburbName = event.detail.name;

    fetch(`/suburbs/postal_codes?name=${encodeURIComponent(suburbName)}`)
      .then(response => {
        return response.json();
      })
      .then(codes => {

        this.selectTarget.innerHTML = "";

        const blank = document.createElement("option");
        blank.value = "";
        blank.textContent = "Select a postal code";
        this.selectTarget.appendChild(blank);

        codes.forEach(code => {
          const opt = document.createElement("option");
          opt.value = code;
          opt.textContent = code;
          this.selectTarget.appendChild(opt);
        });
      })
      .catch(err => {
        console.error("[PostalCodeController] Failed to load postal codes:", err);
      });
  }
}
