import consumer from "channels/consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.mode == "create") {
      const html = `
                  <div id="message-${data.content.id}">
                    <p>${data.content.sentence}</p>
                    <div class="message-time">${data.time}</div>
                    <div id="message-delete">
                      <a data-turbo-method="delete" href="/message/${data.content.id}">削除する</a>
                    </div>
                  </div>
                  `;

      const messages = document.getElementById('messages');
      const newMessage = document.getElementById('message-sentence');
      messages.insertAdjacentHTML('beforeend', html);
      newMessage.value = '';
    }
    else if (data.mode == "delete") {
      const message = document.getElementById("message-" + data.content.id);
      message.remove();
    }
  }
});