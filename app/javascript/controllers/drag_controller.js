import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";
import Sortable from "sortablejs";

// Connects to data-controller="drag"
export default class extends Controller {
  connect() {
    new Sortable(this.element, {
      ghostClass: "drag-ghost",
      onEnd: async (e) => {
        const { id } = e.item.dataset;
        const { newIndex } = e;
        const url = `/api/v1/products/${id}/sort`;
        await patch(url, { body: JSON.stringify({ newIndex }) });
      },
    });
  }
}
