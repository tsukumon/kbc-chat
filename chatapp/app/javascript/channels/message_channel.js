import consumer from "channels/consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
      const allHeight = Math.max(
        document.body.scrollHeight, document.documentElement.scrollHeight,
        document.body.offsetHeight, document.documentElement.offsetHeight,
        document.body.clientHeight, document.documentElement.clientHeight
      );
      const mostBottom = allHeight - window.innerHeight;
      const scrollTop = window.pageYOffset + 0.5;

    if (data.mode == "create") {
      const html = `
                  <div id="message-${data.content.id}" class="message-one">
                    <div class="message-left"><img src="${data.user.image}"></div>
                      <div class="message-right">
                        <div class="message-user-info">
                          <div class="message-username">${data.user.name}</div>
                          <div id="message-time">${data.time}</div>
                          <div id="message-delete">
                            <a data-turbo-method="delete" href="/message/${data.content.id}">削除</a>
                          </div>
                        </div>
                      <p>${data.content.sentence}</p>
                    </div>
                  </div>
                  `;

      const html2 = `
                  <div id="message-${data.content.id}" class="message-one">
                    <div class="message-left"><img src="${data.user.image}"></div>
                      <div class="message-right">
                        <div class="message-user-info">
                          <div class="message-username">${data.user.name}</div>
                          <div id="message-time">${data.time}</div>
                        </div>
                      <p>${data.content.sentence}</p>
                    </div>
                  </div>
                  `;

      const messages = document.getElementById('messages');
      const newMessage = document.getElementById('message-sentence');
      const dummyMargin = $('.dummy-margin');
      const newMessageDummy  = document.getElementById('dummy-textarea');
      if(data.user.id == data.current_user){ 
        messages.insertAdjacentHTML('beforeend', html);
      }else{
        messages.insertAdjacentHTML('beforeend', html2);
      }
      newMessage.value = '';
      dummyMargin.css("height", "0px");
      newMessageDummy.textContent = '';
      console.log("scrolltop" + scrollTop);
      console.log("most" + mostBottom);
      console.log("scroll" + document.body.scrollHeight);
      if (scrollTop >= mostBottom) {
        window.scroll(0, document.body.scrollHeight);
      }else{
        document.getElementById('message-notice').textContent = "未読のメッセージがあります";
      }
      $("#message-submit").disabled = true;
      $('.message-submit').css('opacity', '0.2');
    }
    else if (data.mode == "delete") {
      const message = document.getElementById("message-" + data.content.id);
      message.remove();
    }
  }
});