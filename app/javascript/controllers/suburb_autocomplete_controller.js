// app/javascript/controllers/suburb_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "suggestions", "hiddenName"]

  search() {
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.clearSuggestions()
      return
    }

    fetch(`/suburbs/autocomplete?query=${encodeURIComponent(query)}`)
      .then((response) => response.json())
      .then((data) => {
        if (data.length > 0) {
          this.showSuggestions(data)
        } else {
          this.clearSuggestions()
        }
      })
      .catch((error) => {
        console.error("Autocomplete error:", error)
        this.clearSuggestions()
      })
  }

  showSuggestions(data) {
    this.suggestionsTarget.innerHTML = ""

    data.forEach((suburb) => {
      const div = document.createElement("div")
      div.classList.add("cursor-pointer", "p-2", "hover:bg-gray-200", "text-sm")
      div.textContent = suburb.name
      div.dataset.id = suburb.id
      
      div.addEventListener("click", () => {
        this.inputTarget.value = suburb.name
        this.hiddenNameTarget.value = suburb.name
        this.clearSuggestions()
        const eventi = new CustomEvent("suburb:selected", { detail: { name: suburb.name }, bubbles: true });
        this.element.dispatchEvent(eventi);
        window.dispatchEvent(eventi);  

      })
      this.suggestionsTarget.appendChild(div)
    })

    this.suggestionsTarget.classList.remove("hidden")
  }

  clearSuggestions() {
    this.suggestionsTarget.innerHTML = ""
    this.suggestionsTarget.classList.add("hidden")
  }
}
