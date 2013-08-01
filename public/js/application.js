
$(document).ready(function() {
  var getBulletins = window.setInterval(function(){
    $.get('/board/DBCBoard', function(response){
      $('.bulletin').hide(2500, function(){
        $('.bulletin').replaceWith($(response));
        $('.bulletin').hide();
        $('.bulletin').show(2500);
      });
    });
  }, 10000);
});

