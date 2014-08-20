$(document).ready(function() {
	changeCellColorOnHover();
  playGame();
  computerPlaysFirst();
 });

function changeCellColorOnHover(){
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

function playGame(){
  $('td').on('click', function(){
    if ($(this).html() === ""){
      $(".get_started").hide();
      $(this).html("X");
      $(this).css({
        "background-color": "white"
      })
      var board = getBoardFromPage();
      $.ajax({
        url: "/play",
        type: "POST",
        dataType: "JSON",
        data: {board: board},
        success: function(response){
          drawBoardFromArray(response.board)
          if (response.finished){
            declareWinner(response.winner);
          }
        }
      })
    }
  })
}

function getBoardFromPage(){
  var board = []
  $("tr").each(function(rowNum){
    $(this).children().each(function(colNum){
      board.push($(this).html());
    })
  })
  return board;
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

function computerPlaysFirst(){
  $("button").on('click', function(){
    $(".get_started").hide();
    drawBoardFromArray(["", "", "", "", "O", "", "", "", ""])
  })
}

function declareWinner(winner){
  if (winner === "O"){
    var new_div = "<div id='winner'>Computer wins!</div>";
  } else if (winner === "X"){
    var new_div = "<div id='winner'>You win!</div>";
  } else {
    var new_div = "<div id='winner'>Game over -- no winner.</div>";
  }
  $("body").append(new_div);
  var playAgain = "<div class='get_started'><a href='/'><button>Play again</button></a></div>";
  $("body").append(playAgain);
}
