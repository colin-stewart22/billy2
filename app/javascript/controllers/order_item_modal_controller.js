import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-item-modal"
export default class extends Controller {
  connect() {

    console.log("Hello World");

    const modalSplit = document.getElementById("modal-split");

    const modalPayAll = document.getElementById("modal-pay-all");

    const buttonToPayAll = document.getElementById("button-to-pay-all");

    const buttonToSplit = document.getElementById("button-to-split");

    function handleToPayAllClick() {
      modalSplit.classList.add("hidden")
      modalPayAll.classList.remove("hidden")
    }

    function handleToSplitClick(){
      modalPayAll.classList.add("hidden")
      modalSplit.classList.remove("hidden")
    }

    buttonToPayAll.addEventListener("click", handleToPayAllClick);
    buttonToSplit.addEventListener("click", handleToSplitClick);
  }
}
