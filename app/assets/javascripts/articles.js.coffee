# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	editor = new  wysihtml5.Editor "article_body", {
		toolbar: "toolbar"
		parserRules:  wysihtml5ParserRules
	}
	$('#toolbar a').addClass 'btn'
	$('#toolbar a').css({margin:'5px -5px',border:"none"})