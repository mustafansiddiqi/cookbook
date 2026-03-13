import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "list"]

  add(event) {
    event.preventDefault()
    const templateTarget = this.templateTargets.find(
      t => t.dataset.listId === event.currentTarget.dataset.listId
    )
    const listTarget = this.listTargets.find(
      t => t.dataset.listId === event.currentTarget.dataset.listId
    )
    const content = templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    )
    listTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    const row = event.currentTarget.closest("[data-nested-row]")
    const destroyField = row.querySelector("input[name*='_destroy']")
    if (destroyField) {
      destroyField.value = "1"
      row.style.display = "none"
    } else {
      row.remove()
    }
  }
}
