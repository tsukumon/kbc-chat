import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", () => {
  var modal = document.getElementById('demo-modal');
  var btn = document.getElementById('open-modal');
  var close = modal.getElementsByClassName('close')[0];

  // When the user clicks the button, open the modal.
  btn.onclick = function() {
    modal.style.opacity = '1';
    modal.style.visibility = 'visible';
  };
  // When the user clicks on 'X', close the modal
  close.onclick = function() {
    modal.style.opacity = '0';
    modal.style.visibility = 'hidden';
  };
  // When the user clicks outside the modal -- close it.
  window.onclick = function(event) {
    if (event.target == modal) {
      // Which means he clicked somewhere in the modal (background area), but not target = modal-content
      modal.style.opacity = '0';
      modal.style.visibility = 'hidden';
    }
  };
});
