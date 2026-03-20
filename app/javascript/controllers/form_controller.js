import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  get formElement() {
    // Return the associated form or what's assumed to be the form itself
    return this.element.form || this.element;
  }

  submit({ params }) {
    if (params.submitter) {
      this.formElement.requestSubmit(document.getElementById(params.submitter));
    } else {
      this.formElement.requestSubmit();
    }
  }
}
