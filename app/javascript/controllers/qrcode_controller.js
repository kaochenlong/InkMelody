import { Controller } from "@hotwired/stimulus";
import QRCode from "qrcode";

// Connects to data-controller="qrcode"
export default class extends Controller {
  connect() {
    const { text } = this.element.dataset;

    if (text) {
      QRCode.toCanvas(this.element, text, {
        width: 200,
        margin: 0,
      });
    }
  }
}
