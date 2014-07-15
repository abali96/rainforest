$(document).on('ready page:load', function() {

  $('#new_review').submit(function(ev) {
    ev.preventDefault();

    $.ajax({
      url: $(this).attr("action"),
      type: 'POST',
      dataType: 'json',
      data: $(this).serialize()
    }).done(function(data) {
      var paragraph = "<div class='review'><p>" + data.comment + "<br>";
      paragraph += "<em>by " + data.user.name + "</em>";
      paragraph += "Added on: " + data.created_at + "</p></div>";

      $('#review-list').append(paragraph)
    });
  });

  if ($('.pagination').length) { // if pagination.length returns true
    $(window).scroll(function() {
      var url = $('.pagination span.next').children().attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Fetching more products...");
        return $.getScript(url);
      }
    });
  }
});
