import { Controller } from "@hotwired/stimulus";

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
      .then(({ status }) => {
        // 變更按鈕字樣
        if (status == "liked") {
          this.btnTarget.textContent = UNLIKE_LABEL;
        } else {
          this.btnTarget.textContent = LIKE_LABEL;
        }
      })
      .catch((err) => {
        console.log(err);
      });
  }
}
