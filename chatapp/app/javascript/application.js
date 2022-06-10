// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery-ui/widgets/autocomplete
//= require jquery.turbolinks
//= require jquery.jscroll.min.js
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

$(function() {
  $('.jscroll').jscroll({
    nextSelector: 'span.next a'
  });
});