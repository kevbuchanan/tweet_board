$(document).ready(function() {
  var cyclePosts = setInterval(function(){
    $.get('/board/DBCBoard', function(response){
      $('.bulletin').replaceWith(response);
    });
  }, 10000);
});
