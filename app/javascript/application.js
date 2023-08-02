// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"
import "jquery"

document.addEventListener('turbo:load', function () {
    const shouldShowModal = true; 
  
    function showWelcomeModal() {
      if (shouldShowModal && document.getElementById('staticBackdrop')) {
        const welcomeModal = new bootstrap.Modal(document.getElementById('staticBackdrop'));
        welcomeModal.show();
      }
    }
      showWelcomeModal();
  });
  