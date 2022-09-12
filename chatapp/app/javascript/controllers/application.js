import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("turbo:load", () => {
  Turbo.clearCache();
  var modal = document.getElementById('demo-modal');
  var btn = document.getElementById('open-modal');
  var close = modal.getElementsByClassName('close')[0];
  var popup = document.getElementById('js-modal-detail');
  var blackBg = document.getElementById('js-black-sh');
  var blackBg2 = document.getElementById('js-black-sh2');
  
  // When the user clicks the button, open the modal.
  btn.onclick = function() {
    modal.classList.add('is-show');
    $('body').css('overflow-y', 'hidden'); 
  };
  // When the user clicks on 'X', close the modal
  close.onclick = function() {
    modal.classList.remove('is-show');
    $('body').css('overflow-y','auto'); 
  };
  // When the user clicks outside the modal -- close it.
  window.onclick = function(event) {
    if (event.target == blackBg || event.target == blackBg2) {
      modal.classList.remove('is-show');
      $('body').css('overflow-y','auto'); 
      popup.classList.remove('is-show');
      $('body').css('overflow-y','auto'); 
    }
  };
});
