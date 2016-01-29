'use strict';
import socket from "./socket"

var ready = function(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
};

var App = {
    inlineExpansion: function() {
        var elements = document.querySelectorAll('a.image');
        Array.prototype.forEach.call(elements, function(el, i) {
            el.addEventListener('click', App.expandImage);
        });
    },
    expandImage: function(e) {
        // check for middle click
        if(e.which == 2) {
            return;
        }
        e.preventDefault();
        var thumb = this.querySelectorAll('img.thumb')[0];
        thumb.classList.add('hidden');
        var fullimage = document.createElement('img');
        fullimage.src = this.href;
        fullimage.classList.add('full-image');
        this.appendChild(fullimage);
        this.removeEventListener('click', App.expandImage);
        this.addEventListener('click', App.contractImage);
    },
    contractImage: function(e) {
        // check for middle click
        if(e.which == 2) {
            return;
        }
        e.preventDefault();
        var thumb = this.querySelectorAll('img.thumb')[0];
        thumb.classList.remove('hidden');
        var fullimage = this.querySelectorAll('img.full-image')[0];
        this.removeChild(fullimage);
        this.removeEventListener('click', App.contractImage);
        this.addEventListener('click', App.expandImage);
    }
};

ready(App.inlineExpansion);
