import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

document.addEventListener("turbo:load", () => {
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
});

document.addEventListener("turbo:load", () => {
  Turbo.clearCache();
  const detail_button = document.getElementById("room-title-bar")
  console.log(detail_button)
  detail_button.addEventListener("click", function(){

    function popupImage() {
      var popup = document.getElementById('js-modal-detail');
      if(!popup) return;

      var blackBg = document.getElementById('js-black-sh');
      var closeBtn = document.getElementById('js-close-btn');
      var showBtn = document.getElementById('js-show-modal-detail');

      closePopUp(blackBg);
      closePopUp(closeBtn);
      closePopUp(showBtn);
      function closePopUp(elem) {
        if(!elem) return;
        elem.addEventListener('click', function() {
          popup.classList.toggle('is-show');
        });
      }
    }
    popupImage();
  })
});
