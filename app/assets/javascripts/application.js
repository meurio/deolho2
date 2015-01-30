// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require meurio_ui
//= require_tree .

$(function(){
	$(document).foundation();

	if(location.hash == "#thanks-for-signing-this-project"){
		$('.thanks-for-signing-this-project').foundation('reveal', 'open');
	}

	// Google Analytics
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-26278513-25', 'auto');
  ga('send', 'pageview');

  // Facebook and Twitter share
  $(".share-on-facebook-button, .share-on-twitter-button").on('click', function(){
    window.open(
      $(event.target).attr("data-href"),
      'facebox-share-dialog',
      'width=626,height=436'
    );
    return false;
  });
});
