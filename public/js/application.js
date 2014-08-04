$(document).ready(function() {
	changeColorOnHover();
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});



function changeColorOnHover(){
  $("td").on({
    mouseenter: function () {
      if ($(this).html() === ""){
        $(this).css({
          "background-color": "#009"
        })
      }
    },
    mouseleave: function () {
      $(this).css({
        "background-color": "white"
      })
    }
  });
}

