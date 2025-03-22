import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit({ target: input }) {
    input.form.requestSubmit()
  }
}
