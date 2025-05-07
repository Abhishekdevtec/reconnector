import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = {
    timeout: Number
  }

  connect() {
    this.open()
    setTimeout(() => this.close(), this.timeoutValue)
  }

  open() {
    this.contentTargets.forEach(function (item) {
      item.classList.add("transform", "ease-out", "duration-300", "transition")
    })
    setTimeout(() => this.enter(), 150)
  }

  enter() {
    this.contentTargets.forEach(function (item) {
      item.classList.remove("translate-y-2", "opacity-0", "sm:translate-y-0", "sm:translate-x-2")
      item.classList.add("translate-y-0", "opacity-100", "sm:translate-x-0")
    })
  }

  close() {
    this.contentTargets.forEach(function (item) {
      item.classList.remove("transform","ease-out", "duration-300", "transition")
      item.classList.add("transition", "ease-in", "duration-150")
    })
    setTimeout(() => this.leave(), 150)
    setTimeout(() => this.deleteNode(), this.timeoutValue)
  }

  leave() {
    this.contentTargets.forEach(function (item) {
      item.classList.remove("opacity-100")
      item.classList.add("opacity-0")
    })
  }

  deleteNode() {
    this?.element?.parentNode?.removeChild(this?.element)
  }
}
