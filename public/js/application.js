$(document).ready(function() {
	changeCell();
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});



function changeCell(){
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
    },
    click: function(){
      if ($(this).html() === ""){
        $(this).html("X");
        $(this).css({
          "background-color": "white"
        })
        var board = getBoardFromPage();
        console.log(board)
        $.ajax({
          url: "/play",
          type: "POST",
          data: board,
          success: drawBoardFromArray
        })
      }
    }
  });
}

function getBoardFromPage(){
  var board = []
  $("tr").each(function(rowNum){
    $(this).children().each(function(colNum){
      board.push($(this).html());
    })
  })
  return board
}

function drawBoardFromArray(array){
  var i = 0;
  $("tr").each(function(rowNum){
    $(this).children().each(function(colNum){
      $(this).html(array[i]);
      i += 1;
    })
  })
}

