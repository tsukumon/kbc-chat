import consumer from "channels/consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data,time) {
    //print(data)
    // Called when there's incoming data on the websocket for this channel
    //message
    const html = `
                  <p>${data.content.sentence}</p>
                  <div class="message-time">${data.time}</div>
                  `;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message-sentence');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
  }
});
