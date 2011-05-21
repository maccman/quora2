jQuery.fn.dataAttr = function(key, value){
  return($(this).attr("data-" + key, value));
};