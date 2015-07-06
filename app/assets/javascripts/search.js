$(function() {

	// Live Search behavior
	$("#search_form input").typeWatch({
	    callback: function (value) { 
	    	console.log(this);
	    	$(this).parents("form").submit();
	    	setSearching(value != "");
		  },
	    wait: 500,
	    highlight: true,
	    captureLength: 0
	});

	// Search reset button behavior
	$("body").on("click", "#search_reset button", function(e){
		var form = $(this).parents("form");
		var input = $(form).children("input");
		input.val("");
  	form.submit();
  	setSearching(false);
		e.preventDefault();

		return false;
	});


	function setSearching(isSearching) {
		if(isSearching) {
    	$("#search_ready").addClass("hidden");
    	$("#search_reset").removeClass("hidden");
	  } else {
	  	$("#search_ready").removeClass("hidden");
	  	$("#search_reset").addClass("hidden");
	  }
	}

	// Added to make pagiantor behave.
	$("body").on("click", "a.disabled", function(e) { alert("click"); e.preventDefault(); });
	
});