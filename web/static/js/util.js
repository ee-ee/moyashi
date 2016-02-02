'use strict';
var Util = {
  entityMap: {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
  },
  escapeHtml: function(string) {
    return String(string).replace(/[&<>"'\/]/g, function (s) {
      return Util.entityMap[s];
    });
  }
};

export default Util;
