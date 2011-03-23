// JavaScript Document
$(function() {
	
	$("td").hover(function() {
		
		$(this).parent().addClass("hover");
		
	}, function() {
		
		$(this).parent().removeClass("hover");
		
		});
});