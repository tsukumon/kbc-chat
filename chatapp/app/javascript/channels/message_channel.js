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
                  <div id="message-${data.content.id}" class="message-one">
                    <div class="message-left"><img src="/test_icon.png"></div>
                      <div class="message-right">
                        <div class="message-user-info">
                          <div class="message-username">山口 一郎</div>
                          <div id="message-time">${data.time}</div>
                          <div id="message-delete">
                            <a data-turbo-method="delete" href="/message/${data.content.id}">削除</a>
                          </div>
                        </div>
                      <p>${data.content.sentence}</p>
                    </div>
                  </div>
                  `;

      const messages = document.getElementById('messages');
      const newMessage = document.getElementById('message-sentence');
      messages.insertAdjacentHTML('beforeend', html);
      newMessage.value = '';
      var element = document.documentElement;
      var bottom = element.scrollHeight - element.clientHeight;
      window.scroll(0, bottom);
    }
    else if (data.mode == "delete") {
      const message = document.getElementById("message-" + data.content.id);
      message.remove();
    }
  }
});