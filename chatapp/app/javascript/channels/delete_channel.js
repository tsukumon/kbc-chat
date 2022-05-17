import { removeData } from "jquery";
import consumer from "channels/consumer"

consumer.subscriptions.create("DeleteChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

  }
})
(function() {
  ({
    "delete": function(id) {
      return this.perform('delete', {
        id: id
      });
    }
  });

  $(document).on('click', '.delete-btn', function(event) {
    return App["delete"]["delete"](event.target.id);
  });

}).call(this);

(function() {
  ({
    received: function(data) {
      var id;
      id = "#" + data['id'];
      console.log(id);
      return $(id).remove();
    }
  });
}).call(this);

