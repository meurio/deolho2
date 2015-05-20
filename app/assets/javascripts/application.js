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
//= require datetimepicker
//= require jquery.cookie
//= require_tree .

$(function(){
	$(document).foundation({
    abide: {
      patterns: {
        email: /^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$/
      }
		},
		accordion: {
			multi_expand: true
		},
		equalizer: {
    	equalize_on_stack: true
  	},
		joyride: {
			cookie_monster: true
		}
  });

	$(document).foundation('joyride', 'start');

	// Closes joyride whenever a reveal is opened
	$(document).on('open.fndtn.reveal', '[data-reveal]', function () {
  	$(".joyride-close-tip").trigger("click")
	});

	$('[data-datetimepicker]').datetimepicker({
    lang: 'pt',
    format: 'd/m/Y H:i'
  });

	if(location.hash == "#thanks-for-signing-this-project"){
		$('.thanks-for-signing-this-project').foundation('reveal', 'open');
	}

	if(location.hash == "#change-owner-form"){
		$('#change-owner-form').foundation('reveal', 'open');
	}

	function countdown(time, counter, redirectTo){
		time--;
		counter.html(time);
		if(time <= 0)
			window.location.replace(redirectTo);
		setTimeout(function(){ countdown(time, counter, redirectTo) }, 1000);
	}

	if(location.hash == "#thanks-for-contributing-to-this-project"){
		$('.thanks-for-contributing-to-this-project').foundation('reveal', 'open');
		countdown(
			15,
			$("#contribution-redirect-countdown"),
			$(".thanks-for-contributing-to-this-project").data("redirect-url")
		);
	}

	// Google Analytics
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', $("body").data("ga-code"), 'auto');
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

	// Event tracker
	$('#new-project-button-menu').click(function(){
		ga('send', 'event', 'Buttons', 'Create new project (menu)');
	});

	$('#new-project-button').click(function(){
		ga('send', 'event', 'Buttons', 'Create new project (project page)');
	});
});
