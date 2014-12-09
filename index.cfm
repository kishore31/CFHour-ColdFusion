<html>
	<head>
		<link type="text/css" rel="stylesheet" media="all" href="assets/css/main.css" />
	    <link type="text/css" rel="stylesheet" media="all" href="assets/css/jquery.mmenu.css" />
	    <link type="text/css" rel="stylesheet" media="all" href="assets/css/topcoat-mobile-light.min.css" />
	    <script type="text/javascript" src="assets/js/jquery-2.1.0.min.js"></script>
	    <script type="text/javascript" src="assets/js/jquery.mmenu.js"></script>
	    <script type="text/javascript" src="assets/js/mustache.js"></script>
		<script type="text/javascript" src="assets/js/app.js"></script>
</head>
<body>
<div id="page">
    <div id="header">
        <a href="#mobile_menu"></a>
        CFHour Podcast (V2)
    </div>
    <p id="details"></p>
		<div id="connType"></div>
		<div id="connMessage"></div>
    <div id="content">
    </div>
    <nav id="mobile_menu">
        <ul>
            <li class="Selected"><a href="index.html">Introduction</a></li>
            <li>
                <a href="horizontal-submenus.html">Horizontal submenus example</a>
                <ul>
                    <li><a href="#">First sub-item</a></li>
                    <li>
                        <a href="#">Second sub-item</a>
                        <ul>
                            <li><a href="#">First sub-sub-item</a></li>
                            <li><a href="#">Second sub-sub-item</a></li>
                            <li><a href="#">Third sub-sub-item</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Third sub-item</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
	
</body>
</html>
<script>
$('nav#mobile_menu').mmenu();
</script>

<cfclientsettings enabledeviceapi="true" devicetimeout="30" />
<cfclientsettings detectdevice="true" />
<cfclient>
<cfscript>
	
//objDatasource = new com.monkeh.datasource();
	
app.init();

function showConnectionType() {
	return cfclient.connection.getType();
}

cfclient.connection.onOffline(function() {
	app.connectionOff();
});

cfclient.connection.onOnline(function() {
	app.connectionOn();
});

function playShowMedia(mediaObject) {
	cfclient.audio.play(mediaObject.mediaURL);
	return mediaObject;
}

function pausePlayingMedia(mediaObject) {
	cfclient.audio.pause(mediaObject);
} 
</cfscript>
</cfclient>