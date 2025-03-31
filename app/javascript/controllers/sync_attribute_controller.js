import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { target: String, attr: String }

  get targetElement() {
    return document.querySelector(this.targetValue)
  }

  connect() {
    setTimeout(() => {
      this.observer = new MutationObserver(() => this.sync())
      this.observer.observe(this.targetElement, { attributeFilter: [this.attrValue] })
    })
  }

  sync() {
    const value = this.targetElement.getAttribute(this.attrValue)
    if (value === null) { // attribute doesn't exist on target element
      this.element.removeAttribute(this.attrValue)
    } else {
      this.element.setAttribute(this.attrValue, value)
    }
  }
}
