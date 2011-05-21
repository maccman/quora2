(function($){
  
  var pending = {};
  
  var send = function(request){
    var oldSuccess = request.success;
    request.success = function(){ 
      sendNext(request.serial);
      return oldSuccess.apply(request, arguments);
    };
    request.serial = false;
    
    $.ajax(request);
  };
  
  var sendNext = function(ns){
    var requests = pending[ns];
    if ( !requests ) return;
    var next = requests.shift();
    if ( !next ) return;    
    send(next);
  };
  
  $.ajaxTransport("+*", function(_, request){    
    if (request.serial)
      return {
        send: function(headers, complete){
          var requests = (pending[request.serial] || (pending[request.serial] = []));
          
          if (requests.length)
            requests.push(request);
          else {
            send(request);
          }                    
        },
        abort: $.noop
      };
  });
  
})(jQuery);