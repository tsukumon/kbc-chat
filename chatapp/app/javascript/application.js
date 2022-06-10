// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery-ui/widgets/autocomplete
//= require jquery.turbolinks
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.jscroll').jscroll({
          contentSelector: '.scroll-list',
          nextSelector: 'span.next:last a'
        });
  }
});