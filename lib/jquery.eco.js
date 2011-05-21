(function($){

$.eco = function(name, values) {
  var template = require(name);
  if ( !$.isArray(values) ) values = [values];
  return $($.map(values, function(item){ 
    var element = $(template(item));
    if (item) element.data("item", item)
    return element.get();
  }));
};

$.fn.item = function(){
  var item = $(this).data("item") || 
             $(this).attr("data-item");
  if ( item ) return item;
  var parent = $(this).parent();
  if ( parent.length )
    return parent.item();
};

$.fn.forItem = function(item){
  return this.filter(function(){
    var compare = $(this).item();
    if (item.eql && item.eql(compare) || item === compare)
      return true;
  });
};

})(jQuery);