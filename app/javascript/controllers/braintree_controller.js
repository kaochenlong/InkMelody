import { Controller } from "@hotwired/stimulus";
import dropin from "braintree-web-drop-in";

// Connects to data-controller="braintree"
export default class extends Controller {
  async connect() {
    const form = this.element.closest("form");

    // disable submit button
    const submitButton = form.querySelector("input[type=submit]");
    if (submitButton) {
      submitButton.disabled = true;
    }

    const { token } = this.element.dataset;

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
          const nonce_field = document.createElement("input");
          nonce_field.setAttribute("type", "hidden");
          nonce_field.setAttribute("name", "nonce");
          nonce_field.setAttribute("value", nonce);
          form.appendChild(nonce_field);

          form.submit();
        }
      });
    }
  }
}
