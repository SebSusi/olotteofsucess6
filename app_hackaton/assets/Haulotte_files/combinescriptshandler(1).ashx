mascus.ready(function() {
	var setScreenSizeCookie = function() {
		var w = window.innerWidth;
		var size = "lg";
		if (w < mascus.layout.breakpoints.small)
			size = "sm";
		else if (w < mascus.layout.breakpoints.medium)
			size = "md";
		mascus.setSettingsCookieValue("screensize", size);
	};

	setScreenSizeCookie();
	
	$(window).resize(function() {
		setScreenSizeCookie();
	});
});

function disableCachePopup() {
	var d = new Date();
	d.setTime(d.getTime() + (365 * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = "disableCachePopup=true; " + expires;
	$("#popupCache").hide();
}

function closeMobileBannerDownloadApp() {
    var d = new Date();
    d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));// expires in one day
    var expires = "expires=" + d.toUTCString();
    document.cookie = "mobileBannerDownloadApp=true; " + expires;
    $('#mobileDownloadAppBannerWrapper').hide();
}

var isMobile = {
    Android: function () {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function () {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function () {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function () {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function () {
        return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
    },
    any: function () {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};

function redirectMobileBannerDownloadApp(countryCode) {
    var d = new Date();
    d.setTime(d.getTime() + (365 * 24 * 60 * 60 * 1000));// expires in one year
    var expires = "expires=" + d.toUTCString();
    document.cookie = "mobileBannerDownloadApp=true; " + expires;
    if (isMobile.Android()) {
        window.location.href = 'https://play.google.com/store/apps/details?id=com.mascus.app';
    } else if (isMobile.iOS()) {
        if (!countryCode)
            countryCode = 'us';
        window.location.href = 'https://itunes.apple.com/' + countryCode + '/app/mascus/id1387805230?mt=8';
    }
}
