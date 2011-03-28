// JavaScript Document
$(function() {
	
	$("td").hover(function() {
		
		$(this).parent().addClass("hover");
		
	}, function() {
		
		$(this).parent().removeClass("hover");
		
		});
});

function hidediv(id) {
  //safe function to hide an element with a specified id
  if (document.getElementById) { // DOM3 = IE5, NS6
    document.getElementById(id).style.display = 'none';
  }
  else {
    if (document.layers) { // Netscape 4
      document.id.display = 'none';
    }
    else { // IE 4
      document.all.id.style.display = 'none';
    }
  }
}

function showdiv(id) {
  //safe function to show an element with a specified id

  if (document.getElementById) { // DOM3 = IE5, NS6
    document.getElementById(id).style.display = 'block';
  }
  else {
    if (document.layers) { // Netscape 4
      document.id.display = 'block';
    }
    else { // IE 4
      document.all.id.style.display = 'block';
    }
  }
}

function show_sorted_by_date() {
  showdiv("sorted_by_date");
  hidediv("sorted_by_location");
}

function show_sorted_by_location() {
  showdiv("sorted_by_location");
  hidediv("sorted_by_date");
}

