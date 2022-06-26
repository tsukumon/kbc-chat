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