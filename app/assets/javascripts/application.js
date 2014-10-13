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
//= require bootstrap
//= require bxslider
//= require_tree .


$(document).ready(function(){
	var loading_gigs;
	if ($('#with-button').size() > 0) {
	  $('.pagination').hide();
	  loading_gigs = false;
	  $('#load_more_gigs').show().click(function() {
	    var $this, more_gigs_url;
	    if (!loading_gigs) {
	      loading_gigs = true;
	      more_gigs_url = $('.pagination .next_page a').attr('href');
	      $this = $(this);
	      // $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled');
	      $.getScript(more_gigs_url, function() {
	        if ($this) {
	          $this.text('More gigs').removeClass('disabled');
	        }
	        return loading_gigs = false;
	      });
	    }
	  });
	}
})

