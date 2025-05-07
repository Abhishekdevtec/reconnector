import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="select"
export default class extends Controller {
  static targets = ["select"]
  static values = {
    url: String,
    param: String,
    targetId: String
  }

  change(event) {
    let params = new URLSearchParams()
    params.append(this.paramValue, event.target.selectedOptions[0].value)
    params.append("target", this.targetIdValue)

    get(`${this.urlValue}?${params}`, {
      responseKind: "turbo-stream"
    })
  }
}
