import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  get form() {
    return this.element
  }

  submit({ params }) {
    if (params.submitter) {
      this.form.requestSubmit(document.getElementById(params.submitter))
    } else {
      this.form.requestSubmit()
    }
  }
}
