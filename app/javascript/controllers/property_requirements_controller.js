import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property-requirements"
export default class extends Controller {
  static targets = [ "selected" ]

  addSuburb(event) {
    event.preventDefault();
    const suburbId = event.target.dataset.suburbId;
    const suburbName = event.target.dataset.suburbName;

    // Create the checkbox element
    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.name = "property_requirement[suburbs][]";
    checkbox.value = suburbId;
    checkbox.checked = true;
    checkbox.classList.add("hidden");

    // Create the label element
    const label = document.createElement("label");
    label.htmlFor = `suburb_${suburbId}`;
    label.textContent = suburbName;

    // Create the label element
    label.htmlFor = suburbId;
    label.classList.add("inline-flex", "items-center", "gap-x-0.5", "rounded-md", "bg-indigo-50", "px-2", "py-1", "text-xs", "font-medium", "text-indigo-700", "ring-1", "ring-inset", "ring-indigo-700/10");

    // Create the remove button
    const removeButton = document.createElement("button");
    removeButton.type = "button";
    removeButton.dataset.controller = "remove-element";
    removeButton.setAttribute("data-remove-element-element-value", "div");
    removeButton.dataset.action = "click->remove-element#removeElement";
    removeButton.classList.add("group", "relative", "-mr-1", "h-3.5", "w-3.5", "rounded-sm", "hover:bg-indigo-600/20");

    // Create the span element for the remove button
    const removeButtonSpan = document.createElement("span");
    removeButtonSpan.classList.add("sr-only");
    removeButtonSpan.textContent = "Remove";
    removeButton.appendChild(removeButtonSpan);

    // Create the SVG element for the remove button
    const removeButtonSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    removeButtonSvg.setAttribute("viewBox", "0 0 14 14");
    removeButtonSvg.classList.add("h-3.5", "w-3.5", "stroke-indigo-600/50", "group-hover:stroke-indigo-600/75");

    // Create the path element for the remove button SVG
    const removeButtonPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
    removeButtonPath.setAttribute("d", "M4 4l6 6m0-6l-6 6");
    removeButtonSvg.appendChild(removeButtonPath);

    // Create the span element for the remove button (used for absolute positioning)
    const removeButtonSpanAbsolute = document.createElement("span");
    removeButtonSpanAbsolute.classList.add("absolute", "-inset-1");
    removeButton.appendChild(removeButtonSvg);
    removeButton.appendChild(removeButtonSpanAbsolute);

    // Add the remove button to the label
    label.appendChild(removeButton);

    // Create a container div for the checkbox and label
    const container = document.createElement("div");
    container.classList.add("flex", "items-center", "py-1");
    container.appendChild(checkbox);
    container.appendChild(label);

    // Add the container to the added suburbs form
    this.selectedTarget.appendChild(container);

    // Remove the option from the search results
    const listItem = event.target.closest("li");
    listItem.remove();
  }
}