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
    const test = document.getElementById(`${data.id}`)
    const container = document.getElementById(`test-${data.id}`);
    console.log(container)
    container.remove();
  },

  delete: function() {
    return this.perform('delete');
  }
});
