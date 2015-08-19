numTiles = 16;

$(document).ready(function() {
	container = $('#container').width();
	drawBoard(numTiles);
});

function drawBoard(dims) {
	board = container - 4 * dims;
	tileWidth = board/dims;
	for (i = 0; i < dims; i++) {
		$('#container').append("<div class='row'></div>");
	}
	for (j = 0; j < dims; j++) {
		$('.row').append("<div class='box'></div>");
	}
	$('.box').width(tileWidth);
	$('.box').height(tileWidth);
	$(".box").hover(
		function() {
			opacity = $(this).css("opacity");
			opacity = parseFloat(opacity) + .1;
			console.log("the opacity is:" + " " + opacity);
			$(this).css("opacity", toString(opacity));
		}, function() {
			opacity = $(this).css("opacity");
			opacity = parseFloat(opacity) + .1;
			console.log("the opacity is:" + " " + opacity);
			$(this).css("opacity", toString(opacity));
	});
}

function changeBoard() {
	oldBoard = document.getElementById('container');
	while (oldBoard.lastChild) {
		oldBoard.removeChild(oldBoard.lastChild);
	}
	userInput = prompt("How many tiles across would you like this board?");
	drawBoard(userInput);
}