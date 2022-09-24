$(document).ready(function(){
  $('input#submit').on('click', function() {
    var api_key = $('input[name=api_key]').val();
    var url = $('input[name=url]').val();

    $.ajax({
      url: '/shorten?api_key=' + api_key + '&url=' + url,
      success: function(data) {
        $('#result').append(data);
      },
      error: function(data) {
        alert("Sorry! The URL you're trying to add is invalid!");
      }
    });
  });
});
