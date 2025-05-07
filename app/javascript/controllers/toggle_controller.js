import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "focus"]
  static values  = { classes: String }

  toggle() {
    this.classes.split(' ').forEach(klass => {
      this.contentTargets.forEach((t) => t.classList.toggle(klass));
    });
  }

  focus() {
    this.focusTargets[0].focus();
  }

  get classes() {
    return this.classesValue
  }
}
