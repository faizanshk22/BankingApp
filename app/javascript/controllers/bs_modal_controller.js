import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()
    this.element.addEventListener('hidden.bs.modal', (event) => {
      location.reload();
    })
  }

  disconnet() {
    this.modal.hide()
  }

  submitEnd(event) {
     this.modal.hide()
  }

}
