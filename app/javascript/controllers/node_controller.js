import { Controller } from "@hotwired/stimulus";

/**
 * This controller makes rudimentary Node manipulation accessible directly from within HTML.
 *
 * @example
 *  <article data-controller="node">
 *    <h1>Hello World!</h1>
 *    <button type="button" data-action="node#remove">Delete</button>
 *  </article>
 *
 * @example
 *  <div data-controller="node">
 *    <section id="articles">
 *      <article>
 *        <h1>Hey there!</h1>
 *      </article>
 *    </section>
 *
 *    <button type="button" data-action="node#insertBeforeEnd" data-node-root-param="#articles">New article</button>
 *    <template data-node-target="template">
 *      <article><h1>Generic title</h1></article>
 *    </template>
 *  </div>
 *
 * @todo Implement some form of rudimentary templating like such:
 *  <button type="button" data-action="node#insertBeforeEnd" data-node-locals-param="{ 'title': 'Hello'}">Hello article</button>
 *  <button type="button" data-action="node#insertBeforeEnd" data-node-locals-param="{ 'title': 'Goodbye'}">Goodbye article</button>
 *  <template data-node-target="template">
 *    <article><h1 local="title"></h1></article>
 *  </template>
 *
 * @todo Add more Node actions
 */
export default class extends Controller {
  static targets = ["template"];

  insertAfterBegin({ params }) {
    const root = params.root
      ? this.element.querySelector(params.root)
      : this.element;
    root.insertBefore(this.#clonedTemplate(), this.element.firstChild);
  }

  insertBeforeEnd({ params }) {
    const root = params.root
      ? this.element.querySelector(params.root)
      : this.element;
    root.appendChild(this.#clonedTemplate());
  }

  remove({ params }) {
    const root = params.root
      ? this.element.querySelector(params.root)
      : this.element;
    root.remove();
  }

  #clonedTemplate() {
    return this.templateTarget.content.cloneNode(true);
  }
}
