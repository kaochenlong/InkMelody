import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

const LIKE_LABEL = "收藏";
const UNLIKE_LABEL = "取消";

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["btn"];

  connect() {
    const { liked } = this.element.dataset;
    if (liked == "true") {
      this.btnTarget.textContent = UNLIKE_LABEL;
    } else {
      this.btnTarget.textContent = LIKE_LABEL;
    }
  }

  async toggle(e) {
    e.preventDefault();

    const { id } = this.element.dataset;
    const url = `/api/v1/products/${id}/like.json`;
    const response = await patch(url);

    if (response.ok) {
      const { status } = await response.json;

      if (status == "liked") {
        this.btnTarget.textContent = UNLIKE_LABEL;
      } else {
        this.btnTarget.textContent = LIKE_LABEL;
      }
    } else {
      const { url } = await response.json;
      window.location.href = url;
    }
  }
}
