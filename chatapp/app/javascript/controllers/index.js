import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

function flexTextarea(el) {
  const dummy = el.querySelector('.dummy-textarea')
  const dummy2 = $('.dummy-margin')
  el.querySelector('.message-sentense-class').addEventListener('input', e => {
    dummy.textContent = e.target.value + '\u200b'
    var dummy_height = $('.dummy-textarea').height() - 40
    dummy2.css("height", dummy_height + "px")
    //window.scrollTo(0, document.body.scrollHeight);
  })
}
document.querySelectorAll('.room-content').forEach(flexTextarea)

var modal = document.getElementById('demo-modal-menu');
var btn = document.getElementById('open-modal-2');
var close = modal.getElementsByClassName('close-menu')[0];

// When the user clicks the button, open the modal.
btn.onclick = function() {
  modal.style.display = 'block';
};
// When the user clicks on 'X', close the modal
close.onclick = function() {
  modal.style.display = 'none';
};
// When the user clicks outside the modal -- close it.
window.onclick = function(event) {
  if (event.target == modal) {
    // Which means he clicked somewhere in the modal (background area), but not target = modal-content
    modal.style.display = 'none';
  }
};