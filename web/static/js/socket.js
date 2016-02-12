'use strict';
import App from "./app";
import {Socket} from "phoenix";
import Util from "./util";

let socket = new Socket("/socket", {params: {token: window.userToken}});

if(window.threadChannel) {
    socket.connect();
}
let channel = socket.channel(window.threadChannel, {});
let threadContainer = document.querySelectorAll('div.thread')[0];

let format_date = function(datestr) {
    let datetime = new Date(datestr);
    let month = ('0' + (datetime.getMonth()+1)).slice(-2);
    let year = datetime.getFullYear();
    year = String(year).substr(2,2);
    return datetime.getHours() + ':' + datetime.getMinutes() + ' ' + datetime.getDate() + '/' + month + '/' + year;
};

channel.on("new_post", payload => {
  let newPost = document.createDocumentFragment();

  let postDiv = document.createElement('div');
  postDiv.classList.add('post');
  postDiv.classList.add('reply');
  let date = format_date(payload.inserted_at);
  let html = '<div class="files">';
  if(payload.attach) {
    html += '<div class="file">\
              <a class="image" href="/'+payload.attach+'" target="_blank">\
                <img class="thumb" src="/'+payload.thumb+'" width="255">\
              </a>\
            </div>';
  }
  html += '</div>\
    <p class="info">\
      <span class="name">' +
        Util.escapeHtml(payload.name) +
      '</span>\
      <time datetime="' +
        Util.escapeHtml(date) +
      '">'+date+'</time>\
      #'+ Util.escapeHtml(payload.id)+'</p>\
    <div class="body">' +
      Util.escapeHtml(payload.body) +
    '</div>';
  postDiv.innerHTML = html;
  newPost.appendChild(postDiv);

  let lineBreak = document.createElement('br');
  newPost.appendChild(lineBreak);
  assignEvents(newPost);
  threadContainer.appendChild(newPost);
});

let assignEvents = function(el) {
  let thumbs = el.querySelectorAll('a.image');
  for (let i = 0; i < thumbs.length; ++i) {
    thumbs[i].addEventListener('click', App.expandImage);
  }
}

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); })
  .receive("error", resp => { console.log("Unable to join", resp); });

export default socket;
