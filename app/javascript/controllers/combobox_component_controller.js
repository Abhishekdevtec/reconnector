import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="combobox-component"
export default class extends Controller {
  static targets = ["options", "button", "input"];

  connect() {
    this.hideOptions = this.hideOptions.bind(this);

    document.addEventListener("click", this.hideOptions);
  }

  disconnect() {
    document.removeEventListener("click", this.hideOptions);
  }

  toggleOptions(event) {
    event.stopPropagation();
    event.preventDefault();
    this.optionsTarget.classList.toggle("hidden");
  }

  hideOptions(event) {
    // Add a condition to check if the event target is not a child of the button or input field
    if (
      event.target !== this.buttonTarget &&
      !this.buttonTarget.contains(event.target) &&
      event.target !== this.inputTarget &&
      !this.inputTarget.contains(event.target)
    ) {
      this.optionsTarget.classList.add("hidden");
    }
  }

  showCollection(event) {
    event.stopPropagation();
    event.preventDefault();
    this.resetFilter();
    this.optionsTarget.classList.remove("hidden");
  }

  selectOption(event) { // Add this new action
    const selectedOptionValue = event.currentTarget.dataset.value;
    this.inputTarget.value = selectedOptionValue;
    this.optionsTarget.classList.add("hidden");
  }

  highlightOption(event) {
    const normalClass = event.currentTarget.dataset.normalClass;
    const highlightClass = event.currentTarget.dataset.highlightClass;

    event.currentTarget.classList.remove(normalClass);
    event.currentTarget.classList.add(...highlightClass.split(" "));
  }

  unhighlightOption(event) { // Add this new action
    const normalClass = event.currentTarget.dataset.normalClass;
    const highlightClass = event.currentTarget.dataset.highlightClass;

    event.currentTarget.classList.remove(...highlightClass.split(" "));
    event.currentTarget.classList.add(normalClass);
  }

  handleArrowKeys(event) {
    if (event.key === "ArrowDown") {
      event.preventDefault();
      this.selectNextOption();
    } else if (event.key === "ArrowUp") {
      event.preventDefault();
      this.selectPreviousOption();
    }
  }

  selectNextOption() {
    const options = this.optionsTarget.querySelectorAll("li");
    let nextOptionIndex = 0;

    options.forEach((option, index) => {
      if (option.classList.contains("bg-indigo-600")) {
        nextOptionIndex = (index + 1) % options.length;
      }
    });

    this.updateOptionHighlight(nextOptionIndex);
  }

  selectPreviousOption() {
    const options = this.optionsTarget.querySelectorAll("li");
    let previousOptionIndex = options.length - 1;

    options.forEach((option, index) => {
      if (option.classList.contains("bg-indigo-600")) {
        previousOptionIndex = index === 0 ? options.length - 1 : index - 1;
      }
    });

    this.updateOptionHighlight(previousOptionIndex);
  }

  updateOptionHighlight(newIndex) {
    const options = this.optionsTarget.querySelectorAll("li");

    options.forEach((option) => {
      const normalClass = option.dataset.normalClass;
      const highlightClass = option.dataset.highlightClass;

      option.classList.remove(...highlightClass.split(" "));
      option.classList.add(normalClass);
    });

    const selectedOption = options[newIndex];
    const normalClass = selectedOption.dataset.normalClass;
    const highlightClass = selectedOption.dataset.highlightClass;

    selectedOption.classList.remove(normalClass);
    selectedOption.classList.add(...highlightClass.split(" "));
  }

  filterOptions() {
    const searchText = this.inputTarget.value.toLowerCase();
    const options = this.optionsTarget.querySelectorAll("li");

    options.forEach((option) => {
      const optionText = option.dataset.value.toLowerCase();

      if (optionText.includes(searchText)) {
        option.style.display = "block";
      } else {
        option.style.display = "none";
      }
    });
  }

  resetFilter() {
    const options = this.optionsTarget.querySelectorAll("li");
    options.forEach((option) => {
      option.style.display = "block";
    });
  }
}
