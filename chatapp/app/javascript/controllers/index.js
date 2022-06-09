// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
function flexTextarea(el) {
    const dummy = el.querySelector('.dummy-textarea')
    const margin = document.getElementById('dummy-margin')
    const height = document.getElementById('message-sentence').clientHeight
    el.querySelector('.message-sentense-class').addEventListener('input', e => {
      dummy.textContent = e.target.value + '\u200b'
      height = document.getElementById('message-sentence').clientHeight
      margin.style.marginBottom = height
      console.log(height)
      console.log(margin.style.marginBottom)
    })
  }
document.querySelectorAll('.message-textarea').forEach(flexTextarea)