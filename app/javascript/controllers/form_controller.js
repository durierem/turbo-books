import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  get form() {
    return this.element
  }

  submit() {
    if (this.isLocked) return

    this.isLocked = true
    setTimeout(() => {
      this.form.requestSubmit()
      this.isLocked = false
    }, 250)
  }
}
