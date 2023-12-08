import { Controller } from "@hotwired/stimulus";
import dropin from "braintree-web-drop-in";
import { createHiddenField } from "../lib/element";

// Connects to data-controller="braintree"
export default class extends Controller {
  async connect() {
    const { token } = this.element.dataset;

    if (token) {
      const form = this.element.closest("form");

      // disable submit button
      const submitButton = form.querySelector("input[type=submit]");
      if (submitButton) {
        submitButton.disabled = true;
      }

      const instance = await dropin.create({
        container: this.element,
        authorization: token,
      });

      if (instance && submitButton) {
        submitButton.disabled = false;
      }

      if (form) {
        form.addEventListener("submit", async (e) => {
          e.preventDefault();

          const { nonce } = await instance.requestPaymentMethod();
          if (nonce) {
            const nonce_field = createHiddenField("nonce", nonce);
            form.appendChild(nonce_field);

            form.submit();
          }
        });
      }
    }
  }
}
