import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["btn"];

  toggle(e) {
    e.preventDefault();

    const { id } = this.element.dataset;

    const token = document.querySelector("meta[name='csrf-token']").content;

    // 打 API
    const url = `/api/v1/products/${id}/like`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    })
      .then((result) => {
        return result.json();
      })
      .then(({ id, status }) => {
        console.log(id, status);

        // 變更按鈕字樣
        if (status == "liked") {
          this.btnTarget.textContent = "取消";
        } else {
          this.btnTarget.textContent = "喜歡";
        }
      })
      .catch((err) => {
        console.log(err);
      });
  }
}
