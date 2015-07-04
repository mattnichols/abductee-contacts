$(function() {

	// Behavior for search reset button
	$("#search_reset").click(function(){
		var input = $("#search_reset").parent().siblings("input");
		input.val("");
		input.parents("form").submit();

		return false;
	});

});