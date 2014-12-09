/*jslint browser: true*/
/*jslint plusplus: true */
/*global $, jQuery, Mustache, alert, console*/
var app = {
			
	/*feedURL: 'http://www.cfhour.com/cfhourRSS/podcastfeed.json?callback=cfhourProcess',*/
	feedURL: 'podcastfeed.json',
	isOnline: false,
	storedShows: false,
	showJSON: '',
	template: '',
			
	init: function () {
		"use strict";
		app.getTemplate();
	},
	
	docReady: function () {
		"use strict";
		invokeCFClientFunction('showConnectionType', function(connType) {
			app.isOnline = app.manageConnection(connType);
			if (app.isOnline) {
				app.getFeed();
			} else {
				// fallback management here
			}
		});
	},
	
	getTemplate: function () {
		"use strict";
		$.get("assets/templates/mustache.html", function (template) {
			app.template = $(template);
			app.docReady();
		});
	},
	
	manageConnection: function (connectionType) {
		"use strict";
		switch (connectionType) {
			case 'none':
				$("#connMessage").html('You are not connected');
				return false;
			break;
			default:
				$("#connMessage").html('You are connected using ' + connectionType);
				return true;
		}
	},
	
	connectionOff: function () {
		"use strict";
		invokeCFClientFunction('showConnectionType', function(connType) {
			app.isOnline = app.manageConnection(connType);
		});	
	},
	
	connectionOn: function () {
		"use strict";
		invokeCFClientFunction('showConnectionType', function(connType) {
			app.isOnline = app.manageConnection(connType);
		});	
	},
	
	getFeed: function () {
		"use strict";
		var jqxhr = $.getJSON( app.feedURL, {format: 'jsonp'}, function (data) {

		})
		.done(function(data) {
			app.showJSON = data;
			// Store shows
			//saveShows(data.episodes);
			app.renderEpisodes(data);
		})
		.fail(function() {
    		alert( "error" );
  		})
  		.always(function (data) {

  		});
	},
	
	renderEpisodes: function (feedData) {
        "use strict";
        var intLoop,
            dashIndex,
            $listItems;
        for (intLoop = 0; intLoop < feedData.episodes.length; intLoop++) {
			if (feedData.episodes[intLoop].title.substring(0, 4) === 'Show') {
                dashIndex = feedData.episodes[intLoop].title.match(' - ');
			}
        }
        $("#content").html(Mustache.render(app.template.filter('#episodeListRenderTpl').html(), feedData));
        $listItems = $(".showListItem");
        $("li.showListItem").on("click", function (e) {
        	app.playMedia($(this).attr('data-showurl'));
        });
    },
    
    playMedia: function (mediaURL) {
    	invokeCFClientFunction("playShowMedia", {mediaURL: mediaURL}, function(mediaObject) {
    		alert('playing ' + mediaObject);
    		$("#details").html('<button id="stopplaying">stop</button>');
    		$("#stopplaying").on("click", function (e) {
    			alert('stop playing');
    			app.pauseMedia(mediaObject);
    		});
    	});
    },
    
    pauseMedia: function (mediaObject) {
    	invokeCFClientFunction("pausePlayingMedia", {mediaObject: mediaObject}, function(mediaObject) {
    		alert('media paused');
    	});
    }
	
};