import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const data = document.getElementById("data")
  
  if(data == null){
    return
  }

  const channel = "MessageChannel"
  const room_id = data.getAttribute("data-room-id")
  const user_id = data.getAttribute("data-user-id")

  const isSubscribed = (channel, room_id, user_id) => {
    const identifier = `{"channel":"${channel}","room_id":"${room_id}","user_id":"${user_id}"}`
    const subscription = consumer.subscriptions.findAll(identifier)
    return !!subscription.length
  };


  if(!isSubscribed(channel, room_id, user_id)) {
    consumer.subscriptions.create({channel: channel, room_id: room_id, user_id: user_id}, {
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
          if(data.content.user_id == user_id){ 
            messages.insertAdjacentHTML('beforeend', html);
            newMessage.value = '';
            dummyMargin.css("height", "0px");
            newMessageDummy.textContent = '';  
          }else{
            messages.insertAdjacentHTML('beforeend', html2);
          }
          //位置判定
          //console.log(getMessageChild());
          let flag = getMessageChild();
          
          if (data.content.user_id == user_id) {
            window.scroll(0, document.body.scrollHeight);
          }else if(flag) {
            window.scroll(0, document.body.scrollHeight);
          }else{
            document.getElementById('message-notice').textContent = "未読のメッセージがあります";
          }
          // $("#message-submit").disabled = true;
          // $('.message-submit').css('opacity', '0.2');
        }
        else if (data.mode == "delete") {
          const message = document.getElementById("message-" + data.content.id);
          message.remove();
        }
        else if(data.mode == "join" && data.user.id != user_id){
          const messages = document.getElementById('messages');
          const notice = document.createElement('div');
          notice.classList.add("join-notice");
          notice.textContent = `${data.user.name}が参加しました`;
          messages.appendChild(notice);
        }
      }
    });
  };
});
