import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.toggle()
  }

  toggle() {
    if (this.element.checked) {
      document.body.classList.add("turbo-outline")
    } else {
      document.body.classList.remove("turbo-outline")
    }
  }
}
