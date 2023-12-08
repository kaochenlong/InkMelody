import { Controller } from "@hotwired/stimulus";
import dropin from "braintree-web-drop-in";

// Connects to data-controller="braintree"
export default class extends Controller {
  connect() {
    const { token } = this.element.dataset;

    dropin
      .create({
        container: this.element,
        authorization: token,
      })
      .then((instance) => {
        console.log(instance);
      })
      .catch((err) => {
        console.log(err);
      });
  }
}
