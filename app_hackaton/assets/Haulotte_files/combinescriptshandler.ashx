$(document).ready(function() {
	// Commented out by Teemu
	/*
	$('.sel-sub-cat').siblings('.fly-select').hide();
	$('.sel-sub-cat').click(function(){
			$(this).toggleClass('open');
			$(this).siblings('.fly-select').toggle();
		});
		
	$('.fly-select a.orange-link, .fly-select .primary-button').click(function(){
			$('#sel-sub-cat').removeClass('open');
			$('.fly-select').toggle();
		
		});

	$('#search-type').click(function(){
		
		$(this).children('#search-type-options').toggle();
	});
		
	$('.more-options h3 a').click(function(){
		var txt = $(".more-options ul").is(':visible') ? '+' : '-';
		$('.more-options ul').slideToggle();
		 $(".more-options h3 a span").text(txt);
	});
	
	$('.selected-sub-cat li').click(function() {
		var childCount = $(this).parent('.selected-sub-cat').children('li:visible').length;
	 	if ( childCount == 1){
			$(this).parent('.selected-sub-cat').css('display','none');
			$(this).css('display','none');
			if($(this).hasClass('myLocation')){
				$('a.select-modal.location').toggleClass('active');
			}
		}
		else{
			$(this).css('display','none');
		}
	 }); 

	 $('a.select-modal.location').click(function(){
		
		if(!$(this).hasClass('active')){
			$('#selectedLocation li:first,#selectedLocation-2 li:first').html(geoplugin_countryName() + ", " + geoplugin_region() + ", " + geoplugin_city()+"<span class='clear-selection'></span>").addClass('myLocation');
			$('#selectedLocation li:not(:first),#selectedLocation-2 li:not(:first)').css('display','none');
			if($('#selectedLocation:not(visible),#selectedLocation-2:not(visible)')){
				$('#selectedLocation, #selectedLocation li:first,#selectedLocation-2, #selectedLocation li:first').css('display','block');
			}
		}
		$(this).toggleClass('active');
		});

	$('#my-select').multiSelect({
		selectableHeader: "<input type='text' class='search-input sales-rep-search' autocomplete='off' placeholder='Start typing to search for sales representatives...'>",
		selectionHeader: "<div class='custom-header selected-list-label'>Selected sales representatives</div>",
		afterInit: function(ms){
		var that = this,
			$selectableSearch = that.$selectableUl.prev(),
			selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)';
	
			that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
			.on('keydown', function(e){
			  if (e.which === 40){
				that.$selectableUl.focus();
				return false;
			  }
			});
	
			
		  },
		  afterSelect: function(){
			this.qs1.cache();
		  },
		  afterDeselect: function(){
			this.qs1.cache();
		  }
		});
		
		
		$('.open-preview').click(
		function(e){
			e.preventDefault();
			var href = $(this).attr('href');
			window.open(href,"_blank","toolbar=yes, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, copyhistory=yes, width=880, height=800");
			
		});

		//SHOW HIDE PLACE AD CONTENT
		$('.place-ad-content').css('display','none');
		$('#place-ad-step-1').css('display','block');
		$('.place-ad-wizard .tabs-menu li a').click(function(){
			var currentTab = $(this).attr('href');
			$('.place-ad-content').hide();
			$(currentTab).show();
			return false;
		});

		//START PLACE AD WIZARD SET UP
		function setHeight(){
			var conentH = $('.place-ad-wizard .tabs-wrapper .tab-head.open+.tab-content').height();
			$('.place-ad-wizard .tabs-wrapper').height(conentH);
		}
		//setHeight();
		$('.place-ad-wizard .tabs-wrapper .tab-head').click(function(){
			setHeight();
		});
		//EN PLACE AD WIZARD SET UP
		*/

	$('.tab-head').click(function() {
		$(this).addClass('open');
		$(this).siblings('.tab-head').removeClass('open');
	});

	$('.selected-products li .close-button').click(function() {
		$(this).parent('li').hide(200, function() {
			$(this).parent('li').remove();
		});
	});

	/*$('.accordion-head a,.sub-accordion-head a,.region-header a').click(function() {
		$(this).parent().toggleClass('open');
	});*/

	//$('#Company-user').hide();
	$('.login-form .button-group a').click(function(){
		var currentForm = $(this).attr('href');
		$(this).siblings().toggleClass('selected');
		$(this).toggleClass('selected');
		$('.toggle-form').hide();
		$(currentForm).show();
		return false;
	});

	

    //dirty fix for adPlace form, commented out as useless for 1060
	//setHeight();
	//$('.place-ad-wizard .tabs-wrapper .tab-head').click(function () {
	//    setHeight();
	//});
		
});

//dirty fix for adPlace form
function setHeight() {
    var conentH = $('.place-ad-wizard .tabs-wrapper .tab-head.open+.tab-content').height();
    $('.place-ad-wizard .tabs-wrapper').height(conentH);
}

var g_objSearch = null;
var g_objMap = null;
var g_objGeocoder = null;
var g_objMapContainer = null;
var h_objSearch = null;
var h_objMap = null;
var h_objGeocoder = null;
var h_objMapContainer = null;

var arrAccessories = new Array();

function checkAll(f_strFieldName)
{
    toggleCheckBox(f_strFieldName, true);
}

function uncheckAll(f_strFieldName)
{
    toggleCheckBox(f_strFieldName, false);
}

function toggleCheckBox(f_strFieldName, f_blnChecked)
{
    var objForm = document.forms[0];
    for (i = 0; i < objForm.length; i++)
    {
        if (objForm[i].name.toLowerCase() == f_strFieldName.toLowerCase())
        {
            objForm[i].checked = f_blnChecked;
        }
    }
}

function setFieldValue(f_strName, f_strValue)
{
	if (document.forms[0][f_strName])
	{
		document.forms[0][f_strName].value = f_strValue;
	}
}

function setFieldValues(f_arrNameValue)
{
	if (f_arrNameValue)
	{
		for (i = 0; i < f_arrNameValue.length; i++)
		{
			if (document.forms[0][f_arrNameValue[i].name])
			{
				document.forms[0][f_arrNameValue[i].name].value = f_arrNameValue[i].value;
			}
		}
	}
}

function getCheckedCount(f_strFieldName)
{
    var objForm = document.forms[0];
    var intCount = 0;
    for (i = 0; i < objForm.length; i++)
    {
        if (objForm[i].name.toLowerCase() == f_strFieldName.toLowerCase())
        {
            if (objForm[i].checked)
            {
				intCount++;
            }
        }
    }
    return intCount;
}

function setPostAction(f_strPostAction)
{
    if (!f_strPostAction)
    {
        f_strPostAction = '';
    }
    //console.log(document.forms[0]['postaction'].value);
    if (document.forms[0] != undefined && document.forms[0]['postaction'] != undefined) {
        document.forms[0]['postaction'].value = 0;
        document.forms[0]['postaction'].value = f_strPostAction;
    }
}

function setFormAction(f_strFormAction) {
    if (f_strFormAction && document.forms[0] != undefined)
    {
        document.forms[0]['__VIEWSTATE'].value = '';
        document.forms[0].action = f_strFormAction;
    }
}

function handleEnter(f_objEvent, f_strPostAction, f_strFormAction)
{
    if (f_objEvent.keyCode == 13)
    {
		if (typeof f_strPostAction == 'function')
		{
			f_strPostAction();
		}
		else
		{
			submitForm(f_strPostAction, f_strFormAction);
        }
        return false;
    }
    else
    {
        return true;
    }
}

function trim(str) {
    return str.replace(/^\s+|\s+$/g, '');
}

function updateAccListCheckBox(f_strSelectAccessory, strValue, strAction) {
    if (strAction == 'add') {
        if (typeof (arrAccessories[0]) == 'undefined') {
            arrAccessories.length = 1;
            arrAccessories[0] = new Array(3);
            arrAccessories[0][0] = strValue;
            arrAccessories[0][1] = '';
            arrAccessories[0][2] = '';
        }
        else {
            arrAccessories.length = arrAccessories.length + 1;
            arrAccessories[arrAccessories.length - 1] = new Array(3);
            arrAccessories[arrAccessories.length - 1][0] = strValue;
            arrAccessories[arrAccessories.length - 1][1] = '';
            arrAccessories[arrAccessories.length - 1][2] = '';
        }
        return;
    }

    if (document.getElementById(f_strSelectAccessory).checked) {
        //Add
        if (document.forms[0].hidAccessories.value.indexOf(',' + strValue + '|') != -1 || document.forms[0].hidAccessories.value.indexOf(strValue + '|') == 0)
            return;

        if (typeof (arrAccessories[0]) == 'undefined') {
            arrAccessories.length = 1;
            arrAccessories[0] = new Array(3);
            arrAccessories[0][0] = strValue;
            arrAccessories[0][1] = '';
            arrAccessories[0][2] = '';
        }
        else {
            arrAccessories.length = arrAccessories.length + 1;
            arrAccessories[arrAccessories.length - 1] = new Array(3);
            arrAccessories[arrAccessories.length - 1][0] = strValue;
            arrAccessories[arrAccessories.length - 1][1] = '';
            arrAccessories[arrAccessories.length - 1][2] = '';
        }
    }
    else {
        //Delete
        var accOrderNumber = 0;
        for (i = 0; i < arrAccessories.length; i++) {
            if (strValue == arrAccessories[i][0])
                accOrderNumber = i;
        }

        for (i = accOrderNumber + 1; i < arrAccessories.length; ++i) {
            arrAccessories[i - 1] = arrAccessories[i];
        }
        arrAccessories.length = arrAccessories.length - 1;
    }

    //Update hidden field
    document.forms[0].hidAccessories.value = '';
    for (i = 0; i < arrAccessories.length; ++i) {
        document.forms[0].hidAccessories.value += arrAccessories[i][0] + '|' + arrAccessories[i][1] + ',';
    }
}


function updateAccessoryListEdit(f_strRemove, strValue, strText, strComment) {
    if (typeof (arrAccessories[0]) == 'undefined') {
        arrAccessories.length = 1;
        arrAccessories[0] = new Array(3);
        arrAccessories[0][0] = strValue;
        arrAccessories[0][1] = strComment;
        arrAccessories[0][2] = strText;
    }
    else {
        // alert(f_strUserID);
        arrAccessories.length = arrAccessories.length + 1;
        arrAccessories[arrAccessories.length - 1] = new Array(3);
        arrAccessories[arrAccessories.length - 1][0] = strValue;
        arrAccessories[arrAccessories.length - 1][1] = strComment;
        arrAccessories[arrAccessories.length - 1][2] = strText;
    }
    updateAccessoryHtml(arrAccessories, f_strRemove);

}

function updateAccessoryList(f_strRemove, f_strSelectAccessory) {
    var objDropDown = $("[id$='accessorylist']")[0];
    var objComment = $("[id$='accessorycomment']")[0];
    var strValue = objDropDown.value;
    var strText = objDropDown.options[objDropDown.selectedIndex].text;
    var strComment = objComment.value;

    if (strValue.length < 1) {
        alert(f_strSelectAccessory);
        return;
    }
    if (document.forms[0].hidAccessories.value.indexOf(',' + strValue + '|') != -1 || document.forms[0].hidAccessories.value.indexOf(strValue + '|') == 0)
        return;

    if (typeof (arrAccessories[0]) == 'undefined') {
        arrAccessories.length = 1;
        arrAccessories[0] = new Array(3);
        arrAccessories[0][0] = strValue;
        arrAccessories[0][1] = strComment;
        arrAccessories[0][2] = strText;
    }
    else {
        // alert(f_strUserID);
        arrAccessories.length = arrAccessories.length + 1;
        arrAccessories[arrAccessories.length - 1] = new Array(3);
        arrAccessories[arrAccessories.length - 1][0] = strValue;
        arrAccessories[arrAccessories.length - 1][1] = strComment;
        arrAccessories[arrAccessories.length - 1][2] = strText;
    }

    objComment.value = '';
    objDropDown.selectedIndex = 0;

    updateAccessoryHtml(arrAccessories, f_strRemove);

}

function updateAccessoryHtml(f_arrAccessories, f_strRemove) {

    document.getElementById('alSelected').innerHTML = '';
    document.forms[0].hidAccessories.value = '';

    for (i = 0; i < f_arrAccessories.length; ++i) {
        document.forms[0].hidAccessories.value += f_arrAccessories[i][0] + '|' + f_arrAccessories[i][1] + ',';
        document.getElementById('alSelected').innerHTML += '<div class="alSelectedContent col-sm-9"><strong>' + f_arrAccessories[i][2] + '</strong><br> ' + f_arrAccessories[i][1] + '</div><div class="alAccRemove col-sm-3"><a class="Orange12Bold" href="javascript:removeAccessory(' + i + ', \'' + f_strRemove + '\')">&#187; ' + f_strRemove + '</a></div>';
    }
}

function removeAccessory(f_intNumber, f_strRemove) {

    for (i = f_intNumber + 1; i < arrAccessories.length; ++i) {
        arrAccessories[i - 1] = arrAccessories[i];
    }
    arrAccessories.length = arrAccessories.length - 1;

    updateAccessoryHtml(arrAccessories, f_strRemove);
}

function submitForm(f_strPostAction, f_strFormAction)
{
    //alert(f_strPostAction + ',' + f_strFormAction);
    setPostAction(f_strPostAction);
    setFormAction(f_strFormAction);
    document.forms[0].submit();
}

function submitIfChecked(f_strFieldName, f_intMinItems, f_intMaxItems, f_strErrorMessage, f_strConfirmMessage, f_strPostAction, f_strFormAction)
{
	var intCheckedCount = getCheckedCount(f_strFieldName);
	//alert(intCheckedCount)
	if (f_intMaxItems > 0 && (intCheckedCount < f_intMinItems || intCheckedCount > f_intMaxItems))
	{
		if (f_strErrorMessage)
		{
			alert(f_strErrorMessage.replace('#minimum#', f_intMinItems).replace('#maximum#', f_intMaxItems).replace('#number#', f_intMinItems + ' - ' + f_intMaxItems));
		}
		return false;
	}
	else if (intCheckedCount < f_intMinItems)
	{
		if (f_strErrorMessage)
		{
			alert(f_strErrorMessage.replace('#minimum#', f_intMinItems).replace('#number#', f_intMinItems));
		}
		return false;
	}
	else if (f_intMaxItems > 0 && intCheckedCount > f_intMaxItems)
	{
		if (f_strErrorMessage)
		{
			alert(f_strErrorMessage.replace('#maximum#', f_intMaxItems).replace('#number#', f_intMaxItems));
		}
		return false;
	}
	else
	{
		if (f_strConfirmMessage)
		{
			if (confirm(f_strConfirmMessage.replace('#number#', intCheckedCount)))
			{
				submitForm(f_strPostAction, f_strFormAction);
			}
			else
			{
				return false;
			}
		}
		else
		{
			submitForm(f_strPostAction, f_strFormAction);
		}
	}
}

function disableEnter(f_objEvent)
{
    if (f_objEvent.keyCode == 13)
    {
        return false;
    }
    else
    {
        return true;
    }
}

function showElement(f_strElementId, f_blnAnimate, f_fnOnPreShow) {
    if (f_strElementId) {
        var objElement = document.getElementById(f_strElementId);
        if (objElement && !f_blnAnimate) {
            if (typeof jQuery != 'undefined') {
                if ($.isFunction(f_fnOnPreShow)) {
                    f_fnOnPreShow();
                }
                $(objElement).slideDown('fast');
            }
            else {
                objElement.style.display = 'block';
            }
        }
        else if (objElement && f_blnAnimate) {
            if (typeof jQuery != 'undefined') {
                $(objElement).animate({
                    width: 'toggle'
                }, {
                    specialEasing: {
                        width: 'linear'
                    }
                });

            }
            else {
                objElement.style.display = 'block';
            }
        }

    }
}

function hideElement(f_strElementId, f_blnAnimate, f_fnOnAfterHide) {
    if (f_strElementId) {
        var objElement = document.getElementById(f_strElementId);
        if (objElement && !f_blnAnimate) {
            if (typeof jQuery != 'undefined') {
                if ($.isFunction(f_fnOnAfterHide))
                    $(objElement).slideUp('fast', f_fnOnAfterHide);
                else
                    $(objElement).slideUp('fast');
            }
            else {
                objElement.style.display = 'none';
            }
        }
        else if (objElement && f_blnAnimate) {
            if (typeof jQuery != 'undefined') {

                $(objElement).animate({
                    width: 'toggle'
                }, {
                    specialEasing: {
                        width: 'linear'
                    }
                });
            }
            else {
                objElement.style.display = 'none';
            }
        }
    }
}

function getCities(country, callback) {
	$.getJSON("/js/GetLocations.ashx?action=cities&country=" + country + "&language=" + currentContext.language, null, callback);
}

function getCityNames(country, callback) {
	getCities(country, function(data) {
		var names = [];
		for (var i = 0; i < data.items.length; i++) {
			if (i == 0 || (i > 0 && data.items[i - 1][1] != data.items[i][1])) {
				names[names.length] = data.items[i][1];
			}
		}
		callback(names);
	});
}

function getCountryRegions(country, callback) {
	$.getJSON("/js/GetLocations.ashx?action=countryregions&country=" + country + "&language=" + currentContext.language, null, callback);
}

function getCountryRegionNames(country, callback) {
	getCountryRegions(country, function(data) {
		var names = [];
		for (var i = 0; i < data.items.length; i++) {
			if (i == 0 || (i > 0 && data.items[i - 1][1] != data.items[i][1])) {
				names[names.length] = data.items[i][1];
			}
		}
		callback(names);
	});
}

// Google Maps API v3

function initGoogleMap(containerDivId, mapDivId, latLng)
{
    g_objMapContainer = document.getElementById(containerDivId);
    //alert(latLng);
    if (latLng)
    {
        var options = {
            zoom: 13,
            center: latLng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        g_objMap = new google.maps.Map(document.getElementById(mapDivId), options);
        showMapMarker(latLng, false);
    }
    else
    {
        if (g_objMapContainer)
            g_objMapContainer.style.display = 'none';
    }
}

function findMapPoint(address, country, callback)
{
    if (!g_objGeocoder)
        g_objGeocoder = new google.maps.Geocoder();

    //alert(address + ', ' + country + ' -> ' + address.replace(/\^/g, ', '));
    g_objGeocoder.geocode( { 'address': address.replace(/\^/g, ', '), 'region': country }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            callback(results[0].geometry.location);
        } else {
            //alert("Geocode was not successful for the following reason: " + status);
            var parts = address.split('^');
            if (parts.length > 1) {
                address = '';
                for (var i = 1; i < parts.length; i++) {
                    if (address.length > 0)
                        address += '^';
                    address += parts[i];
                }
                findMapPoint(address, country, callback);
            }
            else
            {
                callback(null);
            }
        }
    });
}

function showMapMarker(latLng, center)
{
    //alert(latLng.lat() + ', ' + latLng.lng());
    if (center)
        g_objMap.setCenter(latLng);
    var marker = new google.maps.Marker({
        map: g_objMap,
        position: latLng
    });
}

//Here Maps Api V3

function initHereMap(containerDivId, mapDivId, latLng) {
    h_objMapContainer = document.getElementById(containerDivId);
    alert(latLng);
    if (latLng) {
        var maptypes = platform.createDefaultLayers();
        var h_objMap = new H.Map(document.getElementById(mapDivId), maptypes.normal.map, { center: latLng, zoom: 30 });
        var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(h_objMap));
        var ui = mapsjs.ui.UI.createDefault(h_objMap, maptypes);
        showHereMapMarker(latLng, false);
    }
    else {
        if (h_objMapContainer)
            h_objMapContainer.style.display = 'none';
    }
}

function findHereMapPoint(address, callback) {
    if (!h_objGeocoder)
        h_objGeocoder = platform.getGeocodingService();

    //alert(address + ', ' + country + ' -> ' + address.replace(/\^/g, ', '));


    h_objGeocoder.geocode({ "address": address.replace(/\^/g, ', ') }, function (data) {
        //handle service response    
        var position = data.Response.View[0].Result[0].Location.DisplayPosition;
        callback(position);
    }, function () {
        //handle communication error
        //alert("Geocode was not successful");
        var parts = address.split('^');
        if (parts.length > 1) {
            address = '';
            for (var i = 1; i < parts.length; i++) {
                if (address.length > 0)
                    address += '^';
                address += parts[i];
            }
            findHereMapPoint(address, callback);
        }
        else
            callback(null);

    });

}

function showHereMapMarker(latLng) {
    //alert(latLng.lat() + ', ' + latLng.lng());
    var marker = new H.map.Marker(
        latLng
    );
}

function isHiddenElement(f_objElement)
{
	var blnHidden = false;
	if (f_objElement)
	{
		if (f_objElement.style.display == 'none')
		{
			blnHidden = true;
		}
	}
	return blnHidden;
}

function trackFormChanges(f_objField)
{
	var objForm = document.forms[0];
	var objHiddenField = objForm['changedfields'];
	var strFieldName = '';
	
	if (typeof f_objField == 'string')
	{
		strFieldName = f_objField;
	}
	else
	{
		strFieldName = f_objField.name;
	}
	
	if (!objHiddenField)
	{
		objHiddenField = document.createElement('INPUT');
		objHiddenField.type = 'hidden';
		objHiddenField.name = 'changedfields';
		objHiddenField.id = 'changedfields';
		objHiddenField.value = '';
		objForm.appendChild(objHiddenField);
	}
	
	if (objHiddenField.value)
	{
		if ((',' + objHiddenField.value.toLowerCase() + ',').indexOf(',' + strFieldName.toLowerCase() + ',') == -1)
		{
			objHiddenField.value += ',' + strFieldName;
		}
	}
	else
	{
		objHiddenField.value = strFieldName;
	}
}

function setHiddenValue(f_strFieldName, f_strValue)
{
	var objForm = document.forms[0];
	var objHiddenField = objForm[f_strFieldName];
	
	if (!objHiddenField)
	{
		objHiddenField = document.createElement('INPUT');
		objHiddenField.type = 'hidden';
		objHiddenField.name = f_strFieldName;
		objHiddenField.id = f_strFieldName;
		objHiddenField.value = '';
		objForm.appendChild(objHiddenField);
	}
	
	objHiddenField.value = f_strValue;
}

function validateEmail(f_strEmail) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(f_strEmail);
}

function createFieldAlert(f_strParentFieldID, f_strAlertType, f_strAlertText, f_strInputID) {
    //Alert types: error, success, info, warning
    //f_strInputID only needed for error

    removeFieldAlert(f_strParentFieldID + "_alert")

    var span = document.createElement('span');

    span.id = f_strParentFieldID + '_alert'
    span.className = 'field-alert alert ' + f_strAlertType;

    span.innerHTML = '<span class="field-alert-arrow"></span>' + f_strAlertText;

    document.getElementById(f_strParentFieldID).appendChild(span);

    if (f_strAlertType == "error")
        document.getElementById(f_strInputID).className = "error";
    else
        document.getElementById(f_strInputID).className = "";
}

function removeFieldAlert(f_strAlertFieldID) {
    var element = document.getElementById(f_strAlertFieldID);
    if (typeof (element) != 'undefined' && element != null)
        element.parentNode.removeChild(element);
}

function removeElement(f_strElementID) {
    var element = document.getElementById(f_strElementID);
    element.parentNode.removeChild(element);
}

function deleteSavedSearch(f_strSearchID) {
    removeElement("search-" + f_strSearchID)
    query = "searchid=" + f_strSearchID
    $.post("/ajax/SearchHandler.aspx?action=deletesavedsearch", query, function (data) {
        //alert(context.localizer.translate("removed"));
    });
}

function deleteFollowDealer(f_strSearchID) {
    query = "searchid=" + f_strSearchID
    $.post("/ajax/SearchHandler.aspx?action=deletesavedsearch", query, function (data) {
        //alert(context.localizer.translate("removed"));
    });
}
function deleteFollowAds(f_strSearchID) {
    query = "searchid=" + f_strSearchID
    $.post("/ajax/SearchHandler.aspx?action=deletesavedsearch", query, function (data) {
        //alert(context.localizer.translate("removed"));
    });
}

function getQueryStringParameterByName(name, querystring) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(querystring);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function sponsoredAdsRotator(arrContent, enoughAds) {
	var animate = function(opt, num, time) {
		var prod1;
		var prod2;
		var prod3;
		if (opt == 0) {
			prod1 = arrContent[3];
			prod2 = arrContent[4];
			prod3 = arrContent[5];
		}
		else {
			prod1 = arrContent[0];
			prod2 = arrContent[1];
			prod3 = arrContent[2];
		}
		$("#prod_" + num).animate({ opacity: "1.0" }, time);
		$("#prod_" + num).animate({ opacity: "0.0" }, 500, function() {
			switch (num) {
				case 1: $("#prod_" + num).html(prod1); break;
				case 2: $("#prod_" + num).html(prod2); break;
				default: $("#prod_" + num).html(prod3);
			}
		});
		$("#prod_" + num).animate({ opacity: "1.0" }, 500);
		$("#prod_" + num).animate({ opacity: "1.0" }, time);
	};

	var x = 1;
	while (x < 1000 && enoughAds == '1') {
		x++;
		var opt = '0';
		if (x % 2 == 1)
			opt = '1';
		animate(opt, 1, 2000);
		animate(opt, 2, 2000);
		animate(opt, 3, 2000);
	}
}

function ShowDialogBox(title, content, btn1text, cssClass, action) {
    var btn1css;
    var btn2css;

    if (btn1text == '') {
        btn1css = "hidecss";
    } else {
        btn1css = "showcss";
    }

    $("#lblMessage").html(content.replace("+"," "));

    $("#dialog").dialog({
        dialogClass: cssClass,
        resizable: false,
        title: title,
        modal: true,
        width: '300px',
        height: 'auto',
        bgiframe: false,
        hide: { effect: 'scale', duration: 300 },

        buttons: [
                        {
                            text: btn1text,
                            "class": btn1css,
                            click: function () {

                                $("#dialog").dialog('close');
                                if (action == 'reload') {
                                    location.reload();
                                }
                            }
                        }
        ]
    });
    if (title == null || title == "") {
        $(".ui-widget-header").css({ "display": "none" });
    }
}

function NewWindow(mypage, myname, w, h, scroll, pos) {
    if (pos == "random") { LeftPosition = (screen.availWidth) ? Math.floor(Math.random() * (screen.availWidth - w)) : 50; TopPosition = (screen.availHeight) ? Math.floor(Math.random() * ((screen.availHeight - h) - 75)) : 50; }
    if (pos == "center") { LeftPosition = (screen.availWidth) ? (screen.availWidth - w) / 2 : 50; TopPosition = (screen.availHeight) ? (screen.availHeight - h) / 2 : 50; }
    if (pos == "default") { LeftPosition = 50; TopPosition = 50 }
    else if ((pos != "center" && pos != "random" && pos != "default") || pos == null) { LeftPosition = 0; TopPosition = 20 }
    settings = 'width=' + w + ',height=' + h + ',top=' + TopPosition + ',left=' + LeftPosition + ',scrollbars=' + scroll + ',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
    win = window.open(mypage, myname, settings);
    if (win.focus) { win.focus(); }
}
function CloseNewWin() { if (win != null && win.open) win.close() }

function showPaymentInfo(f_intTransID, f_strBlock, f_strBank) {
    var strUrl = '/PayAds.aspx?TransID=' + f_intTransID;
    if (f_strBank) {
        strUrl += '&BankID=' + f_strBank;
    }
    strUrl += '&ShowInfo=' + f_strBlock + '#' + f_strBlock;
    window.location = strUrl;
}

function changePhonePrefixCountry(value) {
    var idx = 0;
    $("#reg_private_phone_prefix option").each(function () {        
        if ($(this).val().substr(0, 2) == value) {
            return false;
        }
        idx++;
    });
    $('#reg_private_phone_prefix').prop('selectedIndex', idx);
    $("#reg_private_phone_prefix").change();

}

function toggleDisplay(f_strElementId, f_blnAnimate, f_fnOnPreShow, f_fnOnAfterHide) {
    if (f_strElementId) {
        var objElement = document.getElementById(f_strElementId);
        if (objElement) {
            if (isHiddenElement(objElement)) {
                showElement(f_strElementId, f_blnAnimate, f_fnOnPreShow);
                return 1;
            }
            else {
                hideElement(f_strElementId, f_blnAnimate, f_fnOnAfterHide);
                return 0;
            }
        }
    }
    return -1;
}

function paySelectedPrivateAds(f_strErrorMsg) {
	var objForm = document.forms[0];
	var strProdIds = '';
	for (i = 0; i < objForm.length; i++) {
		if (objForm[i].name.toLowerCase() == 'prodid') {
			if (objForm[i].checked) {
				if (strProdIds.length > 0) {
					strProdIds += ',';
				}
				strProdIds += objForm[i].value;
			}
		}
	}

	if (strProdIds.length > 0) {
		//var strUrl = '/PayAds.aspx?ProdID=' + strProdIds;
		//window.location.href = strUrl;
	    //submitForm('', '/PayAds.aspx');
	    submitForm('', '/EditAd.aspx?step=3');
	}
	else if (f_strErrorMsg) {
		alert(f_strErrorMsg);
	}
}
$(document).ready(function () {
    if ($('[id^="Master_Footer_newsletterUsertype"]').length) {
        $('[id^="Master_Footer_newsletterUsertype"]').change(function () {
            if ($('#captchaVerif:visible').length == 0) {
                $('#newsletterButtonList-error').hide();
                $('#captchaVerif').show();
            }
        });
    }

    if ($("#Master_Footer_newsletterUsertype").find('input[type="radio"]').is(':checked')) {
        if ($('#captchaVerif:visible').length == 0) {
            $('#newsletterButtonList-error').hide();
            $('#captchaVerif').show();

        }
    }


    $(document).on("click", "#submitNewsletter", function (ev) {
        ev.stopImmediatePropagation();

        if (validateNewsletterForm()) {
            $('#newsletterEmail-error').hide();
            $('#newsletterButtonList-error').hide();
            document.forms[0]['postaction'].value = 'send_newsletter';
            form = document.forms[0];
            $.ajax({
                type: 'post',
                url: $(form).attr('action'),
                data: $(form).serialize(),
                success: function (msg) {
                    isOk = false;

                    if (msg.substr(0, 2) == 'ok') {
                        isOk = true;
                    }

                    if (isOk) {
                        $('.newsletterContent').html('<h1>' + $('#newslettetThanks').attr('value') + '</h1>');
                        $('#newsletterEmail-error').hide();
                        $('#newsletterButtonList-error').hide();
                    }
                }
            });
        }

        return false;

    });

    $(document).on("click", "#targetcountry, #targetcountry_v2", function (ev) {
        suff = '';

        if ($(this).attr('id') == 'targetcountry_v2') {
            suff = '_v2';
        }
        selectedOptions = $(this).find('option:selected');
        userSelectedCountriesTxt = $('#userSelectedCountries' + suff).text();
        if (userSelectedCountriesTxt.indexOf(selectedOptions.text()) == -1) {
            newIndex = $('#userSelectedCountries' + suff + ' .want-Ad-slCountries').length + 1;
            newElem = "<div class='want-Ad-slCountries' rel='" + selectedOptions.val() + "'>" + "&nbsp; <span class='recordIndex'>" + newIndex + ". " + "</span>"
                + selectedOptions.text() + "<a class='Orange11 remove-country'>&nbsp;&nbsp; &#187; " + $('#userSelectedCountries' + suff).attr('rel') + "</a></div>";
            $('#userSelectedCountries' + suff).append(newElem);
            $('#selectedCountriesStr' + suff).val($('#selectedCountriesStr' + suff).val() + selectedOptions.val() + ",");
        }
    });

    $(document).on("click", "#userSelectedCountries a, #userSelectedCountries_v2 a", function (ev) {
        suff = '';
        ev.stopPropagation();
        if ($(this).parent('.want-Ad-slCountries').parent().attr('id') == 'userSelectedCountries_v2') {
            suff = '_v2';
        }
        removedValue = $(this).parent().attr('rel');
        $('#selectedCountriesStr' + suff).val($('#selectedCountriesStr' + suff).val().replace(removedValue + ",", ''));
        $("#targetcountry" + suff + " :selected").each(function (index, elem) {
            if ($(elem).val() == removedValue) {
                $(elem).removeAttr("selected");
            }
        });
        $(this).parent().remove();
        $('#userSelectedCountries' + suff + ' .want-Ad-slCountries .recordIndex').each(function (index, elem) {
            $(elem).html((index + 1) + '. ');
        });
    });

    //contact seller - listing functionality
    /*
    $(document).on("click", "[id^='companyContactBtn']", function (ev) {
        prodId = $(this).attr("id");
        dialogId = 'contactSellerContent-' + prodId;
        companyData = prodId.replace("companyContactBtn_", "").split('_');
        if (companyData.Length = 2) {
            $.ajax({
                type: 'get',
                url: "/ajax/ContactHandler.aspx?action=getformhtml&cf_productid=" + companyData[1] + "&cf_catalog=" + companyData[0] + "&astype=77",
                success: function (msg) {
                    message = jQuery.parseJSON(msg)
                    $("body").append('<div id="' + dialogId + '"><div>');
                    $("#" + dialogId).append(message.content);
                    $("#" + dialogId).dialog({
                        width: 600,
                        modal: true,
                        close: function (event, ui) {
                            $("#" + dialogId).remove();
                        }
                    });

                    $("#" + dialogId).dialog('widget').find(".ui-dialog-titlebar").removeClass('ui-widget-header');
                    $("#" + dialogId).dialog("open");

                    try {
                        if ($('#cf_rental_from').length > 0) {
                            addDatepickerToSelector('div.contact-form:nth-child(2) > ul:nth-child(1) > li:nth-child(2) > input:nth-child(2)', currentContext.language);
                            addDatepickerToSelector('div.contact-form:nth-child(2) > ul:nth-child(1) > li:nth-child(1) > input:nth-child(2)', currentContext.language);
                        }
                    }
                    catch (e) {
                    }
                }
            });
        }

    });*/

    //contact seller - submit action - listing functionality
    $(document).on("click", "div[id^='contactSellerContent-companyContactBtn'] a.contact-submit", function (ev) {
        elemId = $(this).closest("div[id^='contactSellerContent-companyContactBtn']").attr('id');
        if (!$("input[name='action']").length) {
            $("#" + elemId + ' .contact-form .contact-fields').append('<input type="hidden" value="sendmessage" name="action">');
        }
        if (!$("input[name='NDsgnStat']").length) {
            $("#" + elemId + ' .contact-form .contact-fields').append('<input type="hidden" name="NDsgnStat" value="$#!@m<te$t*ng$#">');
        }
        data = $("#" + elemId + ' .contact-form .contact-fields').find('input[name],select[name],textarea[name],input[name]').serialize();

        $.ajax({
            type: 'post',
            url: "/ajax/ContactHandler.aspx?astype=77",
            data: $("#" + elemId + ' .contact-form').find('input[name],select[name],textarea[name],input[name]').serialize(),
            success: function (msg) {
                message = jQuery.parseJSON(msg);
                if (message.success == false) {
                    if (message.errorFields.length) {
                        if (!$("#customErrorDiv").length) {
                            $("#" + elemId + ' div').first().append("<div id='customErrorDiv' class='alert error'><span class='icon'></span><div class='content'><b>" + message.message + "</b></div></div>");
                        }
                        for (i = 0; i < message.errorFields.length; i++) {
                            $('[name="' + message.errorFields[i] + '"]').addClass('error');
                            $("label[id='lbl_" + message.errorFields[i] + "']").addClass('error');
                        }
                    }
                }
                else {
                    dlP('Form_filling', '', '');
                    if (message.content.length > 1) {
                        $("#" + dialogId).dialog("close");
                        $('body').append(message.content);
                        $('#cf-similar-ads').addClass('isAjax');
                        $('#cf-similar-ads').dialog({
                            width: 700,
                            modal: true,
                            close: function (event, ui) {
                                $('#cf-similar-ads').remove();
                            }
                        });

                        $("#cf-similar-ads div.modal-window").removeClass('modal-window');
                        $("#cf-similar-ads a.close-button.close-click").remove();
                        $("#cf-similar-ads").dialog('widget').find(".ui-dialog-titlebar").removeClass('ui-widget-header');
                        $("#cf-similar-ads").dialog("open");
                    }
                    else {
                        $("#" + dialogId).html(message.message);
                    }
                }
            }
        });
    });

    //contact seller - similar ads - listing functionality
    $(document).on("click", "div#cf-similar-ads.isAjax a.contact-submit", function (ev) {
        if (!$("input[name='action']").length) {
            $('div#cf-similar-ads.isAjax ul.flo-wrap.items').append('<input type="hidden" value="sendcopy" name="action">');
        }
        $.ajax({
            type: 'post',
            url: "/ajax/ContactHandler.aspx",
            data: $('div#cf-similar-ads.isAjax').find('input:checked[name],input:hidden[name],textarea[name]').serialize(),
            success: function (msg) {
                message = jQuery.parseJSON(msg);
                if (message.success == true) {
                    $('div#cf-similar-ads.isAjax div.select-content.flo-wrap').remove();
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert.success div.content p').remove();
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert').addClass('success');
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert').removeClass('error');
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert div.content b').html(message.message);
                }
                else {

                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert').addClass('error');
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert').removeClass('success');
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert div.content p').remove();
                    $('div#cf-similar-ads.isAjax div.modal-inner-wrap div.alert div.content b').html(message.message);
                    if (message.errorFields.length) {

                        for (i = 0; i < message.errorFields.length; i++) {
                            $('[name="' + message.errorFields[i] + '"]').addClass('error');
                            $("label[id='lbl_" + message.errorFields[i] + "']").addClass('error');
                        }
                    }
                }
            }
        });
    });

    $(document).on("click", "div#cf-similar-ads.isAjax a.close-click", function (ev) {
        $("#cf-similar-ads").dialog("close");
    });

    if ($("#ef_contractassetgid").length) {
        $("#ef_contractassetgid").attr("disabled", "disabled");
        $("#ef_contractassetgid").addClass("no-edit");
    }
    if ($("#ef_e1productid").length) {
        $("#ef_e1productid").attr("disabled", "disabled");
        $("#ef_e1productid").addClass("no-edit");
    }

    $('#product-card select.doConversion').on('change', function () {
        element = $(this);
        $(element).siblings(".select-text").text($(element).find(":selected").text());
        defaultVals = $(element).attr('rel');

        if (defaultVals.length > 0) {
            defaultValArr = defaultVals.split("$$");
            if (defaultValArr.length == 2) {
                $.ajax({
                    type: 'post',
                    url: "/ajax/ProductHandler.aspx?action=dounitconvertion",
                    data: { 'value': defaultValArr[0], 'defaultUnit': defaultValArr[1], 'desiredUnit': $(element).find(":selected").val() },
                    success: function (msg) {
                        $(element).parent().siblings(".unitPcardSpn").text(msg);
                    }
                });
            }
        }
    });

    if ($("#edit-ad.edit-form").length)
    {
        if ($("#edit-ad.edit-form").find('.form-fieldsubgroup').length > 0) {
            $("#edit-ad.edit-form").find('.form-fieldsubgroup').each(function (index) {
                if ($(this).find('li.unitGroupDispay').length == 2) {
                    elem1 = $(this).find('li.unitGroupDispay').eq(0).find('label.form-field-header').eq(0);
                    elem2 = $(this).find('li.unitGroupDispay').eq(1).find('label.form-field-header').eq(0);
                    e1H = $(elem1).prop('offsetHeight');

                    if ($(elem1).prop('offsetHeight') == 0 && !$(this).parent("ul.form-fields").is(":visible"))
                    {
                        $(this).parent("ul.form-fields").show();
                        e1H = $(elem1).prop('offsetHeight');
                        $(this).parent("ul.form-fields").hide();
                    }
                    if (e1H > 24)
                    {
                        $(elem2).innerHeight(e1H)
                    }
                }
            });
        }
    }

    if (($("#top_text_collapsed").length == 0 || $("#top_text_collapsed").text().trim().lenght == 0) && $("#savesearchform").hasClass("rentalSrcSeo"))
    {
        $("#savesearchform").hide();
    }

    if ($("#myContacts a.reportSpam").length || $("#allWantAds a.reportSpam").length)
    {

        var indentifier = "ContactsFull";
        if ($("#allWantAds a.reportSpam").length)
            indentifier = "WantAdLeads1";
        $(document).on("click", "#myContacts a.reportSpam, #allWantAds a.reportSpam", function (ev) { 
            ev.stopImmediatePropagation();
            ev.stopPropagation();
            ev.preventDefault();
            var elemClone = $("#reportSpamStruct").clone();
            var url = $(this).attr("href");
            var dialogtitle = $("#reportSpamStruct #reportspamform .contact-form h2").text();
            $("#reportSpamStruct #reportspamform .contact-form h2").hide();
            $("#reportSpamStruct").attr('style', "");
            $("#reportSpamStruct").find("a.primary-button").remove();
            
            $("#Master_ContentArea_" + indentifier + "_ReportSpamForm_spamEmail").val(url.split("spamEmail=")[1]);
            $("#reportSpamStruct").dialog({
                resizable: false,
                title: dialogtitle,
                width: 700,
                modal: true,
                keyboard: false,
                buttons: {
                    Send: function () {
                        var ok = SendSpam(url, indentifier);
                        if (ok) {
                            $(this).dialog().empty();
                            $(this).dialog("close");
                            $("#reportSpamStruct").remove()
                            $("body").append(elemClone);
                            location.reload();
                        }

                    },
                
                    Close: function () {
                        $(this).dialog().empty();
                        $(this).dialog("close");
                        $("#reportSpamStruct").remove()
                        $("body").append(elemClone);
                    }
                },
            });
            $(".ui-dialog-titlebar button").hide();
        });
    }

});

$(window).load(function () {
    if (($('select.no-edit').length > 0) && $('select.no-edit').is(':disabled')) {
        $('select.no-edit').next('span.select-text').addClass('no-edit');
    }
});

function beforeSettSubmit() {
    if (($('form#aspnetForm').length > 0) && ($('form#aspnetForm').attr('action').indexOf('MyMascus.aspx?Show=settings') > -1 || $('form#aspnetForm').attr('action').indexOf('CompanyAdmin2.aspx') > -1)) { 
        if (($('select.no-edit').length > 0) && $('select.no-edit').is(':disabled')) 
        {
            $('select.no-edit').removeAttr('disabled');
        }
    }
    return true;
}
function validateEmail(email) {
    var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return re.test(email);
}

function validateNewsletterForm() {
    ok = true;

    if (!$("#Master_Footer_newsletterUsertype").find('input[type="radio"]').is(':checked')) {
        ok = false;
        if ($('#newsletterButtonList-error:visible').length == 0) {
            $('#newsletterButtonList-error').show();
        }
    } else {
        $('#newsletterButtonList-error').hide();
    }

    if (($('#newsletterButtonList-error').val().lenght == 0) || !validateEmail($('#footer-newsletter-form-mail').val())) {
        if ($('#newsletterEmail-error:visible').length == 0) {
            $('#newsletterEmail-error').show();
        }
        ok = false;
    }
    else {
        $('#newsletterEmail-error').hide();
    }

    if ($('#g-recaptcha-response').val() == '') {
        if (($('#newsletterCaptcha-error:visible').length == 0) &&  !($('#captchaVerif:visible').length == 0)) {
            $('#newsletterCaptcha-error').show();
        }
        ok = false;
    } else {
        $('#newsletterCaptcha-error').hide();
    }

    return ok;
}
function SendSpam(url, indentifier)
{
    ok = true;
    if ($("#Master_ContentArea_" + indentifier + "_ReportSpamForm_spamMessage").val().trim().length == 0) {
        $("#Master_ContentArea_" + indentifier + "_ReportSpamForm_spamMessageError").attr("style", "");
        ok = false;
    }
    else {
        $.ajax({
            type: "POST",
            url: url + "&isAjax=1",
            data: { 'Master$ContentArea$spamMessage': $("#Master_ContentArea_" + indentifier + "_ReportSpamForm_spamMessage").val(), 'Master$ContentArea$ReportReason': $("#Master_ContentArea_" + indentifier + "_ReportSpamForm_ReportReason").val() },
            success: function (data) {

            }
        });
    }

    return ok;
}

function deactivateExpToolAd(f_strSiteCode, f_strDealer, f_strStockNumber) {
    query = "sitecode=" + f_strSiteCode + "&dealerid=" + f_strDealer + "&stocknumber=" + f_strStockNumber
    $.post("/ajax/DealerAdminHandler.aspx?action=deactivateexptoolad", query, function (data) {
        //alert(context.localizer.translate("removed"));
    });

    //Modify link
    $("#" + f_strStockNumber + "_" + f_strSiteCode).removeAttr("href");
    $("#" + f_strStockNumber + "_" + f_strSiteCode).addClass("cursordefault");

    //Modify styles
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " div").removeClass("red").removeClass("white").removeClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " div").addClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").removeClass("red").removeClass("white").removeClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").addClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").removeClass("fa").removeClass("fa-close").removeClass("fa-check")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").addClass("fa fa-spinner")
    $("#message_content_" + f_strStockNumber + "_" + f_strSiteCode).empty()
}

function activateExpToolAd(f_strSiteCode, f_strDealer, f_strStockNumber) {
    query = "sitecode=" + f_strSiteCode + "&dealerid=" + f_strDealer + "&stocknumber=" + f_strStockNumber
    $.post("/ajax/DealerAdminHandler.aspx?action=activateexptoolad", query, function (data) {
        //alert(context.localizer.translate("removed"));
    });

    //Modify link
    $("#" + f_strStockNumber + "_" + f_strSiteCode).removeAttr("href");
    $("#" + f_strStockNumber + "_" + f_strSiteCode).addClass("cursordefault");

    //Modify styles
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " div").removeClass("red").removeClass("white").removeClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " div").addClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").removeClass("red").removeClass("white").removeClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").addClass("blue")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").removeClass("fa").removeClass("fa-close").removeClass("fa-check")
    $("#" + f_strStockNumber + "_" + f_strSiteCode + " i").addClass("fa fa-spinner")
    $("#message_content_" + f_strStockNumber + "_" + f_strSiteCode).empty()
}
var mascus = {};
(function(context) {
    context.parameters = {
        ajaxUrl: "/ajax/SearchHandler.aspx",
        screenSizeCheckSelector: ".small-screen-navigation",
        loadingIconHtml: "<i class=\"fa fa-spinner fa-spin loading-icon\"></i>"
    };

    context.domain = null;
    context.country = null;
    context.language = null;
    context.currency = null;
    context.url = null;
    context.dir = null;
    context.catalogName = null;
    context.categoryName = null;
    context.productId = null;
    context.companyId = null;
    context.loggedIn = false;
    context.isE1 = false;
    context.overridableProperties = ["domain", "country", "language", "currency", "url", "dir", "catalogName", "categoryName", "productId", "companyId", "loggedIn", "isE1"];
    context.settingsCookieName = "MascusSettings";
    context.traceMode = false;
    context.tracer = null;
    context.initFuncs = [];
    context.readyFuncs = [];
    context.loadFuncs = [];

    context.init = function(parameters) {
        if (typeof parameters === "undefined") {
            for (var i = 0; i < context.initFuncs.length; i++) {
                context.initFuncs[i]();
            }
        }
        else if ($.isFunction(parameters))
            context.initFuncs.push(parameters);
        else if ($.isPlainObject(parameters)) {
            for (var prop in parameters) {
                if ($.inArray(prop, context.overridableProperties) != -1)
                    context[prop] = parameters[prop];
                else if (prop === "translations")
                    context.localizer.addTranslations(parameters[prop]);
                else if (prop === "formatting" && $.isPlainObject(parameters[prop]))
                    $.extend(context.localizer, parameters[prop]);
                else
                    context.parameters[prop] = parameters[prop];
            }
        }
    };

    context.ready = function(parameters) {
        if (typeof parameters === "undefined") {
            context.layout.sizeCheckElement = $(context.parameters.screenSizeCheckSelector);
            context.layout.ready();

            for (var i = 0; i < context.readyFuncs.length; i++) {
                context.readyFuncs[i]();
            }
        }
        else if ($.isFunction(parameters))
            context.readyFuncs.push(parameters);
    };

    context.load = function(parameters) {
        if (typeof parameters === "undefined") {
            for (var i = 0; i < context.loadFuncs.length; i++) {
                context.loadFuncs[i]();
            }
        }
        else if ($.isFunction(parameters))
            context.loadFuncs.push(parameters);
    };

    context.extensionBase = function(containerElement, parameters, defaultParameters) {
        if (typeof this.container === "undefined")
            this.container = containerElement;
        if (typeof this.parameters === "undefined")
            this.parameters = {};
        if (typeof this.overridableProperties === "undefined")
            this.overridableProperties = null;

        var tempParameters = $.extend({}, defaultParameters, parameters);

        for (var prop in tempParameters) {
            if (tempParameters[prop] != null) {
                //if ($.inArray(prop, context.overridableProperties) != -1)
                //	context[prop] = tempParameters[prop];
                if (prop === "translations")
                    context.localizer.addTranslations(tempParameters[prop]);
                else if (this.overridableProperties != null) {
                    if ($.inArray(prop, this.overridableProperties) != -1)
                        this[prop] = tempParameters[prop];
                }
                else
                    this.parameters[prop] = tempParameters[prop];
            }
        }
    };

    context.layout = {
        breakpoints: { small: 768, medium: 1060 },
        isSmallScreen: false,
        isSearchVisible: false,
        sizeCheckElement: null,
        loadingIconTemplate: null,
        modalPopups: [],

        ready: function() {
            var self = this;

            self.checkScreenSize();
            $(window).resize(function() {
                self.checkScreenSize();
            });

            // Small screen menu toggle buttons
            $(".small-screen-navigation a").click(function(e) {
                e.preventDefault();
                $(this).parent().siblings().children("a").removeClass("open");
                $(this).toggleClass("open");
            });

            // Toggle hidden search form for small screens
            $(".toggle-search").click(function(e) {
                context.navigation.getUserMenu().close();
                context.navigation.getMainMenu().close();
                self.toggleSearchForm();
            });

            // Toggle main menu for small screens 
            $(".toggle-mainmenu").click(function (e) {
                context.navigation.getUserMenu().close();
                context.navigation.getMainMenu().toggle();
                if (self.isSearchVisible)
                    self.toggleSearchForm();
            });

            // Toggle user menu for small screens
            $(".toggle-settings").click(function(e) {
                context.navigation.getMainMenu().close();
                context.navigation.getUserMenu().toggle();
                if (self.isSearchVisible)
                    self.toggleSearchForm();
            });
            // Scroll back to top on mobile
            $(".back-to-top").click(function (e) {
                $("html, body").animate({ scrollTop: 0 }, 1000, function () {
                });
            });

            //Toggle footer details on mobile
            $(".mobile-toggle").click(function (e) {
                if (self.isSmallScreen) {
                    var wrapper = $(this).parent();
                    if (wrapper.find(".mobile-hide").first().hasClass("mobile-hidden")) {
                        wrapper.find(".mobile-hide").removeClass("mobile-hidden");
                        wrapper.find(".mobile-toggle i").replaceWith("<i class=\"fa fa-caret-up\"></i>");
                        wrapper.addClass("toggle-open");
                        $("html, body").animate({ scrollTop: $(document).height() }, 1200);
                    }
                    else {
                        wrapper.find(".mobile-toggle i").replaceWith("<i class=\"fa fa-caret-down\"></i>");  
                        $("html, body").animate({ scrollTop: $(this).offset().top - $(window).height() + 100 }, 1200, function () {
                            wrapper.find(".mobile-hide").addClass("mobile-hidden");
                            wrapper.find(".mobile-toggle").removeClass("toggle-open");
                        });
                    }
                }
           });
             
            // Updating the regions dropdown on registration
            $("#reg_company_country").change(function (e) {
                self.updateRegistrationRegions('reg_company_country', 'reg_company_region', context.language, self);                
            });

            $("#reg_private_country").change(function (e) {
                self.updateRegistrationRegions('reg_private_country', 'reg_private_region', context.language, self);
            });            

            var body = $("body");
            loadingIcon = $(context.parameters.loadingIconHtml);
            loadingIcon.css({ "display": "none", "position": "absolute", "top": "0", "left": "0" });
            body.append(loadingIcon);
            self.loadingIconTemplate = loadingIcon;

            self.customizePageElements();
        },

        checkScreenSize: function() {
            if (this.sizeCheckElement && this.sizeCheckElement.css("display") === "none")
                this.isSmallScreen = false;
            else
                this.isSmallScreen = true;
        },
       
        customizePageElements: function() {
            var self = this;

            this.customizeFormElements();

            // Tooltips
            $(".tooltip").each(function() {
                var elem = $(this);
                var parent = elem.parent();
                parent.addClass("tooltip-wrap");
                elem.prepend("<span class=\"tooltip-arrow\"></span><a class=\"close-button\">" + context.localizer.translate("b_close_window") + "</a>");
            });
            $(".tooltip-opener").click(function() {
                $(this).siblings(".tooltip").toggle();
            });
            $(".tooltip .close-button").click(function() {
                $(this).parent(".tooltip").hide();
            });
            $(".tooltip-hover").mouseenter(function () {
                $(".tooltip").hide();
                $(this).siblings(".tooltip").toggle();
            });
            //$(".tooltip-hover-wrap .tooltip").mouseleave(function () {
            //    $(".tooltip").hide();
            //});
            $(".tooltip-hover-wrap").mouseleave(function () {
                $(".tooltip").hide();
            });


            // Dynamic translations of content text
            $(".translate-content").each(function(e) {
                self.customizeTranslationElement($(this));
            });

            $("#reg_company_country").change();           

            $("#reg_private_country").change();
            
        },

        customizeFormElements: function(containerElement) {
            if (!containerElement)
                containerElement = $("body");
            this.customizeSelectElements(containerElement);
        },

        customizeSelectElements: function(containerElement) {
            var self = this;

            if (!containerElement)
                containerElement = $("body");

            containerElement.find("select:not([multiple])").each(function() {
                self.customizeSelectElement($(this));
            });

            containerElement.find("select.select-language,select.select-country,select.select-currency").each(function() {
                var select = $(this);
                if (select[0].options.length <= 1) {
                    if (select.hasClass("select-language"))
                        self.getSelectData("languages", select);
                    else if (select.hasClass("select-country"))
                        self.getSelectData("countries", select);
                    else if (select.hasClass("select-currency"))
                        self.getSelectData("currencies", select);
                }
            });
        },

        customizeSelectElement: function (element) {
            var self = this;
            if (element.hasClass("no-select-box") || element.data("customized") === true || element.parent().hasClass("select-box"))
                return;

            element.wrap("<div class=\"select-box" + (element.hasClass("error") ? " error" : "") + "\"/>");
            element.after("<span class=\"select-text\"></span><i class=\"select-arrow fa fa-caret-down\"></i>");
            if (element.hasClass("sort-select custom-mobile-select") && (window.innerWidth < self.breakpoints.small)) {
                element.next('.select-text').html('<img src="/images/sort.png" height="20" />');
            }
            else {
                var val = element.children("option:selected").text();
                if (element.hasClass("page-size-select custom-mobile-select") && (window.innerWidth < self.breakpoints.small)) {
                    val = '<i class="fa fa-eye"></i> ' + val;
                }
                element.next(".select-text").html(val);
                element.change(function (e) {
                    var val = $(this).children("option:selected").text();
                    if (element.hasClass("page-size-select custom-mobile-select") && (window.innerWidth < self.breakpoints.small)) {
                        val = '<i class="fa fa-eye"></i> ' + val;
                }
                    $(this).next(".select-text").html(val);
                });
            }

            element.focus(function(e) {
                $(this).parent().addClass("focus");
            });
            element.blur(function(e) {
                $(this).parent().removeClass("focus");
            });

            element.data("customized", true);
        },

        customizeTranslationElement: function(containerElement) {
            if (containerElement.data("customized") === true)
                return;

            var self = this;

            containerElement.wrapInner("<span class=\"translate-source\"></span>");
            containerElement.append("<span class=\"translate-target\" style=\"display:none;\"></span>");
            containerElement.append(" <span class=\"translate-controls\"><a class=\"translate-toggle translate-show\">[" + context.localizer.translate("see_translation") + "]</a></span>")
            var toggleElem = containerElement.find(".translate-toggle");
            toggleElem.click(function(e) {
                var sourceElem = containerElement.find(".translate-source");
                var targetElem = containerElement.find(".translate-target");
                var showHandler = function() {
                    sourceElem.hide();
                    targetElem.show();
                    toggleElem.text("[" + context.localizer.translate("hide_translation") + "]");
                    toggleElem.toggleClass("translate-show translate-hide");
                };
                var hideHandler = function() {
                    targetElem.hide();
                    sourceElem.show();
                    toggleElem.text("[" + context.localizer.translate("see_translation") + "]");
                    toggleElem.toggleClass("translate-show translate-hide");
                };

                if (toggleElem.hasClass("translate-show")) {
                    if (targetElem.data("loaded"))
                        showHandler();
                    else {
                        self.showLoadingIcon(toggleElem, null, "after");
                        //alert(sourceElem.html());
                        context.localizer.translateText(sourceElem.html(), containerElement.data("texttype"), function(data) {
                            self.hideLoadingIcon(toggleElem);
                            targetElem.data("loaded", true)
                            var text = data.text;
                            if (data.success && data.disclaimer)
                           		text += " <span class=\"translate-disclaimer\">" + data.disclaimer + "</span>";
                           	targetElem.html(text);
                            showHandler();
                        });
                    }
                }
                else
                    hideHandler();
            });

            containerElement.data("customized", true);
        },

        disableEnterPress: function(containerElement) {
            containerElement = $(containerElement);
            if (containerElement.length === 1 && containerElement.prop("tagName") === "INPUT") {
                containerElement.keydown(function(e) {
                    if (e.which === 13) {
                        e.preventDefault();
                        return false;
                    }
                });
            }
            containerElement.find("input:text").keydown(function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    return false;
                }
            });
        },

        toggleSearchForm: function() {
            if ($(".left-column .search-form").length) {
                $(".has-search").animate({ "left": this.isSearchVisible ? 0 : 250 }, 200);
                this.isSearchVisible = !this.isSearchVisible;
            }
        },

        updateRegistrationRegions: function(countryFieldName, regionFieldName, language, self)  {
            var countryCode = $("#" + countryFieldName).val();
            var selectedValue = $('[id$=' + regionFieldName + ']').val();
            var selectBox = $('[id$=' + regionFieldName + ']').parent();
            self.showLoadingIcon(selectBox, null, "center");
            $.getJSON('/js/GetLocations.ashx?action=officialmainregions&country=' + countryCode + '&language=' + language, null, function (result) {
                // todo: add a spinner
                self.hideLoadingIcon(selectBox);
                selectBox.empty();
                if (result.items.length > 0) {
                    selectBox.replaceWith($('<select/>', { 'name': regionFieldName, 'id': regionFieldName }));
                    for (var i = 0; i < result.items.length; i++)
                        $('[id$=' + regionFieldName + ']').append($('<option></option>').attr('value', result.items[i][0]).text(result.items[i][1]));
                    $('[id$=' + regionFieldName + ']').val(selectedValue);
                    self.customizeSelectElement($('[id$=' + regionFieldName + ']'));
                } else {
                    selectBox.replaceWith($('<input/>', { 'type': 'text', 'value': '', 'name': regionFieldName, 'id': regionFieldName }));
                    $('[id$=' + regionFieldName + ']').wrap("<div class='no-select-box'>");
                }
            });
        },

        fillSelect: function(selectElement, options, clearOldOptions) {
            var self = this;

            if (!options || selectElement.data("filled") === true || selectElement.data("fetching") === true)
                return;
            else if (!clearOldOptions && selectElement[0].options.length > 1) {
                selectElement.data("filled", true);
                return;
            }

            if ($.isFunction(options)) {
                selectElement.data("fetching", true);
                self.showLoadingIcon(selectElement);
                options(function(data) {
                    self.fillSelect(selectElement, data);
                    self.hideLoadingIcon(selectElement);
                });
            }
            else if ($.isArray(options) && options.length) {
                var initialValue = selectElement.val();
                if (clearOldOptions)
                    selectElement.empty();
                var html = "";
                for (var i = 0; i < options.length; i++) {
                    var value = options[i].value;
                    var text = options[i].text;
                    if (!text)
                        text = value;
                    var tooltip = options[i].tooltip;

                    html += "<option value=\"" + value + "\"";
                    if (clearOldOptions && value == initialValue)
                        html += " selected=\"selected\"";
                    if (tooltip)
                        html += " title=\"" + tooltip + "\"";
                    html += ">" + text + "</option>";
                }
                selectElement.append(html);
                selectElement.data("filled", true);
            }
        },

        getSelectData: function(sourceType, selectElement, filledCallback) {
            var self = this;
            if (selectElement.data("filled") === true || selectElement.data("fetching") === true)
                return;
            selectElement.data("fetching", true);
            //self.showLoadingIcon(selectElement);

            var fetchedCallback = function(data) {
                selectElement.data("fetching", false);
                self.fillSelect(selectElement, data, true);
                //self.hideLoadingIcon(selectElement);

                if ($.isFunction(filledCallback))
                    filledCallback();
            };
            if (sourceType === "languages")
                context.localizer.getLanguages(fetchedCallback);
            else if (sourceType === "countries")
                context.localizer.getCountries(null, fetchedCallback);
            else if (sourceType === "currencies")
                context.localizer.getCurrencies(fetchedCallback);
        },

        getLoadingIcon: function(forElement, cssClass, create) {
            var self = this;

            var loadingIcon = null;
            if (forElement != null) {
                loadingIcon = forElement.data("loading-icon");
                if (!loadingIcon && create) {
                    loadingIcon = self.loadingIconTemplate.clone();
                    loadingIcon.css("display", "none");
                    loadingIcon.css("position", "absolute");
                    if (cssClass)
                        loadingIcon.addClass(cssClass);
                    $("body").append(loadingIcon);
                    forElement.data("loading-icon", loadingIcon);
                }
            }
            return loadingIcon;
        },

        showLoadingIcon: function(forElement, cssClass, xAlign, yAlign, xOffset, yOffset) {
            var self = this;

            var loadingIcon = self.getLoadingIcon(forElement, cssClass, true);
            if (loadingIcon) {
                loadingIcon.css("visibility", "hidden");
                loadingIcon.css("display", "block");
                var elemPos = forElement.offset();
                if(typeof(elemPos) != "undefined"){
                if (!xAlign)
                    xAlign = "center";
                else if (context.dir === "rtl") {
                    if (xAlign === "left")
                        xAlign = "right";
                    else if (xAlign === "right")
                        xAlign = "left";
                    else if (xAlign === "before")
                        xAlign = "after";
                    else if (xAlign === "after")
                        xAlign = "before";

                    if (xOffset)
                        xOffset = 0 - xOffset;
                    if (yOffset)
                        yOffset = 0 - yOffset;
                    }
                    var x = elemPos.left;
                    if (xAlign === "left")
                        x = x;
                    else if (xAlign === "right")
                        x += forElement.outerWidth() - loadingIcon.width();
                    else if (xAlign === "before")
                        x -= loadingIcon.width() + 3;
                    else if (xAlign === "after")
                        x += forElement.outerWidth() + 3;
                    else //center
                        x += (forElement.outerWidth() / 2) - (loadingIcon.width() / 2);
                    if (xOffset)
                        x += xOffset;

                    if (!yAlign)
                        yAlign = "middle";
                    var y = elemPos.top;
                    if (yAlign === "top")
                        y = y;
                    else if (yAlign === "bottom")
                        y += forElement.outerHeight() - loadingIcon.height();
                    else if (yAlign === "above")
                        y -= loadingIcon.height() + 3;
                    else if (yAlign === "below")
                        y += forElement.outerHeight() + 3;
                    else //middle
                        y = elemPos.top + (forElement.outerHeight() / 2) - (loadingIcon.height() / 2);
                    if (yOffset)
                        y += yOffset;

                    y = parseInt(y + "");
                    x = parseInt(x + "");
                    loadingIcon.css("left", x + "px");
                    loadingIcon.css("top", y + "px");
                    loadingIcon.css("visibility", "visible");
                }

            }
        },

        hideLoadingIcon: function(forElement) {
            var self = this;

            var loadingIcon = self.getLoadingIcon(forElement, null, false);
            if (loadingIcon)
                loadingIcon.css("display", "none");
        },

        hideLoadingIcons: function() {
            $(".loading-icon").css("display", "none");
        },

        getModalPopup: function(id) {
            if (id) {
                for (var i = 0; i < this.modalPopups.length; i++) {
                    if (this.modalPopups[i].id === id)
                        return this.modalPopups[i];
                }
            }
            return null;
        },

        openModalPopup: function(id, title, content, footer) {
            var popup = this.getModalPopup(id);
            if (popup == null && (typeof title !== "undefined" || typeof content !== "undefined" || typeof footer !== "undefined")) {
                popup = new this.modalPopup(id);
                popup.setTitle(title);
                popup.setContent(content);
                popup.setFooter(footer);
            }
            if (popup != null)
                popup.open();
            return popup;
        },

        closeModalPopup: function(id) {
            var popup = this.getModalPopup(id);
            if (popup !== null)
                popup.close();
        },

        toggleContentBox: function(f_strToggleElementId, f_strHeaderId, f_strButtonId, f_strExpandText, f_strCollapseText, f_fnOnPreShow, f_fnOnAfterHide) {
            var elem = $("#" + f_strToggleElementId);
            var newState = 0;
            if (elem.css("display") === "none")
                newState = 1;
            elem.toggle();
            if (f_strButtonId) {
                var objButton = $("#" + f_strButtonId);
                if (objButton.length != 0) {
                    objButton.find(".fa").toggleClass("fa-toggle-down fa-toggle-up");
                    if (newState === 1)
                        objButton.attr("title", f_strCollapseText);
                    else
                        objButton.attr("title", f_strExpandText);
                }
            }
        }
    };

    context.layout.modalPopup = function(id, parameters, isBackwardsCompatible) {
        this.parameters = $.extend({
            autoAdjustHeight: true,
            loadingText: context.localizer.translate("progress_loading"),
            savingText: context.localizer.translate("progress_saving"),
            closeText: context.localizer.translate("b_close")
        }, parameters);

        this.id = id ? id : "modal-popup-" + context.layout.modalPopups.length;
        this.isBackwardsCompatible = isBackwardsCompatible === true ? true : false;
        //this.defaultWidth = '440px';
        //this.defaultHeight = 'auto';
        //this.maxWidthRatio = 0.9;
        //this.maxHeightRatio = 0.8;
        this.beforeOpen = null;
        this.afterOpen = null;
        this.beforeClose = null;
        this.afterClose = null;
        this.loadingText = this.parameters.loadingText;
        this.savingText = this.parameters.savingText;
        this.closeText = this.parameters.closeText;
        this.closeHtml = "<p class=\"align-right\"><a class=\"primary-button compatible-close-button\">" + this.closeText + "</a></p>";

        this.isOpen = false;
        this.container = null;
        this.overlay = null;
        this.popup = null;
        this.innerWrap = null;
        this.header = null;
        this.content = null;
        this.footer = null;
        this.init();
        context.layout.modalPopups.push(this);
    };

    context.layout.modalPopup.prototype = {
        init: function() {
            var self = this;
            var elem = null;
            var html = "";

            html += "<div class=\"overlay\" style=\"cursor:pointer;\" id=\"" + this.id + "\">";

            html += "<div class=\"modal-window col-span8\" style=\"cursor:default;\">";
            html += "<div class=\"modal-inner-wrap\">";

            html += "<div class=\"modal-header\">";
            html += "<h5 class=\"dialog-title\"></h5>";
            html += "<a class=\"close-button\" title=\"" + context.localizer.translate("b_close_window") + "\">" + context.localizer.translate("b_close_window") + "</a>";
            html += "</div>";
            html += "<div class=\"modal-content\"></div>";
            html += "<div class=\"modal-footer\"></div>";

            html += "</div>";
            html += "</div>";

            html += "</div>";

            var elem = $(html);
            $("body").append(elem);

            this.container = elem;
            this.overlay = this.container;
            this.popup = elem.find(".modal-window");
            this.popup.click(function (e) {
                if (e.target !== this)
                    return;

                e.preventDefault();
                return false;
            });
            this.innerWrap = elem.find(".modal-inner-wrap");
            this.header = elem.find(".modal-header");
            this.title = elem.find(".dialog-title");
            this.content = elem.find(".modal-content");
            this.footer = elem.find(".modal-footer");
            this.closeButton = elem.find(".close-button");
            this.closeButton.click(function(e) {
                e.preventDefault();
                self.close();
            });
            //this.clickableOverlay = elem.find(".overlay");
            this.overlay.click(function (e) {
                if (e.target !== this)
                    return;
                e.preventDefault();
                self.close();
            });

            return elem;
        },

        open: function() {
            if (this.isOpen)
                return;
            if ($.isFunction(this.beforeOpen))
                this.beforeOpen(this);

            $("body").addClass("modal");
            if (this.parameters.autoAdjustHeight)
                this.adjustHeight();

            this.overlay.addClass("open");
            this.popup.addClass("open");
            this.isOpen = true;
            if (this.isBackwardsCompatible)
                this.showLoading();

            if ($.isFunction(this.afterOpen))
                this.afterOpen(this);
        },

        close: function() {
            if ($.isFunction(this.beforeClose))
                this.beforeClose(this);

            this.overlay.removeClass("open");
            this.popup.removeClass("open");
            this.isOpen = false;
            $("body").removeClass("modal");

            if ($.isFunction(this.afterClose))
                this.afterClose(this);
        },

        showLoading: function(text) {
            if (!this.isOpen)
                this.open();
            this.setContent("<div class=\"ali-c\">" + context.parameters.loadingIconHtml + " " + (text ? text : this.loadingText) + "</div>");
        },

        showSaving: function(text) {
            if (!this.isOpen)
                this.open();
            this.setContent("<div class=\"ali-c\">" + context.parameters.loadingIconHtml + " " + (text ? text : this.savingText) + "</div>");
        },

        hideLoading: function() {
            this.clearContent();
        },

        hideSaving: function() {
            this.clearContent();
        },

        loadContent: function(f_strContent) {
            this.setContent(f_strContent);
        },

        clearContent: function() {
            this.content.html("");
        },

        loadError: function(text) {
            this.setContent("<b>ERROR:</b> " + text + this.closeHtml);
        },

        setHeader: function(html) {
            this.setElementHtml(this.header, html);
        },

        setTitle: function(html) {
            this.setElementHtml(this.title, html);
        },

        setContent: function(html) {
            this.setElementHtml(this.content, html);
            if (html && html.indexOf("compatible-close-button") != -1) {
                var self = this;
                this.content.find(".compatible-close-button").click(function(e) {
                    e.preventDefault();
                    self.close();
                });
            }
        },

        setFooter: function(html) {
            this.setElementHtml(this.footer, html);
        },

        setElementHtml: function(elem, html) {
            if (html) {
                elem.html(html);
                elem.show();
            }
            else
                elem.hide();
        },

        adjustHeight: function() {
            this.popup.css("visibility", "hidden");
            this.overlay.css("visibility", "hidden");
            this.popup.addClass("open");
            this.overlay.addClass("open");

            var popupPos = this.popup.position();
            var popupMargin = popupPos.top;
            var popupPadding = this.popup.outerHeight(true) - this.popup.height();
            var popupHeight = window.innerHeight - (popupMargin * 2);
            this.popup.css("max-height", popupHeight + "px");

            var contentHeight = popupHeight;
            contentHeight -= popupPadding;
            contentHeight -= this.innerWrap.outerHeight(true) - this.innerWrap.height();
            contentHeight -= this.header.outerHeight(true);
            contentHeight -= this.footer.outerHeight(true);
            this.content.css("max-height", contentHeight + "px");

            this.popup.removeClass("open");
            this.overlay.removeClass("open");
            this.popup.css("visibility", "visible");
            this.overlay.css("visibility", "visible");
        },

        refreshPage: function(f_strContent, f_strUrl) {
            var strText = '';
            if (f_strContent)
                strText += f_strContent + ' ';
            strText += this.loadingText;
            this.showLoading(strText);

            if (!f_strUrl)
                f_strUrl = window.location;
            window.location = f_strUrl;
        }
    };

    context.localizer = {
        translations: {},
        thousandsSeparator: "",
        decimalSeparator: ".",
        ajaxUrl: "/ajax/LocalizationHandler.aspx",

        getLanguages: function(callback) {
        	var url = this.ajaxUrl + "?action=getlanguages";
        	url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        getContinents: function(callback) {
        	var url = this.ajaxUrl + "?action=getcontinents";
        	url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        getCountries: function(continent, callback) {
        	var url = this.ajaxUrl + "?action=getcountries";
            if (continent)
            	url += "&forcontinent=" + continent;
            url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        getRegions: function(country, callback) {
            var url = this.ajaxUrl + "?action=getregions";
            if (country)
            	url += "&forcountry=" + country;
            url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        getCurrencies: function(callback) {
        	var url = this.ajaxUrl + "?action=getcurrencies";
        	url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        getDomains: function(callback) {
        	var url = this.ajaxUrl + "?action=getdomains";
        	url += "&userlang=" + context.language;
            context.ajax(url, callback);
        },

        convertCurrency: function(from, to, values, decimals, callback) {
            var url = this.ajaxUrl + "?action=convertcurrency&from=" + from + "&to=" + to + "&values=" + values.join() + "&decimals=" + decimals;
            context.ajax(url, callback);
        },

        getLanguageSwitchUrl: function(languageCode) {
            if (!context.loggedIn && !context.isE1 && context.domain === "com") {
                var lowerCode = languageCode.toLowerCase();
                if (lowerCode === "ar" || (lowerCode === "es" && context.country !== "us"))
                	return "http://" + lowerCode + ".mascus.com";
            }
            return context.addQueryParameter(context.url, "language", languageCode);
        },

        getCountrySwitchUrl: function(countryCode) {
            return context.addQueryParameter(context.url, "country", countryCode);
        },

        getCurrencySwitchUrl: function(currencyCode) {
            return context.addQueryParameter(context.url, "currency", currencyCode);
        },

        addTranslations: function(translations) {
            $.extend(this.translations, translations);
        },

        translate: function(key) {
            var text = this.translations[key];
            return text ? text : "TRANSL: " + key;
        },

        translateText: function(text, textType, callback) {
        	var url = this.ajaxUrl + "?action=translate&texttype=" + textType;
            $.post(url, { text: text }, callback, "json");
        },

        parseNumber: function(num, defaultValue, allowNegative, allowZero) {
            var val = $.trim(num);
            val = val.replace(/\D/g, "");
            val = parseInt(val);
            if (typeof defaultValue === "undefined" || isNaN(defaultValue))
                defaultValue = 0;
            if (isNaN(val) || (!allowNegative && val < 0) || (!allowZero && val === 0))
                val = defaultValue;
            return val;
        },

        formatDisplayNumber: function(num, thousandsSeparator) {
            var val = num + "";
            if (typeof thousandsSeparator === "undefined")
                thousandsSeparator = this.thousandsSeparator;
            if (!thousandsSeparator || !num)
                return val;
 
            var re = new RegExp("(-?[0-9]+)([0-9]{3})");
            while (re.test(val)) {
                val = val.replace(re, "$1" + thousandsSeparator + "$2");
            }
            return val;
        }
    };

    context.cache = {
        items: [],

        get: function(key) {
            var value = null;
            for (var i = 0; i < this.items.length; i++) {
                if (this.items[i].key === key) {
                    value = this.items[i].value;
                    break;
                }
            }
            return value;
        },

        set: function(key, value) {
            var done = false;
            for (var i = 0; i < this.items.length; i++) {
                if (this.items[i].key === key) {
                    this.items[i].value = value;
                    done = true;
                    break;
                }
            }
            if (!done)
                this.items.push({ key: key, value: value });
        },

        clear: function() {
            this.items = [];
        }
    };

    context.log = {
        track: function(action, params, callback) {
            var paramQuery = $.param(params);
            var url = "/ajax/TrackHandler.aspx?action=" + action + "&" + paramQuery;
            $.ajax(url, {
                cache: false,
                success: function(data, textStatus, jqXHR) {
                    if ($.isFunction(callback))
                        callback(data, textStatus, jqXHR);
                }
            });
        }
    };

    context.createNamespace = function(path, parentObj) {
        var obj = null;
        if (!$.isArray(path))
            path = path.split(".");
        if (!parentObj)
            parentObj = context;
        if (typeof parentObj[path[0]] === "undefined")
            parentObj[path[0]] = {};
        obj = parentObj[path[0]];
        if (path.length > 1)
            obj = context.createNamespace(path.splice(1), parentObj[path[0]]);
        return obj;
    };

    context.extend = function(namespace, obj) {
        if (!namespace || !obj)
            return;
        var parentObj = context.createNamespace(namespace);
        if ($.isFunction(obj))
            obj = obj(context);
        $.extend(parentObj, obj);
    };

    context.ajax = function(url, okCallbackOrSettings, errorCallback, dataType, allowBrowserCache, allowLocalCache, timeout) {
        if ($.isPlainObject(okCallbackOrSettings))
            $.ajax(okCallbackOrSettings);
        else {
            var data = null;
            if (typeof allowBrowserCache !== "boolean")
                allowBrowserCache = true;
            if (typeof allowLocalCache !== "boolean")
                allowLocalCache = true;

            if (allowLocalCache)
                data = context.cache.get(url);

            if (data) {
                context.trace("mascus.ajax('" + url + "'): FROM CACHE");
                if ($.isFunction(okCallbackOrSettings))
                    okCallbackOrSettings(data, null, null);
                return data;
            }
            else {
                context.trace("mascus.ajax('" + url + "'): FROM SERVER");
                $.ajax(url, {
                    cache: allowBrowserCache,
                    dataType: dataType ? dataType : "json",
                    error: function(jqXHR, textStatus, errorThrown) {
                        //alert(errorThrown);
                        context.layout.hideLoadingIcons();
                        if ($.isFunction(errorCallback))
                            errorCallback(jqXHR, textStatus, errorThrown);
                    },
                    success: function(data, textStatus, jqXHR) {
                        if (allowLocalCache)
                            context.cache.set(url, data);
                        if ($.isFunction(okCallbackOrSettings))
                            okCallbackOrSettings(data, textStatus, jqXHR);
                    },
                    timeout: typeof timeout === "number" ? timeout : null
                });
            }
        }
    };

    context.mergeArrays = function(arr1, arr2, checkDuplicates, createNewArray) {
        if (typeof checkDuplicates !== "boolean")
            checkDuplicates = true;
        if (typeof createNewArray !== "boolean")
            createNewArray = false;

        if (createNewArray) {
            var arr3 = [];
            for (var i = 0; i < arr1.length; i++) {
                if ($.inArray(arr1[i], arr3) === -1)
                    arr3.push(arr1[i]);
            }
            for (var i = 0; i < arr2.length; i++) {
                if ($.inArray(arr2[i], arr3) === -1)
                    arr3.push(arr2[i]);
            }
            return arr3;
        }
        else {
            for (var i = 0; i < arr2.length; i++) {
                if ($.inArray(arr2[i], arr1) === -1)
                    arr1.push(arr2[i]);
            }
            return arr1;
        }
    };

    context.addQueryParameter = function(url, key, value) {
        if (!url || !key)
            return url;

        if (!value)
            value = "";
        var path = "";
        var query = "";
        while (url.length > 0 && url.lastIndexOf("?") == url.length - 1)
            url = url.substr(0, url.length - 1);
        if (url == "?")
            url = "";
        if (url.indexOf("?") != -1) {
            path = url.substr(0, url.indexOf("?"));
            query = url.substr(path.length + 1, url.length - path.length - 1);
        }
        else
            path = url;
        //alert('path: ' + path + ', query: ' + query);

        var added = false;
        var joinSeparator = "&";
        if (query.length > 0) {
            if (query.indexOf("&amp;") != -1) {
                query = query.replace(/&amp;/gi, "&");
                joinSeparator = "&amp;";
            }
            var parts = query.split("&");
            for (var i = parts.length - 1; i >= 0; i--) {
                var keyValue = parts[i].split("=");
                if (keyValue.length == 2) {
                    if (keyValue[0].toLowerCase() == key.toLowerCase()) {
                        if (value.length == 0)
                            parts.splice(i, 1);
                        else
                            parts[i] = keyValue[0] + "=" + encodeURIComponent(value);
                        added = true;
                        break;
                    }
                }
            }
            query = parts.join(joinSeparator);
        }

        if (!added && value.length != 0) {
            if (query.length != 0)
                query += joinSeparator;
            query += key + "=" + encodeURIComponent(value);
        }

        if (query.length != 0)
            url = path + "?" + query;
        else
            url = path;

        return url;
    };

    context.attrEncode = function(str) {
        return str.replace(/"/g, "&quot;");
    },

	context.getCookie = function(name) {
	    //if (document.cookie) {
	    var arr = document.cookie.split(";");
	    for (var i = 0; i < arr.length; i++) {
	        var keyValue = $.trim(arr[i]);
	        if (keyValue.indexOf(name + "=") === 0)
	            return keyValue.substring(name.length + 1, keyValue.length);
	    }
	    //}
	    return "";
	},

	context.setCookie = function(name, value) {
	    document.cookie = name + "=" + value + "; path=/";
	},

	context.getSettingsCookieValue = function(key) {
	    var cookie = context.getCookie(context.settingsCookieName);
	    var arr = cookie.split("&");
	    for (var i = 0; i < arr.length; i++) {
	        var keyValue = $.trim(arr[i]);
	        if (keyValue.indexOf(key + "=") === 0)
	            return keyValue.substring(key.length + 1, keyValue.length);
	    }
	    return "";
	},

	context.setSettingsCookieValue = function(key, value) {
	    var cookie = "?" + context.getCookie(context.settingsCookieName);
	    cookie = context.addQueryParameter(cookie, key, value);
	    context.setCookie(context.settingsCookieName, cookie.substring(1, cookie.length));
	},

	context.getQueryStringValue = function(key, queryString) {
		if (!queryString)
			queryString = location.search;
		key = key.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var re = new RegExp("[\\?&]" + key + "=([^&#]*)");
		var results = re.exec(queryString);
		return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	},

	context.trace = function(txt) {
	    if (context.traceMode && context.tracer && txt) {
	        txt = txt + "";
	        context.tracer.append(txt.replace(/</g, "&lt;") + "<br />");
	    }
	};

    context.collectionBase = function() {
        this.objType = null;
        this.itemObjType = null;
        this.items = [];
        this.searchPropertyName = "name";
        this.sortFunc = null;
    };

    context.collectionBase.prototype = {
        init: function(items) {
            this.clear();
            if (typeof items !== "undefined" && $.isArray(items)) {
                for (var i = 0; i < items.length; i++) {
                    this.add(items[i]);
                }
            }
        },

        getNewItem: function(extendWith) {
            return $.extend({}, extendWith);
        },

        clear: function() {
            this.items = [];
        },

        contains: function(value, propertyName) {
            return this.find(value, propertyName) != null;
        },

        find: function(value, propertyName) {
            var itemWithIndex = this.findWithIndex(value, propertyName);
            if (itemWithIndex.index >= 0)
                return itemWithIndex.item;
            else
                return null;
        },

        findWithIndex: function(value, propertyName) {
            var item = null;
            var index = -1;

            if (this.items.length != 0) {
                if (typeof propertyName !== "string" || propertyName == null || propertyName.length === 0)
                    propertyName = this.searchPropertyName;
                if (typeof value.objType === "string" && value.objType === this.itemObjType)
                    value = value[propertyName];

                if (propertyName in this.items[0]) {
                    for (var i = 0; i < this.items.length; i++) {
                        if (this.items[i][propertyName] == value) {
                            item = this.items[i];
                            index = i;
                            break;
                        }
                    }
                }
            }

            return { "index": index, "item": item };
        },

        filter: function(value, propertyName, mapFunc, prefilteredItems) {
            var arr = [];
            var items = prefilteredItems != null && $.isArray(prefilteredItems) ? prefilteredItems : this.items;

            if (items.length != 0) {
                var regex = null;
                if (value instanceof RegExp)
                    regex = value;
                if (typeof propertyName !== "string" || propertyName == null || propertyName.length === 0)
                    propertyName = this.searchPropertyName;
                var isMapFunc = $.isFunction(mapFunc);
                arr = $.map(items, function(item, index) {
                    if ((regex != null && regex.test(item[propertyName])) || (regex == null && item[propertyName] == value)) {
                        if (isMapFunc)
                            return mapFunc(item, index);
                        else
                            return item;
                    }
                    else
                        return null;
                });
            }

            return arr;
        },

        add: function(item, canReplace) {
            if (item != null) {
                if ($.isArray(item)) {
                    for (var i = 0; i < item.length; i++) {
                        this.add(item[i], canReplace);
                    }
                }
                else if (item != null && typeof item === "object") {
                    if (typeof item.objType === "undefined")
                        item = this.getNewItem(item);

                    if (item != null && item.objType === this.itemObjType) {
                        if (canReplace === true)
                            this.replace(item, item, true);
                        else
                            this.items.push(item);
                    }
                }
            }
        },

        remove: function(key) {
            var item = this.findWithIndex(key);
            if (item.index >= 0)
                this.items.splice(item.index, 1);
        },

        replace: function(key, newItem, canAdd) {
            if (newItem != null && typeof newItem === "object") {
                if (typeof newItem.objType === "undefined")
                    newItem = this.getNewItem(newItem);

                if (newItem != null) {
                    var oldItem = this.findWithIndex(key);

                    if (oldItem.index >= 0)
                        this.items[oldItem.index] = newItem;
                    else if (canAdd === true)
                        this.items.push(newItem);
                }
            }
        },

        sort: function() {
            if ($.isFunction(this.sortFunc))
                this.items.sort(this.sortFunc);
        }
    };

    context.banners = {
        surfaceToolboxBanner: function () {
            var bannerDiv = $('#sub_ticker');
            var bannerDiv1 = $('#ticker');
            if (this.bannerHasAnyContent(bannerDiv, false)) {
                bannerDiv1.show();
                bannerDiv1.css("z-index", "1000");
            }
        },
        dragSideBannerOnScroll: function () {
            var banners = $('.ranneb-sda');
            var footer = $('#footer');
            
            var banHeight = banners.height();
            var banOffsetTop = banners.offset().top;
            var banOffsetLeft; //window can be resized, count this at on scroll
            var footOffsetTop = footer.offset().top
            var viewportHeight;
            var scrollTop;
            var scrollTopPast;


            $(document).scroll(function () {
                viewportHeight = $(window).height(); //window can be resized
                scrollTop = $(document).scrollTop();
                banOffsetLeft = banners.offset().left;
                
                if (scrollTop > scrollTopPast) {    //scrolling down
                    if (scrollTop < 10) {
                        banners.css({ 'position': 'static', 'top': '', 'bottom': '' });
                    }
                    else if ((scrollTop + viewportHeight) > footOffsetTop) {
                        banners.css({ 'position': 'fixed', 'top': '', 'bottom': ((scrollTop + viewportHeight) - footOffsetTop) + 'px', 'left': banOffsetLeft + 'px' })
                    }
                    else if ((scrollTop + viewportHeight) > (banOffsetTop + banHeight)) {
                        banners.css({ 'position': 'fixed', 'top': '', 'bottom': '5px', 'left': banOffsetLeft + 'px' });
                    }
                    else {
                        banners.css({ 'position': 'static', 'top': '', 'bottom': '' });
                    }
                }
                else {   //scrolling up
                    if (scrollTop < 10) {
                        banners.css({ 'position': 'static', 'top': '', 'bottom': '' });
                    }
                    else if ((scrollTop + viewportHeight) > footOffsetTop) {
                        banners.css({ 'position': 'fixed', 'top': '', 'bottom': ((scrollTop + viewportHeight) - footOffsetTop) + 'px', 'left': banOffsetLeft + 'px' })
                    }
                    else if ((scrollTop) > (banOffsetTop)) {
                        banners.css({ 'position': 'fixed', 'top': '5px', 'bottom': '', 'left': banOffsetLeft + 'px' });
                    }
                    else {
                        banners.css({ 'position': 'static', 'top': '', 'bottom': '' });
                    }
                }
                scrollTopPast = scrollTop;
            });

        },
        bannerHasAnyContent: function (bannerContainer, showDebug) {
            var hasContent = false;
            if (bannerContainer && bannerContainer.length > 0 && bannerContainer[0]) {
                var children = bannerContainer.find('embed,a,img,object,iframe,div');
                hasContent = (children.length > 0);
                if (mascus.domain == 'no' && children.find('img').attr('width') == 1)
                    hasContent = false;

                if (showDebug) {
                    var debugString = '';
                    for (var i = 0; i < children.length; i++) {
                        debugString += '\n' + (i + 1) + '/' + children.length + ': ' + children[i];
                    }
                    alert(bannerContainer.attr('id') + debugString);
                }
            }
            //	hasContent = true;
            return hasContent;
        }
	};

})(mascus);

$(document).ready(function() {
	mascus.ready();
});

$(window).load(function() {
    mascus.load();
    surfaceToolbocBanner();
    //traceBanners();
});


// Backwards compatibility

var currentContext = mascus;


function getModalPopup() {
	var popupId = "backwards-compatible-popup";
	var popup = mascus.layout.getModalPopup(popupId);
	if (popup == null) {
		popup = new mascus.layout.modalPopup(popupId, null, true);
		popup.setHeader("");
	}
	return popup;
}

function surfaceToolbocBanner(showDebug) {
    var bannerDiv = $('#sub_ticker');
    var bannerDiv1 = $('#ticker');
    if (bannerHasContent(bannerDiv, showDebug)) {
        bannerDiv1.show();
        bannerDiv1.css("z-index", "1000");
    }
}

function bannerHasContent(bannerContainer, showDebug) {
    var hasContent = false;
    if (bannerContainer && bannerContainer.length > 0 && bannerContainer[0]) {
        var children = bannerContainer.find('embed,a,img,object,iframe,div');
        hasContent = (children.length > 0);
        if (mascus.domain == 'no' && children.find('img').attr('width') == 1 ) 
                hasContent = false;
            
                
        //fix for norwegian banner system which always has an image, propbly aplicable all over, but to be safe only NO
        
       
        if (showDebug) {
            var debugString = '';
            for (var i = 0; i < children.length; i++) {
                debugString += '\n' + (i + 1) + '/' + children.length + ': ' + children[i];
            }
            alert(bannerContainer.attr('id') + debugString);
        }
    }
    //	hasContent = true;
    return hasContent;
}

function addDatepicker(controlName, language) {
    $('#' + controlName).datetimepicker({
        minView: 2,
        format: 'Y-m-d',
        lang: language,
        timepicker: false,
        closeOnDateSelect: true,
        scrollInput: false
    });
}

function addDatepickerToSelector(selector, language) {    
    $(selector).datetimepicker({
        minView: 2,
        format: 'Y-m-d',
        lang: language,
        timepicker: false,
        closeOnDateSelect: true,
        scrollInput: false
    });
    
}
function counterPromo() {
   
    var datea = new Date();
    var montha = datea.getMonth() + 1;
    var daya = datea.getDate();


        countDownDate = new Date(2019, montha, 8, 23, 59, 59).getTime();
        bonussize = 50;
    


    // Update the count down every 1 second
    var x = setInterval(function () {

        // Get todays date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);


        document.getElementById("percent").innerHTML = bonussize + "&#37;";
        document.getElementById("d").innerHTML = days ;
        document.getElementById("h").innerHTML = hours;
        document.getElementById("m").innerHTML = minutes ;
        document.getElementById("s").innerHTML = seconds ;
        // If the count down is over, write some text 
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("d").innerHTML = "EXPIRED";
        }
    }, 1000);
}
mascus.extend("forms", function(context) {
	var formType = {
		quick: 1,
		basic: 2,
		advanced: 3,
		faceted: 4
	};

	var fieldType = {
		textBox: 1,
		singleSelectDropDown: 2,
		multiSelectDropDown: 3,
		checkBoxList: 4,
		checkBoxPopup: 5,
		radioButtonList: 6,
		multiValueTextBox: 7,
		range: 8,
		location: 9,
		readOnly: 10,
		hidden: 11,
		boolean: 12
	};

	function form(containerElement, parameters, defaultParameters) {
		context.extensionBase.call(this, containerElement, parameters, defaultParameters);

		this.objType = "form";
		this.formType = this.parameters.formType ? this.parameters.formType : formType.advanced;
		this.id = this.parameters.id ? this.parameters.id : this.container.attr("id");
	};

	//$.extend(form.prototype, {
	//});

	function formFieldGroup(ownerForm) {
		this.objType = "formfieldgroup";
		this.form = ownerForm;
		this.element = null;
		this.loading = false;

		this.groupId = 0;
		this.name = null;
		this.label = null;
		this.tooltip = null;
		this.fields = null;
	};

	//$.extend(formFieldGroup.prototype, {
	//});

	function formField(ownerForm, ownerOption, ownerGroup) {
		this.objType = "formfield";
		this.form = ownerForm;
		this.parentOption = typeof ownerOption === "undefined" ? null : ownerOption;
		this.parentGroup = typeof ownerGroup === "undefined" ? null : ownerGroup;
		this.element = null;
		this.dataElements = {};
		this.modalPopup = null;
		this.loading = false;
		this.lastOptionQuery = null;
		this.isAutocomplete = false;
		this.autocompleteCache = [];

		this.name = null;
		this.requestKey = null;
		this.label = null;
		this.tooltip = null;
		this.value = null;
		this.type = 0;
		this.optionsHeader = null;
		this.optionsLoaded = false;
		this.canHaveSubfields = false;
		this.disableDependentFields = false;
		this.dependentFields = null;
		this.filterFields = null;
		this.preloadFields = null;
		this.dependsOnFields = [];
		this.filtersByFields = [];
		this.preloadsByFields = [];
		this.options = null;
		this.optionSelector = null;
		this.optionColStartHtml = null;
		this.optionColEndHtml = null;
	};

	$.extend(formField.prototype, {
		isDependentOn: function(field) {
			if (($.inArray(field.name, this.dependsOnFields) !== -1) || (field.requestKey && $.inArray(field.requestKey, this.dependsOnFields) !== -1))
				return true;
			else
				return false;
		},

		isFilteredBy: function(field) {
			if (($.inArray(field.name, this.filtersByFields) !== -1) || (field.requestKey && $.inArray(field.requestKey, this.filtersByFields) !== -1))
				return true;
			else
				return false;
		},

		isPreloadedBy: function(field) {
			if (($.inArray(field.name, this.preloadsByFields) !== -1) || (field.requestKey && $.inArray(field.requestKey, this.preloadsByFields) !== -1))
				return true;
			else
				return false;
		}
	});

	function formFieldOption(ownerField) {
		this.objType = "formfieldoption";
		this.field = ownerField;
		this.element = null;

		this.name = null;
		this.resultCount = 0;
		this.hasChildren = false;
		this.disableDependentFields = false;
		this.selected = false;
		this.text = null;
		this.tooltip = null;
		this.value = null;
		this.subfields = null;
	};

	//$.extend(formFieldOption.prototype, {
	//});

	function formFieldGroupCollection(ownerForm) {
		context.collectionBase.call(this);

		this.objType = "formfieldgroupcollection";
		this.itemObjType = "formfieldgroup";
		this.form = ownerForm;
	};

	$.extend(formFieldGroupCollection.prototype, context.collectionBase.prototype);

	function formFieldCollection(ownerForm, ownerOption, ownerGroup) {
		context.collectionBase.call(this);

		this.objType = "formfieldcollection";
		this.itemObjType = "formfield";
		this.form = ownerForm;
		this.parentOption = typeof ownerOption === "undefined" ? null : ownerOption;
		this.parentGroup = typeof ownerGroup === "undefined" ? null : ownerGroup;
	};

	$.extend(formFieldCollection.prototype, context.collectionBase.prototype);

	function formFieldOptionCollection(ownerField) {
		context.collectionBase.call(this);

		this.objType = "formfieldoptioncollection";
		this.itemObjType = "formfieldoption";
		this.field = ownerField;
		this.searchPropertyName = "value";

		this.sortFunc = function(a, b) {
			return (a.longText ? a.longText : (a.text ? a.text : a.value)).localeCompare(b.longText ? b.longText : (b.text ? b.text : b.value));
		};
	};

	$.extend(formFieldOptionCollection.prototype, context.collectionBase.prototype, {
		getItems: function(deep, arr) {
			if (typeof deep !== "boolean")
				deep = this.field !== null ? this.field.canHaveSubfields : false;
			if (!deep)
				return this.items;
			else {
				if (!arr || !$.isArray(arr))
					arr = [];
				arr = arr.concat(this.items);
				for (var i = 0; i < this.items.length; i++) {
					for (var j = 0; j < this.items[i].subfields.items.length; j++) {
						arr = this.items[i].subfields.items[j].options.getItems(true, arr);
					}
				}
				return arr;
			}
		},

		getSelected: function(deep) {
			return $.map(this.getItems(deep), function(item, index) {
				return (item.selected ? item : null);
			});
		},

		getSelectedValues: function(deep) {
			return $.map(this.getSelected(deep), function(item, index) {
				return item.value;
			});
		},

		getValues: function(deep) {
			return $.map(this.getItems(deep), function(item, index) {
				return item.value;
			});
		},

		hasSubfields: function() {
			for (var i = 0; i < this.items.length; i++) {
				if (this.items[i].subfields.items.length !== 0)
					return true;
			}
			return false;
		},

		select: function(value, deep) {
			return this.toggleSelect(value, true, deep);
		},

		deselect: function(value, deep) {
			return this.toggleSelect(value, false, deep);
		},

		deselectAll: function(deep) {
			var found = false;
			var items = this.getItems(deep);
			for (var i = 0; i < items.length; i++) {
				items[i].selected = false;
				found = true;
			}
			return found;
		},

		toggleSelect: function(value, selected, deep) {
			var found = false;
			var items = this.getItems(deep);
			if ($.isArray(value)) {
				for (var i = 0; i < items.length; i++) {
					if ($.inArray(items[i].value, value) >= 0) {
						items[i].selected = selected;
						found = true;
					}
				}
			}
			else if (value != null && typeof value.objType === "string" && value.objType === "formfieldoption") {
				value.selected = selected;
				found = true;
			}
			else {
				var matches = this.filter(value, null, null, items);
				for (var i = 0; i < matches.length; i++) {
					matches[i].selected = selected;
					found = true;
				}
			}
			return found;
		},
	});

	return {
		formType: formType,
		fieldType: fieldType,
		form: form,
		formFieldGroup: formFieldGroup,
		formField: formField,
		formFieldOption: formFieldOption,
		formFieldGroupCollection: formFieldGroupCollection,
		formFieldCollection: formFieldCollection,
		formFieldOptionCollection: formFieldOptionCollection
	};
});

mascus.extend("navigation", function(context) {
	var _mainMenu = null;

	function mainMenu(containerElement, parameters) {
		context.extensionBase.call(this, containerElement, parameters, {
			ajaxUrl: "/ajax/MainMenuHandler.aspx"
		});

		this.children = new menuItemCollection();

		this.init();
		_mainMenu = this;
	}

	mainMenu.prototype = {
		init: function() {
			var self = this;

			this.container.find(">ul>li").each(function(e) {
				var elem = $(this);
				var aElem = elem.children("a").first();
				var path = elem.attr("data-path");
				var text = aElem.text();
				var url = aElem.attr("href");
				var hasChildren = elem.attr("data-has-children") === "true" ? true : false;
				var item = new menuItem(self, {
					element: elem,
					childMenuOpenerElement: aElem,
					path: path,
					text: text,
					url: url,
					hasChildren: hasChildren
				});
				self.children.add(item);
			});
			self.bindChildMenuEvents(self);
		},

		getData: function(action, query, callback) {
			var self = this;

			var url = this.parameters.ajaxUrl + '?action=' + action;
			url += "&l=" + context.language;
			if (query)
				url += "&" + query;
			//alert("getting " + url);
			context.ajax(url, callback, null, "json", true, false);
		},

		bindChildMenuEvents: function(item) {
			var self = this;

			if (item.childMenuBackElement) {
				item.childMenuBackElement.click(function(e) {
					e.preventDefault();
					self.toggleChildMenu(item);
				});
			}

			for (var i = 0; i < item.children.items.length; i++) {
				self.bindMenuItemEvents(item.children.items[i]);
			}
		},

		bindMenuItemEvents: function(item) {
			var self = this;

			if (item.childMenuOpenerElement) {
			    item.childMenuOpenerElement.click(function (e) {
			        e.preventDefault();
			        self.toggleChildMenu(item);
				});
			}
			else {
				item.element.click(function(e) {
				    if (!context.layout.isSmallScreen) {
				        if (item.level > 0)
				            context.layout.showLoadingIcon(item.element, "white", "right", null, -7);
				        self.closeAllMenus(item);
				        self.resizeMenus();
				    }
				});
			}
		},

		toggle: function() {
			if (context.layout.isSmallScreen) {
				if (this.container.hasClass("open"))
					this.close();
				else {
					this.close();
					this.open();
				}
			}
		},

		open: function() {
			if (context.layout.isSmallScreen)
				this.container.addClass("open");
		},

		close: function() {
			if (context.layout.isSmallScreen) {
				this.container.removeClass("open");
				this.container.find(".open").removeClass("open");
				this.container.find(".hidden").removeClass("hidden");
				this.container.find(".menu-title").removeClass("menu-title");
			}
		},

		toggleChildMenu: function(item) {
			var self = this;

			var isOpen = item.element.hasClass("open");
			if (isOpen && item.hasChildren) {
			    self.closeChildMenu(item);
				self.resizeMenus();
			}
			else {
				self.closeAllMenus(item);
				self.openChildMenu(item);
			}
		},

		openChildMenu: function(item) {
			var self = this;

			if (item.childMenuElement && item.childMenuElement.length === 1) {
				if (!context.layout.isSmallScreen)
					context.layout.hideLoadingIcon(item.element);
				item.element.addClass("open");
				item.childMenuElement.addClass("open");

				if (context.layout.isSmallScreen) {
				    item.childMenuOpenerElement.addClass("menu-title");
					if (item.parent) {
						if (item.parent.childMenuOpenerElement)
							item.parent.childMenuOpenerElement.addClass("hidden");
						if (item.parent.childMenuBackElement)
							item.parent.childMenuBackElement.parent().addClass("hidden");
					}
				}

				self.resizeMenus();
			}
			else if (item.hasChildren) {
				if (!context.layout.isSmallScreen) {
					if (item.level > 0)
						context.layout.showLoadingIcon(item.element, "white", "right", null, -7);
					else
						context.layout.showLoadingIcon(item.element, null, null, "below");
				}
				this.getData("getchildren", "path=" + encodeURIComponent(item.path), function(data) {
					item.children.init(data);
					self.renderChildMenu(item);
					self.bindChildMenuEvents(item);
					self.openChildMenu(item);
				});
			}
			else if (item.url && item.url != "#") {
			    console.log(item.url);
			    try
			    {
			        if ((item.url.indexOf("build.mascus.com") > -1) || (item.url.indexOf("qa.mascus.com") > -1))
			            window.open(item.url);
			        else
			            document.location = item.url;
			    }
			    catch (exception) {
			        document.location = item.url;
			    }
			}
		},

		closeChildMenu: function(item, isCloseAllCall) {    
			item.element.find(".open").removeClass("open");
			item.element.removeClass("open");

			if (context.layout.isSmallScreen) {
				if (item.childMenuOpenerElement)
					item.childMenuOpenerElement.removeClass("menu-title");

				if (!isCloseAllCall) {
					if (item.parent) {
						if (item.parent.childMenuOpenerElement)
							item.parent.childMenuOpenerElement.removeClass("hidden");
						if (item.parent.childMenuBackElement)
							item.parent.childMenuBackElement.parent().removeClass("hidden");

						var siblings = item.parent.children.items;
						for (var i = 0; i < siblings.length; i++) {
							var sibling = siblings[i];
							sibling.element.removeClass("hidden");
						}
					}
				}
				else {
				    item.element.addClass("hidden");
				}
			}
		},

		closeAllMenus: function(exceptItem) {
			var self = this;

			var siblings;
			if (exceptItem && exceptItem.parent)
				siblings = exceptItem.parent.children.items;
			else
				siblings = self.children.items;

			for (var i = 0; i < siblings.length; i++) {
				var sibling = siblings[i];
				if (!exceptItem || sibling.path !== exceptItem.path)
					self.closeChildMenu(sibling, true);
			}
		},

		resizeMenus: function() {
			var self = this;

			if (context.layout.isSmallScreen)
				return;

			var totalWidth = 0;
			var totalHeight = 0;
			var wrapperElem = null;
			var elem = null;
			var elemHeight = 0;
			var openMenus = self.getOpenMenuTree();
			if (openMenus.length === 0)
				return;

			for (var i = 0; i < openMenus.length; i++) {
				elem = openMenus[i].childMenuItemsElement;
				if (elem.css("height").indexOf("px") !== -1)
					elem.css("height", "auto");
				elemHeight = 0;
				if (i == 0)
					wrapperElem = openMenus[i].childMenuElement;
				totalWidth += elem.outerWidth();
				elemHeight = elem.outerHeight();
				if (elemHeight > totalHeight)
					totalHeight = elemHeight;
			}

			for (var i = 0; i < openMenus.length; i++) {
				elem = openMenus[i].childMenuItemsElement;
				elemHeight = totalHeight + elem.innerHeight() - elem.outerHeight();
				elem.css("height", elemHeight + "px");
			}

			//alert("resize " + wrapperElem.width() + "x" + wrapperElem.height() + " -> " + totalWidth + "x" + totalHeight);
			if (wrapperElem.width() != totalWidth)
				wrapperElem.css("width", totalWidth + "px");
			if (wrapperElem.height() != totalHeight)
				wrapperElem.css("height", totalHeight + "px");
		},

		getOpenMenuTree: function(startItem, items) {
			var self = this;

			if (!startItem)
				startItem = self;
			if (!items)
				items = [];

			for (var i = 0; i < startItem.children.items.length; i++) {
				var childItem = startItem.children.items[i];
				if (childItem.childMenuElement && childItem.childMenuElement.hasClass("open")) {
					items.push(childItem);
					items = self.getOpenMenuTree(childItem, items);
					break;
				}
			}
			return items;
		},

		renderChildMenu: function(item) {
			var self = this;

			var html = "";
			var elem = null;
			var ulClass = "";

			if (item.level === 0) {
				html += "<div class=\"flyout-box sub-menu\">";
				html += "<div class=\"flyout-arrow\"></div>";
				html += "<div class=\"menu-content\">";
				ulClass = "sub-menu-items";
			}
			else
				ulClass = "flyout-box sub-menu sub-menu-items";

			html += "<ul class=\"" + ulClass + " ";
			if (item.level === 0)
				html += "first-level";
			else if (item.level === 1)
				html += "second-level";
			else if (item.level === 2)
				html += "third-level";
			html += "\">";
			html += "<li class=\"back\">";
			html += "<a href=\"#\"><span class=\"back-icon\"></span>" + context.localizer.translate("b_back") + "</a>";
			html += "</li>";
			html += "</ul>";

			if (item.level === 0) {
				html += "</div>";
				html += "</div>";
			}

			elem = $(html);
			item.element.append(elem);
			item.childMenuElement = elem;
			item.childMenuItemsElement = elem;
			if (item.level === 0)
				item.childMenuItemsElement = elem.find("." + ulClass);
			else
				item.childMenuItemsElement = elem;
			item.childMenuBackElement = item.childMenuItemsElement.find(".back a");

			for (var i = 0; i < item.children.items.length; i++) {
				var childItem = item.children.items[i];
				html = this.getItemHtml(childItem);
				elem = $(html);
				item.childMenuItemsElement.append(elem);
				childItem.element = elem;
				if (childItem.hasChildren)
					childItem.childMenuOpenerElement = elem.children(".toggle-submenu");
			}
		},

		getItemHtml: function(item) {
			var html = "";

			html += "<li";
			if (item.cssClass)
				html += " class=\"" + item.cssClass + "\"";
			html += "><a onclick=\"dlP('Navigation_bar', '" + item.text + "', '');\" ";
			if (item.hasChildren)
				html += " class=\"toggle-submenu\"";
			if (item.url)
				html += " href=\"" + item.url + "\"";
			html += ">";
			if (item.iconCssClass)
				html += "<span class=\"" + item.iconCssClass + "\"></span>";
			html += item.text;
			html += "</a>";
			html += "</li>";

			return html;
		}
	};

	function menuItem(parent, extendWith) {
		this.objType = "menuitem";
		this.parent = parent;
		this.children = null;
		this.element = null;
		this.childMenuOpenerElement = null;
		this.childMenuElement = null;
		this.childMenuItemsElement = null;
		this.childMenuBackElement = null;
		this.path = null;
		this.text = null;
		this.url = null;
		this.tooltip = null;
		this.hasChildren = false;
		this.cssClass = null;
		this.iconCssClass = null;
		this.level = 0;

		this.init(extendWith);
	};

	menuItem.prototype = {
		init: function(extendWith) {
			if (extendWith && typeof extendWith === "object")
				$.extend(this, extendWith);
			if (this.path)
				this.level = this.path.split("/").length - 1;
			if (!this.url)
				this.url = "#";
			this.children = new menuItemCollection(this);
		}
	};

	function menuItemCollection(ownerItem) {
		context.collectionBase.call(this);
		this.objType = "menuitemcollection";
		this.ownerItem = ownerItem;
		this.itemObjType = "menuitem";

		this.getNewItem = function(extendWith) {
			return new menuItem(this.ownerItem, extendWith);
		};
	};

	$.extend(menuItemCollection.prototype, context.collectionBase.prototype);

	function getMainMenu() {
		return _mainMenu;
	};

	return {
		mainMenu: mainMenu,
		getMainMenu: getMainMenu
	};
});

jQuery.fn.mascusMainMenu = function(parameters) {
	return new mascus.navigation.mainMenu(this, parameters);
};
mascus.extend("navigation", function (context) {
    var _userMenu = null;

    function userMenu(containerElement, parameters) {
        context.extensionBase.call(this, containerElement, parameters, {
            ajaxUrl: "/ajax/MainMenuHandler.aspx",
            loginContainerId: "user-menu-login",
            languageContainerId: "user-menu-language",
            currencyContainerId: "user-menu-currency"
        });

        this.init();
        _userMenu = this;
    };

    userMenu.prototype = {
        init: function () {
            var self = this;

            this.container.find(".user-menu-toggle").click(function (e) {
                var url = $(this).data("url");
                if (url)
                    document.location = url;
                else
                    self.toggleChildMenu($(this).parent());
            });

            this.container.find(".back").click(function (e) {
                self.closeChildMenu($(this).parent());
            });

            var loginMenu = $("#user-menu-login");
            loginMenu.find(".submit .black-link").click(function (e) {
                e.preventDefault();
                self.closeChildMenu(loginMenu);
            });
            if (context.layout.isSmallScreen && loginMenu.hasClass("open")) {
                loginMenu.removeClass("open");
                this.toggleChildMenu(loginMenu);
                this.container.addClass("open");
                $(".small-screen-navigation .toggle-settings").addClass("open");
            }
            loginMenu.find(".forgot-password").click(function (e) {
                e.preventDefault();
                self.closeChildMenu(loginMenu);
                self.openForgotPasswordForm();
            });

            $(document).on('click', '#main-layout .forgot-password, #bidboxForgotPass', function (e) {
                e.preventDefault();
                self.openForgotPasswordForm();
            });

            this.container.find(".select-language").change(function (e) {
                var code = $(this).val();
                if (code.toLowerCase() !== context.language)
                    document.location = context.localizer.getLanguageSwitchUrl(code);
                else
                    self.close();
            });

            this.container.find(".select-currency").change(function (e) {
                var code = $(this).val();
                if (code !== context.currency)
                    document.location = context.localizer.getCurrencySwitchUrl(code);
                else
                    self.close();
            });

            $("#footer .select-domain").click(function (e) {
                var elem = $(this);
                var popupId = "footer-domains-popup";
                var popup = context.layout.openModalPopup(popupId);
                if (popup == null) {
                    context.layout.showLoadingIcon(elem);
                    context.localizer.getDomains(function (data) {
                        var html = self.getItemListHtml("domain", data, 4);
                        context.layout.hideLoadingIcon(elem);
                        context.layout.openModalPopup(popupId, "", html);
                    });
                }
            });

            $("a.head-quarters").click(function (e) {
                e.preventDefault();
                self.openHeadQuartersForm();
            });
        },

        toggle: function () {
            if (context.layout.isSmallScreen) {
                if (this.container.hasClass("open")) {
                    this.close();
                }
                else {
                    this.close();
                    this.open();
                }
            }
        },

        open: function () {
            if (context.layout.isSmallScreen) {
                this.container.addClass("open");
            }
        },

        close: function () {
            if (context.layout.isSmallScreen) {
                this.container.removeClass("open");
                this.container.find(".open").removeClass("open");
                this.container.find(".hidden").removeClass("hidden");
                this.container.find(".menu-title").removeClass("menu-title");
            }
        },

        toggleChildMenu: function (elem) {
            var parent = elem.parent();
            if (elem.hasClass("open")) {
                if (!context.layout.isSmallScreen)
                    this.closeChildMenu(elem);
            }
            else
                this.openChildMenu(elem);
        },

        openChildMenu: function (elem) {
            var self = this;

            elem.addClass("open");
            elem.siblings().removeClass("open");
            if (context.layout.isSmallScreen) {
                elem.children(".user-menu-toggle").addClass("menu-title");
                elem.siblings().addClass("hidden");
            }
            else {
                if (elem.attr("id") === this.parameters.languageContainerId) {
                    if (elem.find(".item-list").children().length === 0) {
                        context.layout.showLoadingIcon(elem.find(".flyout-box"));
                        context.localizer.getLanguages(function (data) {
                            var html = self.getItemListHtml("language", data, 3);
                            elem.find(".item-list").html(html);
                            context.layout.hideLoadingIcon(elem.find(".flyout-box"));
                        });
                    }
                }
                else if (elem.attr("id") === this.parameters.currencyContainerId) {
                    if (elem.find(".item-list").children().length === 0) {
                        context.layout.showLoadingIcon(elem.find(".flyout-box"));
                        context.localizer.getCurrencies(function (data) {
                            var currencyColumns = 6;
                            if (window.location.hostname.indexOf('mascus.ru') >= 0)
                                currencyColumns = 2;
                            var html = self.getItemListHtml("currency", data, currencyColumns);
                            elem.find(".item-list").html(html);
                            context.layout.hideLoadingIcon(elem.find(".flyout-box"));
                        });
                    }
                }
            }
        },

        closeChildMenu: function (elem) {
            elem.children(".user-menu-toggle").removeClass("menu-title");
            elem.removeClass("open");
            elem.siblings().removeClass("hidden");
        },

        getItemListHtml: function (listType, data, columns, recursiveCall) {
            var html = "";

            if (listType === "domain" && !recursiveCall) {
                html += "<div class=\"color-black-links no-dec\">";
                for (var i = 0; i < data.length; i++) {
                    html += "<div class=\"flo-wrap mar-b\">";
                    html += "<div class=\"strong mar-b-sm\">" + data[i].groupText + "</div>";
                    html += "<div class=\"col-row\">" + this.getItemListHtml("domain", data[i].children, columns, true) + "</div>";
                    html += "</div>";
                }
                html += "</div>";
                return html;
            }

            var itemsPerColumn = Math.ceil(data.length / columns);
            var columnClass = "col-md-" + (12 / columns) + " pad-c-after-sm";
            var columnItemCounter = 0;

            for (var i = 0; i < data.length; i++) {
                columnItemCounter++;

                var url = "#";
                var selected = false;
                if (listType === "language") {
                    url = context.localizer.getLanguageSwitchUrl(data[i].value);
                    selected = (context.language == data[i].value.toLowerCase());
                }
                else if (listType === "currency") {
                    url = context.localizer.getCurrencySwitchUrl(data[i].value);
                    selected = (context.currency == data[i].value);
                }
                else if (listType === "domain")
                    url = "http://" + data[i].value;

                if (columnItemCounter === 1)
                    html += "<ul class=\"" + columnClass + "\">";
                html += "<li><a href=\"" + url + "\"";
                if (data[i].tooltip)
                    html += " title=\"" + data[i].tooltip + "\"";
                else if (listType === "domain")
                    html += " title=\"" + data[i].value + "\"";
                if (selected)
                    html += " class=\"strong color-highlight\"";
                html += ">";

                if (listType === "language")
                    html += "<span class=\"flag " + listType + "-" + data[i].value.toLowerCase() + "\"></span> ";
                else if (listType === "domain")
                    html += "<span class=\"flag country-" + data[i].countryCode.toLowerCase() + "\"></span> ";

                if (data[i].text)
                    html += data[i].text;
                else
                    html += data[i].value;
                html += "</a></li>";
                if (columnItemCounter === itemsPerColumn) {
                    html += "</ul>";
                    columnItemCounter = 0;
                }
            }
            if (columnItemCounter > 0 && columnItemCounter < itemsPerColumn)
                html += "</ul>";

            return html;
        },

        openForgotPasswordForm: function () {
            var self = this;

            var popIdentifier = new Date().getTime();
            var popupId = ("forgot-password-form-" + popIdentifier);
            var popup = context.layout.openModalPopup(popupId);
            if (popup == null) {
                var url = this.parameters.ajaxUrl + "?action=getforgotpasswordform" + "&tmp=" + new Date().getTime();

                context.ajax(url, function (data) {
                    //console.log(popIdentifier);
                    data.contentHtml = data.contentHtml.replace(/[0-9]/g, '');

                    data.contentHtml = data.contentHtml.replace(/user-email-div/gi, "user-email-div" + popIdentifier).replace(/field-alert-arrow/gi, "field-alert-arrow" + popIdentifier).
                    replace(/user-message-alert/gi, "user-message-alert" + popIdentifier);
                    if (data.contentHtml.indexOf("forgot-password-form-") > -1)
                        data.contentHtml = data.contentHtml.replace("if(validateEmail($('#forgot-password-form-", "if(validateEmail($('#forgot-password-form-" + popIdentifier);
                    else
                     data.contentHtml = data.contentHtml.replace("if(validateEmail($('#user-email').val()))", "if(validateEmail($('#forgot-password-form-" + popIdentifier + " #user-email').val()))");
                    popup = context.layout.openModalPopup(popupId, data.titleHtml, data.contentHtml, data.footerHtml);
                    //console.log(data.contentHtml);

                    popup.footer.find(".primary-button").click(function (e) {
                        self.sendForgotPasswordForm(popup);
                    });
                    popup.footer.find(".black-link").click(function (e) {
                        popup.content.find(".password-info-text").remove();
                        popup.close();
                    });
                });
            }
        },

        sendForgotPasswordForm: function (popup) {
            var inputs = popup.content.find("input");
            var query = inputs.serialize();
            //popup.footer.find(".primary-button").click(function (e) {
            popup.content.find(".password-info-text").remove();
            //popup.close();  // SSh: this closes the popup, and it should not - it is a send button
            //});

            context.ajax(this.parameters.ajaxUrl + "?action=sendforgotpasswordform&" + query, function (data) {
                popup.content.append(data.contentHtml);
                if (data.contentHtml.indexOf("password-info-text success") > -1) {
                    $(".password-info-text.success").siblings("div").remove();
                    $(".password-info-text.success").parent(".modal-content").siblings(".modal-footer").find(".primary-button").remove();
                    $(".password-info-text.success").parent(".modal-content").siblings(".modal-footer").find(".black-link").addClass("primary-button").removeClass("black-link").html("Close window");
                }
            });
        },

        openHeadQuartersForm: function () {
            var self = this;

            var popupId = "head-quarters-form";
            var popup = context.layout.openModalPopup(popupId);
            if (popup == null) {
                var url = this.parameters.ajaxUrl + "?action=getheadquartersform";

                context.ajax(url, function (data) {
                    popup = context.layout.openModalPopup(popupId, data.titleHtml, data.contentHtml, data.footerHtml);

                    popup.content.find(".head-quarters-link").click(function (e) {
                        self.refreshHeadQuartersForm(popup, this.name);
                    });
                    popup.footer.find(".black-link").click(function (e) {
                        popup.close();
                    });
                });
            }
        },

        refreshHeadQuartersForm: function (popup, country_code) {
            var inputs = popup.content.find("input");
            var query = inputs.serialize();
            var self = this;

            context.ajax(this.parameters.ajaxUrl + "?action=refreshheadquartersform&country_code=" + country_code + "&" + query, function (data) {
                popup.setTitle(data.titleHtml);
                popup.setContent(data.contentHtml);
                popup.setFooter(data.footerHtml);

                popup.content.find(".head-quarters-link").click(function (e) {
                    self.refreshHeadQuartersForm(popup, this.name);
                });

                popup.footer.find(".primary-button").click(function (e) {
                    popup.close();
                });
            });
        }


    }

    function getUserMenu() {
        return _userMenu;
    };

    return {
        userMenu: userMenu,
        getUserMenu: getUserMenu
    }
});

jQuery.fn.mascusUserMenu = function(parameters) {
	return new mascus.navigation.userMenu(this, parameters);
};
mascus.extend("search", function(context) {
	var forms = [];
	var formType = context.forms.formType;
	var fieldType = context.forms.fieldType;
	var searchType = {
		ads: 1,
		companies: 2,
		parts: 8,
		specs: 16
	};

	function form(containerElement, parameters) {
		context.forms.form.call(this, containerElement, parameters, {
			formType: formType.advanced,
			searchType: searchType.ads,
			id: null,
			ajaxUrl: "/ajax/SearchHandler.aspx",
			initialQuery: null,
			fieldContainerSelector: "ul.input-list",
			facetContainerSelector: "ul.facet-list",
			saveSearchFormSelector: "#left-save-search-form",
			fieldNamePrefix: "sf_",
			fieldContainerSuffix: "_container",
			popupContainerSuffix: "_popup",
			disabledCssClass: "disabled",
			showCounts: true,
			addSubmitButton: true,
			addResetButton: true,
			checkBoxPopupColumns: 4,
			fixedFields: [],
			extraFields: []
		});

		this.searchType = this.parameters.searchType ? this.parameters.searchType : searchType.ads;
		if (!this.id)
			this.id = "search-form-" + forms.length;
		this.fieldContainer = this.container.find(this.parameters.fieldContainerSelector).not(this.parameters.saveSearchFormSelector + " " + this.parameters.fieldContainerSelector);
		this.facetContainer = this.container.find(this.parameters.facetContainerSelector);
		this.hasFields = this.fieldContainer.children().length !== 0;
		this.hasFacets = this.facetContainer.children().length !== 0;
		this.fixedFields = new formFieldCollection(this);
		this.extraFields = new formFieldCollection(this);

		this.init(parameters);
		forms.push(this);
	};

	$.extend(form.prototype, context.forms.form.prototype, {
		init: function(parameters) {
		    var thisForm = this

			//KF: kommentoi
			if (this.hasFacets)
		    	this.bindFacetEvents();

		    if (typeof parameters !== "undefined") {
				this.fixedFields.init(parameters.fixedFields);
				this.extraFields.init(parameters.extraFields);
			}

			if (this.fixedFields.items.length !== 0 || this.extraFields.items.length !== 0) {
				this.setDependencies();
				this.renderFields();
			}
			else if (!this.hasFacets)
				this.getFormData();
			//KF: ^ else if pois
			//else
			//	this.getFormData();

			//saved searches click listener, added by TT
			this.container.find("#left-search-form_savedsearches").click(function (e) {
			    thisForm.handleSavedSearchClick($(this));
			});

			// E1 save search
			if (context.isE1) {
				var saveSearchForm = this.container.find(this.parameters.saveSearchFormSelector)
				if (saveSearchForm.length !== 0) {
					var titleInput = saveSearchForm.find("input[name='searchtitle']");
					titleInput.val(titleInput.data("tip"));
					titleInput.focus(function(e) {
						if (titleInput.val() === titleInput.data("tip")) {
							titleInput.val("");
						}
					});
					titleInput.keydown(function(e) {
						if (e.which === 13) {
							e.preventDefault();
						}
					});
					titleInput.keyup(function(e) {
						var val = $.trim(titleInput.val());
						if (val.length > 0)
							saveSearchForm.find(".primary-button").removeClass(thisForm.parameters.disabledCssClass);
						else
							saveSearchForm.find(".primary-button").addClass(thisForm.parameters.disabledCssClass);
					});
					saveSearchForm.find(".primary-button").click(function(e) {
						e.preventDefault();
						if (!$(this).hasClass("disabled"))
							thisForm.saveE1Search();
						else {
							ShowDialogBox("", titleInput.data("tip"), context.localizer.translate("b_ok"), "information", "");
							titleInput[0].focus();
						}
					});
				}
			}

		    //Alert email link to edit searches
			if (location.search.indexOf("&editsearch=") > -1) {
			    var searchid = getQueryStringParameterByName("editsearch", location.search);
			    if (searchid.length == 38) {
			        var self = this;

			        var popupId = "edit-searches-form";
			        var popup = context.layout.openModalPopup(popupId);
			        if (popup == null) {
			            var url = self.parameters.ajaxUrl + "?action=geteditsavedsearches&searchid=" + searchid + "&ise1=" + context.isE1;
			            context.ajax(url, function (data) {
			                popup = context.layout.openModalPopup(popupId, data.headerHtml, data.contentHtml, data.footerHtml);
			                popup.footer.find(".submit-button").unbind('click').click(function (e) {
			                    self.saveAllSearches(popup);
			                });
			                popup.footer.find(".cancel-button").click(function (e) {
			                    popup.close();
			                });
			            });
			        }
			    }
			}

			if (this.formType !== formType.quick) {
				this.container.find(".close-button").first().click(function(e) {
					e.preventDefault();
					context.layout.toggleSearchForm();
					$("#header .toggle-search").removeClass("open");
				});

				if (this.hasFacets) {
					// Small screen "Filter" button above search results
					$("#filter-search-button").click(function(e) {
						e.preventDefault();
						if (!context.layout.isSearchVisible) {
							thisForm.fieldContainer.hide();
							thisForm.facetContainer.show();
							thisForm.container.find(".toggle-mode").html(thisForm.container.find(".toggle-mode").data("text-advanced"));
							context.layout.toggleSearchForm();
							$("#header .toggle-search").addClass("open");
						}
						else {
							context.layout.toggleSearchForm();
							$("#header .toggle-search").removeClass("open");
						}
					});

					// Small screen "Search" button in the top bar
					$("#header .toggle-search").click(function(e) {
						if (thisForm.hasFields) {
							if (context.isE1) {
								thisForm.fieldContainer.hide();
								thisForm.facetContainer.show();
								thisForm.container.find(".toggle-mode").html(thisForm.container.find(".toggle-mode").data("text-advanced"));
							}
							else {
								thisForm.facetContainer.hide();
								thisForm.fieldContainer.show();
								thisForm.container.find(".toggle-mode").html(thisForm.container.find(".toggle-mode").data("text-faceted"));
							}
						}
						else {
							thisForm.getFormData(function () {
								if (context.isE1) {
									thisForm.fieldContainer.hide();
									thisForm.facetContainer.show();
									thisForm.container.find(".toggle-mode").html(thisForm.container.find(".toggle-mode").data("text-advanced"));
								}
								else {
									thisForm.facetContainer.hide();
									thisForm.fieldContainer.show();
									thisForm.container.find(".toggle-mode").html(thisForm.container.find(".toggle-mode").data("text-faceted"));
								}
							});
						}
					});
				}
				else {
					// Open the advanced search form if there are no facets
					$("#filter-search-button").click(function(e) {
						context.layout.toggleSearchForm();
						$("#header .toggle-search").toggleClass("open");
					});
				}
			}
		},

		reset: function() {
			this.parameters.fixedFields = [];
			this.parameters.extraFields = [];
			this.parameters.initialQuery = null;
			this.fieldContainer.find("input:text,select").val("");
			this.fieldContainer.find("input:checkbox,input:radio").prop("checked", false);
			for (var i = 0; i < this.fixedFields.items.length; i++) {
				this.resetField(this.fixedFields.items[i]);
			}
			for (var i = 0; i < this.extraFields.items.length; i++) {
				this.resetField(this.extraFields.items[i]);
			}
		},

		submit: function(query) {
			var thisForm = this;

			if (!query)
				query = thisForm.toQueryString();
			//alert("query: " + query);
			//return;
			if (thisForm.searchType==2 || query) {
				thisForm.getData("getredirecturl", query, function(data) {
					//alert("redirect: " + data.url);
					//return;
					if (data && data.url)
						document.location = data.url;
				});
			}
		},

		getData: function(action, query, callback, allowLocalCache) {
			var thisForm = this;

			if (!query)
				query = "";
			var url = this.parameters.ajaxUrl + "?action=" + action;
			if (query.indexOf("searchtype=") == -1)
				url += "&searchtype=" + thisForm.searchType;
			if (query.indexOf("formtype=") == -1)
				url += "&formtype=" + thisForm.formType;
			url += "&l=" + context.language;
			if (query)
				url += "&" + query;
			//alert(url);
			context.ajax(url, callback, null, null, true, allowLocalCache);
		},

		getFormData: function(finalizeCallback) {
			var thisForm = this;

			this.getData("getform", this.parameters.initialQuery, function(data) {
				if (data.type)
					thisForm.formType = data.type;
				if (data.searchType)
					thisForm.searchType = data.searchType;
				thisForm.fixedFields.init(data.fixedFields);
				thisForm.extraFields.init(data.extraFields);
				thisForm.setDependencies();
				thisForm.renderFields();
				thisForm.hasFields = true;

				if ($.isFunction(finalizeCallback))
					finalizeCallback(thisForm);
			}, false);
		},

		getFieldData: function(field, finalizeCallback, triggerElement) {
			var thisForm = this;

			if (!field.loading && !field.optionsLoaded) {
				this.onFieldLoadBegin(field, triggerElement);
				var query = this.toFieldQueryString(field);
				field.lastOptionQuery = query;
				if (query.length !== 0)
					query = "&" + query;
				query = "fieldname=" + field.name + query;
				this.getData("getfield", query, function(data) {
					if (typeof data.optionsHeader !== "undefined")
						field.optionsHeader = data.optionsHeader;
					field.options.init(data.options);
					field.optionsLoaded = true;
					thisForm.checkLoadedOptions(field);
					thisForm.renderOptions(field);
					thisForm.renderSelectedValues(field);
					thisForm.onFieldLoadEnd(field, triggerElement);

					if ($.isFunction(finalizeCallback))
						finalizeCallback(field);
				});
			}
		},

        getFacetData: function(fieldName, finalizeCallback) {
            var query = this.parameters.initialQuery;
			if (!query)
				query = "";
			else
				query = "&" + query;
			query = "formtype=" + formType.faceted + "&fieldname=" + fieldName + query;
			this.getData("getfield", query, function(data) {
				var field = new formField(null, null, data);
				field.optionColStartHtml = "<li><ul>";
				field.optionColEndHtml = "</ul></li>";
				if ($.isFunction(finalizeCallback))
					finalizeCallback(field);
			});
		},

		getFieldHtml: function(field) {
			var html = "";
			var elemId = this.id + "_" + this.parameters.fieldNamePrefix + field.name;
			var value = "";
			var emptyText = "";
			var tooltip = "";

			if (field.value)
				value = field.value;
			if (field.emptyOption && field.emptyOption.text)
				emptyText = field.emptyOption.text;

			if (field.tooltip)
				tooltip = field.tooltip;

			html += "<li id=\"" + elemId + this.parameters.fieldContainerSuffix + "\" class=\"search-field";
			if (!field.label)
				html += " no-label";
			if (field.type === fieldType.range)
				html += " range-select flo-wrap";
			else if (field.type === fieldType.hidden)
				html += " hidden";
			html += "\">";

			if (field.label)
				//html += "<label data-sf-container-for=\"label\" for=\"" + elemId + "\">" + field.label + "</label>";
				html += "<label data-sf-container-for=\"label\">" + field.label + "</label>";

			if (field.type === fieldType.textBox) {
			    html += "<input data1-sf-container-for=\"selections\" type=\"text\" value=\"" + context.attrEncode(value ? value : tooltip) + "\" id=\"" + elemId + "\" onkeypress=\"if (event.keyCode==13){ console.log(); submit(this.value);return false;}\" />";
			}
			else if (field.type === fieldType.singleSelectDropDown) {
				html += "<div class=\"select-box\">";
				html += "<select data-sf-container-for=\"options\" id=\"" + elemId + "\"></select>";
				html += "<span data-sf-container-for=\"selections\" class=\"select-text\"></span><i class=\"select-arrow fa fa-angle-down\">";
				html += "</div>";
			}
			else if (field.type === fieldType.multiSelectDropDown) {
				html += "<div class=\"fly-select-wrap pos-rel\">";
				html += "<div class=\"select-box check-select\">";
				html += "<span class=\"select-text\">" + emptyText + "</span><i class=\"select-arrow fa fa-angle-down\"></i>";
				html += "</div>";
				html += "<div id=\"" + elemId + "_popup\" class=\"fly-select check-list\" style=\"display:none;\">";
				html += "<ul data-sf-container-for=\"options\"></ul>";
				html += "<div class=\"bottom-links submit\"><button type=\"button\" class=\"primary-button\">" + context.localizer.translate("b_select") + "</button><a class=\"orange-link\" href=\"#\">" + context.localizer.translate("b_cancel") + "</a></div>";
				html += "</div>";
				html += "</div>";
				html += "<ul data-sf-container-for=\"selections\" class=\"selected-values\" style=\"display:none;\"></ul>";

				field.optionSelector = "input:checkbox"
			}
			else if (field.type === fieldType.checkBoxList || field.type === fieldType.radioButtonList || field.type === fieldType.boolean) {
				html += "<ul data-sf-container-for=\"options\" class=\"sub-label-wrap\"></ul>";
			}
			else if (field.type === fieldType.checkBoxPopup || field.type === fieldType.location) {
				var arrowIcon = "eye";
				if (field.type === fieldType.location || field.name === "countrycode")
					arrowIcon = "globe";
				html += "<div class=\"select-box\">";
				html += "<span class=\"select-text\">" + emptyText + "</span><i class=\"select-arrow fa fa-" + arrowIcon + "\"></i>";
				html += "</div>";
				html += "<ul data-sf-container-for=\"selections\" class=\"selected-values\" style=\"display:none;\"></ul>";

				field.modalPopup = new context.layout.modalPopup(elemId + this.parameters.popupContainerSuffix);
				field.modalPopup.container.addClass("search-field-popup");
				if (field.type === fieldType.checkBoxPopup)
					field.modalPopup.setContent("<div class=\"check-list\"><ul data-sf-container-for=\"options\" class=\"multi-col-list four-col\"></ul></div>");
				else if (field.type === fieldType.location) {
					field.modalPopup.setContent("<div data-sf-container-for=\"options\" id=\"sf-location\"></div>");
				}
				field.modalPopup.setFooter("<div class=\"submit bottom-links\"><a class=\"primary-button\" href=\"#\">" + context.localizer.translate("b_select") + "</a><a class=\"black-link\" href=\"#\">" + context.localizer.translate("b_uncheck_all") + "</a></div>");

				field.optionSelector = "input:checkbox"
				if (field.type === fieldType.checkBoxPopup) {
					field.optionColStartHtml = "<li><ul>";
					field.optionColEndHtml = "</ul></li>";
				}
			}
			else if (field.type === fieldType.multiValueTextBox) {
				html += "<input type=\"text\" value=\"" + context.attrEncode(emptyText ? emptyText : tooltip) + "\" id=\"" + elemId + "\" />";
				html += "<ul data-sf-container-for=\"selections\" class=\"selected-values\" style=\"display:none;\"></ul>";
			}
			else if (field.type === fieldType.range) {
				var minValue = "";
				var maxValue = "";
				var range = (value ? value : emptyText).split('-');
				if (range.length == 2) {
					minValue = range[0];
					maxValue = range[1];
				}
				if (minValue === "0")
					minValue = "";
				if (maxValue === "0")
					maxValue = "";

				html += "<input data-sf-container-for=\"minvalue\" id=\"" + elemId + "_min\" type=\"text\" value=\"" + context.attrEncode(minValue) + "\" />";
				html += "<span class=\"sep\">&ndash;</span>";
				html += "<input data-sf-container-for=\"maxvalue\" id=\"" + elemId + "_max\" type=\"text\" value=\"" + context.attrEncode(maxValue) + "\" />";
			}
			else if (field.type === fieldType.readOnly) {
				html += "<ul data-sf-container-for=\"selections\" class=\"selected-values readonly\"></ul>";
			}
			else if (field.type === fieldType.hidden) {
				html += "<input data-sf-container-for=\"selections\" type=\"hidden\" value=\"" + context.attrEncode(value) + "\" id=\"" + elemId + "\" />";
			}

			html += "</li>";

			return html;
		},

		getOptionHtml: function(field, option, index) {
			var html = "";
			var value = option.value;
			var text = option.text;
			if (!text)
				text = option.value;
			var name = this.id + "_" + this.parameters.fieldNamePrefix + field.name;
			var id = name + "_" + index;
			var selected = option.selected || field.requestedOptions.contains(value);

			if (field.type === fieldType.singleSelectDropDown) {
				html += "<option value=\"" + context.attrEncode(value) + "\"";
				if (selected)
					html += " selected=\"selected\"";
				html += ">" + text + "</option>";
			}
			else if (field.type === fieldType.checkBoxList || field.type === fieldType.radioButtonList || field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.multiValueTextBox || field.type === fieldType.boolean) {
				var inputType = "checkbox";
				var nameAttr = "";
				if (field.type === fieldType.radioButtonList) {
					inputType = "radio";
					nameAttr = " name=\"" + name + "\"";
				}
				html += "<li><label for=\"" + id + "\" class=\"sub-label\">";
				html += "<input type=\"" + inputType + "\" id=\"" + id + "\"" + nameAttr + " value=\"" + context.attrEncode(value) + "\"";
				if (selected)
					html += " checked=\"checked\"";
				html += " /> <span>" + text + "</span>";
				html += this.getResultCountHtml(option.resultCount);
				html += "</label></li>";
			}

			return html;
		},

		getFacetPopupHtml: function(field) {
			var thisForm = this;
			var html = "";
			var itemsPerColumn = 0;
			var columnItemCounter = 0;

			itemsPerColumn = Math.ceil(field.options.items.length / this.parameters.checkBoxPopupColumns);

			html += "<div class=\"check-list\"><ul class=\"multi-col-list four-col\">";
			for (var i = 0; i < field.options.items.length; i++) {
				columnItemCounter++;

				if (columnItemCounter === 1)
					html += field.optionColStartHtml;

				var option = field.options.items[i];
				html += "<li><label class=\"sub-label\">";
				html += "<a href=\"" + (option.url ? option.url : "#") + "\">" + (option.text ? option.text : option.value) + "</a>" + this.getResultCountHtml(option.resultCount);
				html += "</label></li>";

				if (columnItemCounter === itemsPerColumn) {
					html += field.optionColEndHtml;
					columnItemCounter = 0;
				}
			}

			if (columnItemCounter > 0 && columnItemCounter < itemsPerColumn) {
				html += field.optionColEndHtml;
				columnItemCounter = 0;
			}
			html += "</ul></div>";

			return html;
		},

		getResultCountHtml: function(count) {
			var html = "";
			if (this.parameters.showCounts && count > 0)
				html = " <span class=\"no-wrap\" dir=\"ltr\">(" + context.localizer.formatDisplayNumber(count) + ")</span>";
			return html;
		},

		toFlatFieldArray: function(fieldNames, arr, field, recursiveCall) {
			var field;
			if (!arr)
				arr = [];

			if (!field) {
				for (var i = 0; i < this.fixedFields.items.length; i++) {
					this.toFlatFieldArray(fieldNames, arr, this.fixedFields.items[i], true);
				}
				for (var i = 0; i < this.extraFields.items.length; i++) {
					this.toFlatFieldArray(fieldNames, arr, this.extraFields.items[i], true);
				}
			}
			else {
				if (!fieldNames || $.inArray(field.name, fieldNames) !== -1 || (field.requestKey && $.inArray(field.requestKey, fieldNames) !== -1))
					arr.push(field);
				for (var i = 0; i < field.options.items.length; i++) {
					for (var j = 0; j < field.options.items[i].subfields.items.length; j++) {
						this.toFlatFieldArray(fieldNames, arr, field.options.items[i].subfields.items[j], true);
					}
				}
			}

			return arr;
		},

		toQuery: function(fieldArray) {
			var formQuery = {};
			var field;
			var fieldQuery;
			var str = "";

			if (!fieldArray)
				fieldArray = this.toFlatFieldArray();
			for (var i = 0; i < fieldArray.length; i++) {
				field = fieldArray[i];
				fieldQuery = field.toQuery();
				if (fieldQuery) {
					if (typeof formQuery[fieldQuery.key] === "undefined" || fieldQuery.priority > formQuery[fieldQuery.key].priority)
						formQuery[fieldQuery.key] = fieldQuery;
					else
						context.mergeArrays(formQuery[fieldQuery.key].values, fieldQuery.values);
				}
			}

			return formQuery;
		},

		toQueryString: function(formQuery) {
			var str = "";
			var key = "";
			var value = "";
			var fieldQuery;

			if (typeof formQuery === "undefined")
				formQuery = this.toQuery();

			for (var prop in formQuery) {
				if (formQuery.hasOwnProperty(prop)) {
					fieldQuery = formQuery[prop];
					key = fieldQuery.key;
					value = "";
					for (var i = 0; i < fieldQuery.values.length; i++) {
						if (fieldQuery.values[i]) {
							if (value.length > 0)
								value += ",";
							value += encodeURIComponent(fieldQuery.values[i]);
						}
					}

					if (value) {
						if (str.length !== 0)
							str += "&";
						if (key !== "q" && key !== "searchtype")
							str += this.parameters.fieldNamePrefix;
						str += key + "=" + value;
					}
				}
			}

			return str;
		},

		toFieldQuery: function(field) {
			var field;
			var fieldNames = [];

			context.mergeArrays(fieldNames, field.dependsOnFields);
			context.mergeArrays(fieldNames, field.filtersByFields);

			var parentOption = field.parentOption;
			while (parentOption != null) {
				if (parentOption.field != null) {
					if ($.inArray(parentOption.field.name, fieldNames) < 0)
						fieldNames.push(parentOption.field.name);

					context.mergeArrays(fieldNames, parentOption.field.dependsOnFields);
					context.mergeArrays(fieldNames, parentOption.field.filtersByFields);

					parentOption = parentOption.field.parentOption;
				}
				else
					parentOption = null;
			}

			context.trace("toFieldQuery().fieldNames: " + fieldNames);
			var fieldArray = this.toFlatFieldArray(fieldNames);
			var fieldQuery = this.toQuery(fieldArray);

			return fieldQuery;
		},

		toFieldQueryString: function(field) {
			var fieldQuery = this.toFieldQuery(field);
			return this.toQueryString(fieldQuery);
		},

		setDependencies: function(field) {
			if (typeof field === "undefined") {
				for (var i = 0; i < this.fixedFields.items.length; i++) {
					this.setDependencies(this.fixedFields.items[i]);
				}
				for (var i = 0; i < this.extraFields.items.length; i++) {
					this.setDependencies(this.extraFields.items[i]);
				}
			}
			else {
				for (var j = 0; j < this.fixedFields.items.length; j++) {
					var field2 = this.fixedFields.items[j];
					if (field2.name != field.name) {
						if (field.isDependentOn(field2)) {
							context.trace(field.name + " depends on " + field2.name);
							field2.dependentFields.add(field, true);
						}
						if (field.isFilteredBy(field2)) {
							context.trace(field.name + " filters by " + field2.name);
							field2.filterFields.add(field, true);
						}
						if (field.isPreloadedBy(field2)) {
							context.trace(field.name + " preloads by " + field2.name);
							field2.preloadFields.add(field, true);
						}
					}
				}
			}
		},

		setDataContainers: function(field) {
			var attrName = "data-sf-container-for";
			field.element.find("[" + attrName + "]").each(function() {
				var dataElem = $(this);
				field.dataElements[dataElem.attr(attrName)] = dataElem;
				dataElem.removeAttr(attrName);
			});
			if (field.modalPopup) {
				field.modalPopup.container.find("[" + attrName + "]").each(function() {
					var dataElem = $(this);
					field.dataElements[dataElem.attr(attrName)] = dataElem;
					dataElem.removeAttr(attrName);
				});
			}
		},

		renderFields: function(collection, isExtra) {
			var thisForm = this;
			var html = "";

			if (typeof collection === "undefined") {
				this.fieldContainer.empty();
				this.renderFields(this.fixedFields);
				if (this.extraFields.items.length !== 0) {
					var containerBackup = this.fieldContainer;
					html = "<li class=\"more-options\"><div><h3><a href=\"#\"><span>-</span>" + context.localizer.translate("search_more_header") + "</a></h3><ul></ul></div></li>";
					this.fieldContainer.append(html);
					var extraLi = this.fieldContainer.children().last();
					this.fieldContainer = extraLi.find("ul");
					this.renderFields(this.extraFields, true);
					this.fieldContainer = containerBackup;
					extraLi.find("a").click(function(e) {
						e.preventDefault();
						$(this).parent().next().toggle();
						var icon = $(this).children().first();
						icon.text(icon.text() === "-" ? "+" : "-");
					});
				}

				var checkedNames = [];
				for (var i = 0; i < this.fixedFields.items.length; i++) {
					this.refreshDependentFieldElements(this.fixedFields.items[i], false, checkedNames);
				}
				for (var i = 0; i < this.extraFields.items.length; i++) {
					this.refreshDependentFieldElements(this.extraFields.items[i], false, checkedNames);
				}

				if (this.parameters.addSubmitButton || this.parameters.addResetButton) {
					html = "<li class=\"submit\">";
					if (this.parameters.addSubmitButton) {
					    if (this.fieldContainer.context.id == "top-search-form") {
					        html += "<a href=\"#\" class=\"search-submit";
					    }
					    else {
					        html += "<a href=\"#\" class=\"primary-button search-submit";
					    }
					  /*  if (thisForm.formType === formType.quick)
					        html += " sm-hide";*/

					    html += "\"><i class=\"fa fa-search\"></i> " + context.localizer.translate("b_search") + "</a>";

					  /*  if (thisForm.formType === formType.quick)
					        html += "<a href=\"#\" class=\"secondary-button search-submit sm-show\"><i class=\"fa fa-search\"></i></a>";*/
					}
					if (this.parameters.addResetButton)
						html += "<a href=\"#\" class=\"black-link search-reset\">" + context.localizer.translate("b_empty_fields") + "</a>";
					html += "</li>";
					this.fieldContainer.append(html);
				}
				this.fieldContainer.find(".search-submit").click(function (e) {
				    e.preventDefault();

				    doSubmit = true;
				    if ($(this).parent("li.submit").length && $(this).parent("li.submit").siblings("#top-search-form_sf_q_container").length) {
				        if ($("#top-search-form_sf_q").val().length == 0 || ($("#top-search-form_sf_q").val() == $("#top-search-form_sf_q").attr("value")))
				            doSubmit = false;
				    }

				    if (doSubmit)
				        thisForm.submit();
				    
				});
				this.fieldContainer.find(".search-reset").click(function(e) {
					e.preventDefault();
					thisForm.reset();
				});
			}
			else {
				for (var i = 0; i < collection.items.length; i++) {
					var field = collection.items[i];
					var elem = $(this.getFieldHtml(field));
					if (i === 0)
						elem.addClass("first-field");
					if (i === collection.items.length - 1)
						elem.addClass("last-field");

					this.fieldContainer.append(elem);
					field.element = elem;

					this.setDataContainers(field);
					this.renderOptions(field);
					this.renderSelectedValues(field);
					this.bindFieldEvents(field);
				}
			}
		},

		renderOptions: function(field) {
			if (field.element == null)
				return;
			var thisForm = this;
			var container = field.dataElements["options"];
			if (container && container.length === 1) {
				container.empty();

				if (field.type === fieldType.location) {
					if (field.options.items.length !== 0) {
						var levels = ["continent", "countrycode", "region"];
						if (thisForm.searchType === searchType.companies)
							levels.push("city");
						var locationBrowser = new context.navigation.locationBrowser(container, {
							levels: levels,
							getDataHandler: function(level, type, parentCode, parentOption, parentElement, callback) {
								thisForm.browseLocations(field, level, type, parentCode, parentOption, parentElement, callback);
							}
						});
					}
				}
				else {
					var html = "";
					var itemsPerColumn = 0;
					var columnItemCounter = 0;

					if (field.modalPopup)
						field.modalPopup.setTitle(field.optionsHeader);

					if (field.type === fieldType.checkBoxPopup)
						itemsPerColumn = Math.ceil(field.options.items.length / this.parameters.checkBoxPopupColumns);

					if (field.emptyOption) {
						if (field.type === fieldType.singleSelectDropDown)
							html += this.getOptionHtml(field, field.emptyOption, -1);
					}

					for (var i = 0; i < field.options.items.length; i++) {
						columnItemCounter++;

						if (itemsPerColumn > 0 && columnItemCounter === 1 && field.optionColStartHtml)
							html += field.optionColStartHtml;

						var option = field.options.items[i];
						html += this.getOptionHtml(field, option, i);

						if (itemsPerColumn > 0 && columnItemCounter === itemsPerColumn) {
							if (field.optionColEndHtml)
								html += field.optionColEndHtml;
							columnItemCounter = 0;
						}
					}

					if (itemsPerColumn > 0 && columnItemCounter > 0 && columnItemCounter < itemsPerColumn) {
						if (field.optionColEndHtml)
							html += field.optionColEndHtml;
						columnItemCounter = 0;
					}

					if (html) {
						container.append(html);
						this.bindOptionEvents(field, container);
					}
				}
			}
		},

		renderSelectedValues: function(field) {
			if (field.element == null)
				return;
			var container = field.dataElements["selections"];
			if (container && container.length === 1) {
				var options = field.options.getSelected().concat(field.requestedOptions.getSelected());
				options.sort(field.options.sortFunc);
				var isEmptySelected = false;
				if (options.length === 0 && field.emptyOption != null) {
					options.push(field.emptyOption);
					isEmptySelected = true;
				}

				if (field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.multiValueTextBox || field.type === fieldType.location || field.type === fieldType.readOnly)
					container.empty();

				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					var text = option.longText ? option.longText : (option.text ? option.text : option.value);
					if (text != null) {
						if (field.type === fieldType.singleSelectDropDown) {
							container.text(text);
							break;
						}
						else if ((field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.multiValueTextBox || field.type === fieldType.location) && text && !isEmptySelected)
							container.append("<li data-sf-option-value=\"" + context.attrEncode(option.value) + "\">" + text + " <span class=\"clear-selection\"></span></li>");
						else if (field.type === fieldType.readOnly && text && !isEmptySelected)
							container.append("<li data-sf-option-value=\"" + context.attrEncode(option.value) + "\">" + text + "</li>");
					}
				}

				if (field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.multiValueTextBox || field.type === fieldType.location) {
					if (options.length === 0 || isEmptySelected)
						container.hide();
					else
						container.show();
				}
			}
		},

		bindFieldEvents: function(field) {
			var thisForm = this;

			field.element.find('a[href="#"]').click(function(e) {
				e.preventDefault();
			});

			if (field.type === fieldType.textBox) {
				var inputElem = field.element.find("input");
				inputElem.focus(function(e) {
					var val = $.trim(inputElem.val());
					if (field.tooltip && val === field.tooltip)
						inputElem.val("");
				});
				inputElem.change(function(e) {
					field.value = $.trim(inputElem.val());
					thisForm.onFieldChange(field, e);
				});
				if (field.name === "q") {
					inputElem.keydown(function(e) {
						if (e.which === 13) {
							e.preventDefault();
							inputElem.trigger("change");
							thisForm.submit();
						}
					});
				}
				if (field.name === "q") {
					var url = "/ajax/SearchAutocomplete.aspx?usexml=true&locator=" + (thisForm.searchType === searchType.companies ? "true" : "false")
					thisForm.addAutocomplete(field, inputElem, 2, url, function(e) {
						field.value = $.trim(inputElem.val());
						thisForm.onFieldChange(field, e);
					});
				}
			}
			else if (field.type === fieldType.singleSelectDropDown) {
				var selectElem = field.element.find("select");
				selectElem.mousedown(function(e) {
					if (!thisForm.isEnabled(field))
						e.preventDefault();
					else if (!field.optionsLoaded)
						thisForm.getFieldData(field, null, selectElem);
				});
				selectElem.click(function(e) {
					if (!thisForm.isEnabled(field))
						e.preventDefault();
					else if (!field.optionsLoaded)
						thisForm.getFieldData(field, null, selectElem);
				});
				selectElem.change(function(e) {
					var value = $(this).val();
					thisForm.onOptionSelect(field, value, e);
				});
			}
			else if (field.type === fieldType.multiSelectDropDown) {
				var divElem = field.element.find(".select-box");
				divElem.click(function(e) {
					if (!thisForm.isEnabled(field))
						e.preventDefault();
					else {
						field.element.siblings().find(".fly-select").hide();
						if (!field.optionsLoaded)
							thisForm.getFieldData(field, function() {
								divElem.trigger("click");
							}, divElem);
						else if (field.options.items.length > 0) {
							divElem.toggleClass("focus");
							divElem.siblings(".fly-select").toggle();
						}
					}
				});

				field.element.find(".bottom-links button").click(function(e) {
					var value = field.element.find("input:checkbox:checked").map(function() {
						return $(this).val();
					}).get();
					thisForm.onOptionSelect(field, value, e);
					field.element.find(".select-box").toggleClass("focus");
					field.element.find(".fly-select").toggle();
				});

				field.element.find(".bottom-links a").click(function(e) {
					field.element.find(".select-box").toggleClass("focus");
					field.element.find(".fly-select").toggle();
				});
			}
			else if (field.type === fieldType.checkBoxList || field.type === fieldType.radioButtonList || field.type === fieldType.boolean) {
				var parentElem = field.dataElements["options"];
				parentElem.on("change", "input", function(e) {
					var value = parentElem.find("input:checked").map(function() {
						return $(this).val();
					}).get();
					thisForm.onOptionSelect(field, value, e);
				});
			}
			else if (field.type === fieldType.checkBoxPopup || field.type === fieldType.location) {
				var divElem = field.element.find(".select-box");
				divElem.click(function(e) {
					if (!thisForm.isEnabled(field))
						e.preventDefault();
					else {
						if (!field.optionsLoaded)
							thisForm.getFieldData(field, function() {
								divElem.trigger("click");
							}, divElem);
						else if (field.options.items.length > 0)
							field.modalPopup.open();
					}
				});

				field.modalPopup.container.find(".close-button,.primary-button").click(function(e) {
					e.preventDefault();
					/*var fieldAndSubs = thisForm.toFlatFieldArray(null, null, field);
					context.trace("fieldAndSubs: " + fieldAndSubs.length);
					for (var i = 0; i < fieldAndSubs.length; i++) {
						if (fieldAndSubs[i].element) {
							var values = fieldAndSubs[i].dataElements["options"].find(fieldAndSubs[i].optionSelector + ":checked").map(function() {
								return $(this).val();
							}).get();
							context.trace(fieldAndSubs[i].name + ": " + values);
							thisForm.onOptionSelect(fieldAndSubs[i], values, e);
						}
					}*/
					var values = field.dataElements["options"].find(field.optionSelector + ":checked").map(function() {
						return $(this).val();
					}).get();
					//alert(field.name + ": " + values);
					thisForm.onOptionSelect(field, values, e);
					field.modalPopup.close();
				});

				field.modalPopup.footer.find(".black-link").click(function(e) {
					e.preventDefault();
					field.dataElements["options"].find("input:checkbox:checked").prop("checked", false);
				});
			}
			else if (field.type === fieldType.multiValueTextBox) {
				var inputElem = field.element.find("input");

				thisForm.addAutocomplete(field, inputElem, 0, function(request, response) {
					thisForm.defaultAutocompleteSourceHandler(field, inputElem, request, response);
				});

				inputElem.focus(function(e) {
					if (!thisForm.isEnabled(field)) {
						e.preventDefault();
						inputElem.blur();
					}
					else {
						var val = $.trim(inputElem.val());
						if (field.emptyOption && field.emptyOption.text && val == field.emptyOption.text)
							inputElem.val("");
						else if (field.tooltip && val == field.tooltip)
							inputElem.val("");
						inputElem.autocomplete("search");
					}
				});
			}
			else if (field.type === fieldType.range) {
				var minText = "";
				var maxText = "";

				if (field.emptyOption && field.emptyOption.text) {
					var range = field.emptyOption.text.split('-');
					if (range.length == 2) {
						minText = range[0];
						maxText = range[1];
					}
				}

				if (minText) {
					field.dataElements["minvalue"].focus(function(e) {
						var input = $(this);
						var val = $.trim(input.val());
						if (val == minText)
							input.val("");
					});
				}
				if (maxText) {
					field.dataElements["maxvalue"].focus(function(e) {
						var input = $(this);
						var val = $.trim(input.val());
						if (val == maxText)
							input.val("");
					});
				}
				field.dataElements["minvalue"].change(function(e) {
					field.value = context.localizer.parseNumber($(this).val()) + "-" + context.localizer.parseNumber(field.dataElements["maxvalue"].val());
					thisForm.onFieldChange(field, e);
				});
				field.dataElements["maxvalue"].change(function(e) {
					field.value = context.localizer.parseNumber(field.dataElements["minvalue"].val()) + "-" + context.localizer.parseNumber($(this).val());
					thisForm.onFieldChange(field, e);
				});
			}

			if (field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.multiValueTextBox || field.type === fieldType.location) {
				field.dataElements["selections"].on("click.mascusSearch.form.field.selections", "li", function(e) {
					var value = $(this).data("sf-option-value");
					thisForm.onOptionDeselect(field, value, e);
				});
			}
		},

		bindOptionEvents: function(field, container) {
		},

		bindFacetEvents: function() {
			var thisForm = this;

			this.container.find(".toggle-mode").click(function(e) {
				e.preventDefault();
				var elem = $(this);
				var text = elem.html();
				if (text === elem.data("text-advanced")) {
					if (thisForm.hasFields) {
						thisForm.facetContainer.hide();
						thisForm.fieldContainer.show();
						elem.html(elem.data("text-faceted"));
					}
					else {
						context.layout.showLoadingIcon(elem, null, "after");
						thisForm.getFormData(function() {
							context.layout.hideLoadingIcon(elem);
							thisForm.facetContainer.hide();
							thisForm.fieldContainer.show();
							elem.html(elem.data("text-faceted"));
						});
					}
				}
				else {
					thisForm.fieldContainer.hide();
					thisForm.facetContainer.show();
					elem.html(elem.data("text-advanced"));
				}
			});

			this.facetContainer.find(".facet-submit .primary-button").click(function(e) {
				e.preventDefault();
				thisForm.submitFacet($(this));
			});

			this.facetContainer.find(".show-more-facets").click(function(e) {
				e.preventDefault();
				thisForm.showMoreFacets($(this));
			});
		},

        submitFacet: function (triggerElement) {


            var query = "?"+this.parameters.initialQuery;
            var container, inputs, index, innercont, fieldName, key, minValue, maxValue, submitValue,minmax,subfieldname ;
            container = document.getElementsByClassName('search-facet');

            for (index = 0; index < container.length; ++index) {
                fieldName = container[index].dataset.facet;

                innercont = container[index].getElementsByTagName('input');

               
                if (fieldName.indexOf("_range") !== -1 && innercont.length === 2) {
                   
                    var notfound = 0;
                        for (var i = 0; i < innercont.length; i++) {
                            if (!innercont[i].value) innercont[i].value = 0

                            submitValue = innercont[i].value;
                            if (!query.includes(fieldName)) {
                                notfound=1
                                if (i === 0) minmax = "_min";
                                else minmax = "_max";
                                subfieldname = fieldName.substring(0, fieldName.indexOf("_range")) + minmax;
                                if (fieldName !== "q") {
                                    subfieldname = this.parameters.fieldNamePrefix + subfieldname;
                                }
                                //if (query && index==0)
                                //    query = "?" + query;
                                if (!query)
                                    query = "?";
                                query = context.addQueryParameter(query, subfieldname, submitValue);
                            }
                    }
                    if (notfound === 0) {
                        
                        var first = query.substring(0, query.indexOf(fieldName) + fieldName.length + 1);
                        var msecond = query.substring(query.indexOf(fieldName) + fieldName.length, query.length )
                        var second = "";
                        if (msecond.includes("&")) second = msecond.substring(msecond.indexOf("&"), msecond.length )
                        
                        query = first + innercont[0].value + "-" + innercont[1].value + second

                    }

                    
                    // minValue = innercont[0].value;
                    // maxValue = innercont[1].value;
                    //if (minValue !== 0 || maxValue !== 0) {
                    //    submitValue = minValue + "-" + maxValue;
                    //}
                    //else {
                    //    submitValue = ""; 
                    //}
                }
                else if (innercont.length === 1) {
                    submitValue = innercont[0].value;
                    if (fieldName !== "q") {
                        subfieldname = this.parameters.fieldNamePrefix + subfieldname;
                    }
                    query = context.addQueryParameter(query, fieldName, submitValue);
                }
            
                if (innercont.length != 0) {
               
              
                
                }
            }
          
			
			
			//alert(query);
            var valse = document.getElementsByClassName("sort-select custom-mobile-select")[0];

            var reqs = $(valse).children("option:selected").val();
            console.log(reqs);
            query = query.substr(1, query.length - 1)+ "&sortby="+reqs;
			this.submit(query);
			//}
		},

		showMoreFacets: function(triggerElement) {
			var thisForm = this;
			
			var fieldName = triggerElement.data("facet");
			var staticFacets = triggerElement.siblings("ul.more-facets");
			if (fieldName == "categorypath" || staticFacets.children().length <= 25) {
				staticFacets.slideDown("fast");
				triggerElement.hide();
			}
			else {
				var popupId = thisForm.id + "_facet_" + fieldName + thisForm.parameters.popupContainerSuffix;
				var popup = context.layout.openModalPopup(popupId);
				if (popup == null) {
					context.layout.showLoadingIcon(triggerElement, null, "after");
					thisForm.getFacetData(fieldName, function(field) {
						context.layout.hideLoadingIcon(triggerElement);
						var html = thisForm.getFacetPopupHtml(field);
						popup = context.layout.openModalPopup(popupId, field.optionsHeader, html);
						popup.container.addClass("search-field-popup search-facet-popup");
					});
				}
			}
		},

		addAutocomplete: function(field, inputElem, minTypedLength, handler, changeHandler) {
			var thisForm = this;
			var sourceHandler = null;
        
			if ($.isFunction(handler))
				sourceHandler = handler;
			else if (typeof handler === "string") {
				sourceHandler = function(request, response) {
				    var cacheKey = handler + "&term=" + request.term.toLowerCase();
					$.ajax({
						url: handler,
						dataType: "json",
						data: request,
						success: function(data) {
							response(data);
						}
					});
				};
			}

			if (!$.isFunction(changeHandler))
				changeHandler = function(e) {
					var val = inputElem.val();
					thisForm.onOptionSelect(field, val, e);
				};

			inputElem.autocomplete({
				minLength: minTypedLength,
				source: sourceHandler,
				change: changeHandler
			}).data("ui-autocomplete")._renderItem = function(ul, item) {
				return $("<li></li>")
				.data("item.autocomplete", item)
				.append("<a>" + item.label + "</a>")
				.appendTo(ul);
			};
		},

		defaultAutocompleteSourceHandler: function(field, inputElement, request, response) {
			var thisForm = this;

			if (!field.optionsLoaded) {
				if (!field.loading) {
					thisForm.getFieldData(field, function() {
						thisForm.defaultAutocompleteSourceHandler(field, inputElement, request, response);
					}, inputElement);
				}
			}
			if (!field.optionsLoaded || field.loading) {
				response([]);
				return;
			}

			var term = $.trim(request.term);
			var matches = null;

			var cacheKey = (field.lastOptionQuery + "^" + term).toLowerCase();
			for (var i = 0; i < field.autocompleteCache.length; i++) {
				if (field.autocompleteCache[i][0] === cacheKey) {
					matches = field.autocompleteCache[i][1];
					break;
				}
			}

			if (matches == null) {
				if (term) {
					var pattern = $.ui.autocomplete.escapeRegex(term);
					if (isNaN(term[0]))
						pattern = "(^|\\W|\\d)(" + pattern + ")";
					else
						pattern = "(^|\\D)(" + pattern + ")";
					var re = new RegExp(pattern, "gi");
					matches = field.options.filter(re, null, function(item, index) {
						var label = item.value.replace(re, "$1<span style=\"font-weight:bold;text-decoration:underline;\">$2</span>");
						label += thisForm.getResultCountHtml(item.resultCount);
						return { "label": label, "value": item.value };
					});
				}
				else {
					matches = $.map(field.options.items, function(item, index) {
						var label = item.value;
						label += thisForm.getResultCountHtml(item.resultCount);
						return { "label": label, "value": item.value };
					});
				}
				field.autocompleteCache.push([cacheKey, matches]);
			}

			response(matches);
		},

		onFieldLoadBegin: function(field, triggerElement) {
			context.trace("onFieldLoadBegin " + field.name);
			field.loading = true;
			context.layout.showLoadingIcon(triggerElement);
			this.refreshDependentFieldElements(field, true);
		},

		onFieldLoadEnd: function(field, triggerElement) {
			context.trace("onFieldLoadEnd " + field.name);
			field.loading = false;
			context.layout.hideLoadingIcon(triggerElement);
			this.refreshDependentFieldElements(field);
		},

		onOptionSelect: function(field, value, callerEvent) {
			if (field.type !== fieldType.multiValueTextBox)
				field.options.deselectAll();
			var wasSelected = field.options.select(value);
			var selectedOptions = field.options.getSelected();
			if (field.requestedOptions.items.length > 0) {
				for (var i = 0; i < selectedOptions.length; i++) {
					field.requestedOptions.remove(selectedOptions[i].value);
				}
			}
			if (field.type === fieldType.multiValueTextBox) {
				if (!wasSelected && typeof value === "string" && field.requestedOptions.find(value) == null) {
					value = $.trim(value);
					if (value) {
						var manualOption = field.requestedOptions.getNewItem();
						manualOption.value = value;
						manualOption.selected = true;
						field.requestedOptions.items.push(manualOption);
					}
				}
				field.element.find("input").val("");
			}
			this.refreshOptionElements(field, true);
			this.renderSelectedValues(field);
			this.onFieldChange(field, callerEvent);
		},

		onOptionDeselect: function(field, value, callerEvent) {
			field.options.deselect(value);
			field.requestedOptions.remove(value);
			this.refreshOptionElements(field, false);
			this.renderSelectedValues(field);
			this.onFieldChange(field, callerEvent);
		},

		resetField: function(field) {
			if (field.type === fieldType.readOnly || field.type === fieldType.hidden)
				return;

			field.value = null;
			field.options.deselectAll();
			field.requestedOptions.clear();
			this.refreshOptionElements(field, false);
			this.renderSelectedValues(field);
			this.onFieldChange(field);
		},

		checkLoadedOptions: function(field, optionsToOverride) {
			if (!optionsToOverride)
				optionsToOverride = field.requestedOptions;
			for (var i = optionsToOverride.items.length - 1; i >= 0; i--) {
				var otherOption = optionsToOverride.items[i];
				var loadedEntry = field.options.findWithIndex(otherOption.value);
				if (loadedEntry.index !== -1) {
					loadedEntry.item.selected = true;
					optionsToOverride.items.splice(i, 1);
				}
			}
		},

		refreshOptionElements: function(field, isAfterSelect) {
			if (field.type === fieldType.multiSelectDropDown || field.type === fieldType.checkBoxPopup || field.type === fieldType.location) {
				var selected = field.options.getSelectedValues();
				field.dataElements["options"].find(field.optionSelector).each(function() {
					var elem = $(this);
					elem.prop("checked", $.inArray(elem.val(), selected) >= 0);
				});
			}
		},

		refreshDependentFieldElements: function(field, forceDisable, checkedNames) {
			if (field.dependentFields.items.length === 0)
				return;
			if (!checkedNames)
				checkedNames = [];
			else if ($.inArray(field.name, checkedNames) >= 0)
				return;
			checkedNames.push(field.name);
			//context.trace("refreshDependentFieldElements " + field.name);

			var selectedOptions = field.options.getSelected().concat(field.requestedOptions.getSelected());
			for (var i = 0; i < selectedOptions.length; i++) {
				if (selectedOptions[i].disableDependentFields) {
					forceDisable = true;
					break;
				}
			}

			for (var i = 0; i < field.dependentFields.items.length; i++) {
				var dependentField = field.dependentFields.items[i];
				if (dependentField.element != null) {
					if (forceDisable || selectedOptions.length === 0)
						dependentField.element.addClass(this.parameters.disabledCssClass);
					else
						dependentField.element.removeClass(this.parameters.disabledCssClass);
				}
				this.refreshDependentFieldElements(dependentField, forceDisable, checkedNames);
			}
		},

		onFieldChange: function(field, callerEvent, recursiveCall, checkedNames) {
			if (!checkedNames)
				checkedNames = [];
			else if ($.inArray(field.name, checkedNames) > 0)
				return;
			checkedNames.push(field.name);
			//context.trace("!!! onFieldChange " + field.name);
			//var hasValues = (field.options.getSelected().length > 0 || field.requestedOptions.getSelected().length > 0);
			for (var i = 0; i < field.dependentFields.items.length; i++) {
				var dependentField = field.dependentFields.items[i];
				dependentField.loading = false;
				dependentField.lastOptionQuery = null;
				dependentField.optionsLoaded = false;
				dependentField.options.clear();
				this.renderOptions(dependentField);
				this.renderSelectedValues(dependentField);
				this.onFieldChange(dependentField, callerEvent, true, checkedNames);
			}
			for (var i = 0; i < field.filterFields.items.length; i++) {
				var filteredField = field.filterFields.items[i];
				var selectedOptions = filteredField.options.getSelected();
				for (var j = 0; j < selectedOptions.length; j++) {
					if (!filteredField.requestedOptions.contains(selectedOptions[j])) {
						filteredField.requestedOptions.add(selectedOptions[j]);
					}
				}
				filteredField.loading = false;
				filteredField.lastOptionQuery = null;
				filteredField.optionsLoaded = false;
				filteredField.options.clear();
				this.renderOptions(filteredField);
				this.renderSelectedValues(filteredField);
				this.onFieldChange(filteredField, callerEvent, true, checkedNames);
			}
			for (var i = 0; i < field.preloadFields.items.length; i++) {
				var preloadField = field.preloadFields.items[i];
				if (!field.dependentFields.contains(preloadField.name) && !field.filterFields.contains(preloadField.name)) {
					preloadField.loading = false;
					preloadField.lastOptionQuery = null;
					preloadField.optionsLoaded = false;
					preloadField.options.clear();
					this.renderOptions(preloadField);
					this.renderSelectedValues(preloadField);
					this.onFieldChange(preloadField, callerEvent, true, checkedNames);
				}
				this.getFieldData(preloadField, null, preloadField.dataElements["options"]);

			}
			if (!recursiveCall)
				this.refreshDependentFieldElements(field, false);
		},

		isEnabled: function(field) {
			var enabled = (!field.loading && !field.element.hasClass(this.parameters.disabledCssClass));
			//if (!enabled) alert(enabled);
			return enabled;
		},

		//handle click on saved searches
		handleSavedSearchClick: function (selectElem) {
		    if (selectElem.val() === "edit") {
		        var self = this;

		        var popupId = "edit-searches-form";
		        var popup = context.layout.openModalPopup(popupId);
		        selectElem.val("");
		        if (popup == null) {
		            var url = self.parameters.ajaxUrl + "?action=geteditsavedsearches&ise1=" + context.isE1;
		            context.layout.showLoadingIcon(selectElem);
		            context.ajax(url, function (data) {
		                context.layout.hideLoadingIcon(selectElem);
		                popup = context.layout.openModalPopup(popupId, data.headerHtml, data.contentHtml, data.footerHtml);
		                popup.footer.find(".submit-button").click(function (e) {
		                    context.layout.showLoadingIcon($("#editsearches_save"));
		                    self.saveAllSearches(popup);
                            
		                    context.layout.hideLoadingIcon($("#editsearches_save"));
		                });
		                popup.footer.find(".cancel-button").click(function (e) {
		                    popup.close();
		                });
		            });
		        }
		    }
		    else if (selectElem.val().length > 0) {
		        window.location.href = selectElem.val()
		    }
		    
		},

		saveAllSearches: function (popup) {
		    var inputs = popup.content.find("input,textarea,select");
		    var query = inputs.serialize();

		    var array = query.split("&");
		    var blnalert = false;
		    var blnacceptsave = true;
		    var email = "";
		    var strtemp = "";
		    var index;
		    for (index = 0; index < array.length; ++index) {
		        strtemp = array[index];
		        if (strtemp.indexOf("alert_activate=") > -1) {
		            if (strtemp.substring(58) == "on") {
		                blnalert = true;
		            }
		            else
		                blnalert = false;
		        }
		        if (strtemp.indexOf("useremail=") > -1 && blnalert == true) {
		            email = strtemp.substring(53);
		            if (validateEmail(decodeURIComponent(email)) == false) {
		                createFieldAlert(decodeURIComponent(strtemp.substring(0, 42)) + "_useremail_container", "error", context.localizer.translate("savesearch_email_notvalid"), decodeURIComponent(strtemp.substring(0, 42)) + "-useremail")
		                blnacceptsave = false;
		            }
		        }
		    }
		    if ($("#editsearches_save").hasClass("disabled")) {
		        blnacceptsave = false;
		    }
		    if (blnacceptsave) {
		        //alert("TODO: Save " + query);
		        $.post(this.parameters.ajaxUrl + "?action=saveeditsearches", query, function (data) {
		            //ShowDialogBox(context.localizer.translate("html_loc_pp3_info_link"), context.localizer.translate("pa_changes_saved"), 'Ok', 'information', '');
                    $("#editsearches_save").addClass("hidden");
                    $("#save-success").css('display', 'block');
		        });
		    }
		},

		saveE1Search: function() {
			var saveSearchForm = this.container.find(this.parameters.saveSearchFormSelector);
			if (saveSearchForm.length === 0)
				return;

			var inputs = saveSearchForm.find("input");
			//var inputs = saveSearchForm.find("input[name='searchtitle']");
			var query = inputs.serialize();

			$.post(this.parameters.ajaxUrl + "?action=savesearch", query, function(data) {
				ShowDialogBox("", context.localizer.translate("my_search_saved").replace("#searchtitle#", saveSearchForm.find("input[name='searchtitle']").val()), context.localizer.translate("b_ok"), "information", "reload");
			});
		},

		browseLocations: function(rootField, level, type, parentCode, parentOption, parentElement, callback) {
			var thisForm = this;

			if (level === 1)
				callback(rootField.options.items);
			else {
				var code = parentCode + "";
				if (code.indexOf("/") != -1) {
					var path = code.split("/");
					code = path[path.length - 1];
				}
				//alert(level + ", " + type + ", " + code);
				var params = ["fieldname=" + type]
				var baseQuery = this.toFieldQueryString(rootField);
				if (baseQuery)
					params.push(baseQuery);
				params.push(this.parameters.fieldNamePrefix + "location=" + parentOption.value);

				var query = params.join("&");
				//alert(query);
				//return;
				this.getData("getfield", query, function(data) {
					var childField = new formField(thisForm, parentOption, data)
					parentOption.subfields.add(childField);
					childField.element = parentElement;
					childField.requestKey = "location";
					//childField.requestPriority = parentOption.field.requestPriority + 1;
					for (var i = 0; i < childField.options.items.length; i++) {
						var option = childField.options.items[i];
						if (!option.text)
							option.text = option.value;
						if (type !== "countrycode")
							option.longText = option.text + ", " + (parentOption.longText ? parentOption.longText : parentOption.text);
						option.value = parentOption.value + "/" + option.value;
						//option.selected = rootField.requestedOptions.contains(option.value);
					}
					thisForm.checkLoadedOptions(childField, rootField.requestedOptions);
					callback(childField.options.items);
				});
			}
		}
	});

	function formField(ownerForm, ownerOption, extendWith) {
		context.forms.formField.call(this, ownerForm, ownerOption);

		this.requestPriority = 0;
		this.requestedOptions = null;

		this.init(extendWith);
	};

	$.extend(formField.prototype, context.forms.formField.prototype, {
		init: function(extendWith) {
			var optionArray = null;
			var userOptionArray = null;
			var col = null;

			this.dependentFields = new formFieldCollection(this.form);
			this.filterFields = new formFieldCollection(this.form);
			this.preloadFields = new formFieldCollection(this.form);

			if (extendWith && typeof extendWith === "object") {
				if (typeof extendWith.options !== "undefined") {
					if ($.isArray(extendWith.options))
						optionArray = extendWith.options.slice(0);
					delete extendWith.options;
				}
				if (typeof extendWith.requestedOptions !== "undefined") {
					if ($.isArray(extendWith.requestedOptions))
						userOptionArray = extendWith.requestedOptions.slice(0);
					delete extendWith.requestedOptions;
				}
				$.extend(this, extendWith);
			}

			col = new formFieldOptionCollection(this);
			if (optionArray)
				col.init(optionArray);
			this.options = col;

			col = new formFieldOptionCollection(this);
			if (userOptionArray)
				col.init(userOptionArray);
			this.requestedOptions = col;

			if (this.type === fieldType.location)
				this.canHaveSubfields = true;
		},

		toQuery: function() {
			var key = this.requestKey ? this.requestKey : this.name;
			var values = this.options.getSelectedValues();
			context.mergeArrays(values, this.requestedOptions.getSelectedValues());
			if (this.value)
				values.push(this.value);
			if (this.type === fieldType.boolean && values.length === 0)
				values = ["0"];

			var query = null;

			if (key && values.length !== 0)
				query = {
					key: key,
					values: values,
					priority: this.requestPriority
				};

			return query;
		},
	});

	function formFieldOption(ownerField, extendWith) {
		context.forms.formFieldOption.call(this, ownerField);

		this.init(extendWith);
	};

	$.extend(formFieldOption.prototype, context.forms.formFieldOption.prototype, {
		init: function(extendWith) {
			var subfieldArray = null;
			var col = null;

			if (extendWith && typeof extendWith === "object") {
				if (typeof extendWith.subfields !== "undefined") {
					if ($.isArray(extendWith.subfields))
						subfieldArray = extendWith.subfields.slice(0);
					delete extendWith.subfields;
				}
				$.extend(this, extendWith);
			}

			col = new formFieldCollection(this.field.form, this);
			if (subfieldArray)
				col.init(subfieldArray);
			this.subfields = col;

			for (var i = 0; i < this.subfields.items.length; i++) {
				this.field.form.setDependencies(this.subfields.items[i]);
			}
		}
	});

	function formFieldCollection(ownerForm, ownerOption) {
		context.forms.formFieldCollection.call(this, ownerForm, ownerOption);

		this.getNewItem = function(extendWith) {
			return new formField(this.form, this.parentOption, extendWith);
		};
	};

	$.extend(formFieldCollection.prototype, context.forms.formFieldCollection.prototype, {
	});

	function formFieldOptionCollection(ownerField) {
		context.forms.formFieldOptionCollection.call(this, ownerField);

		this.getNewItem = function(extendWith) {
			return new formFieldOption(this.field, extendWith);
		};
	};

	$.extend(formFieldOptionCollection.prototype, context.forms.formFieldOptionCollection.prototype, {
	});

	function getForm(index) {
		if (typeof index === "undefined")
			index = 0;

		if (!isNaN(index)) {
			if (index >= 0 && index < forms.length)
				return forms[index];
		}
		else if (typeof index === "string") {
			for (var i = 0; i < forms.length; i++) {
				if (forms[i].id === index)
					return forms[i];
			}
		}

		return null;
	};

	return {
		searchType: searchType,
		form: form,
		getForm: getForm
	};
});

jQuery.fn.mascusSearchForm = function(parameters) {
	return this.each(function() {
		var container = $(this);
		var form = new mascus.search.form(container, parameters);
	});
};
mascus.extend("navigation", function(context) {
	function locationBrowser(containerElement, parameters) {
		context.extensionBase.call(this, containerElement, parameters, {
			levels: ["continent", "countrycode", "region"],
			level3Columns: 3,
			style: "default",
			showCounts: true,
			showFlags: true,
			autoLoad: true
		});

		this.init();
	};

	locationBrowser.prototype = {
		init: function() {
			this.container.empty();
			this.container.addClass("location-browser bor no-bor-t");
			if (this.parameters.autoLoad)
				this.getData(1, this.parameters.levels[0], null, null, this.container);
		},

		getData: function(level, type, parentCode, parentOption, parentElement) {
			var self = this;

			if ($.isFunction(this.parameters.getDataHandler))
				this.parameters.getDataHandler(level, type, parentCode, parentOption, parentElement, function(data) { self.getDataCallback(level, type, parentCode, parentOption, parentElement, data) });
			else {
				if (type == "continent")
					context.localizer.getContinents(function(data) { self.getDataCallback(level, type, parentCode, parentOption, parentElement, data) });
				else if (type == "countrycode")
					context.localizer.getCountries(parentCode, function(data) { self.getDataCallback(level, type, parentCode, parentOption, parentElement, data) });
				else if (type == "region")
					context.localizer.getRegions(parentCode, function(data) { self.getDataCallback(level, type, parentCode, parentOption, parentElement, data) });
			}
		},

		getDataCallback: function(level, type, parentCode, parentOption, parentElement, data) {
			if (data && data.length)
				this.renderChildren(level, type, parentCode, parentOption, parentElement, data);
			else if (parentElement)
				context.layout.hideLoadingIcon(parentElement);
		},

		renderChildren: function(level, type, parentCode, parentOption, parentElement, data) {
			var self = this;

			var html = "";
			var itemsPerColumn = 0;
			var columnClass = "";
			var columnItemCounter = 0;
			var isLastLevel = level == this.parameters.levels.length;
			var parentCheckBox = parentElement.find("> .header input");
			var parentSelected = parentCheckBox.prop("checked");
			var parentDisabled = parentCheckBox.hasClass("disabled");

			var ul = parentElement.children(".level-" + level);
			if (ul.length === 0) {
				html = "<ul data-parent=\"" + (parentCode ? parentCode : "") + "\" class=\"level-" + level + " level-" + type + " bor hide\"></ul>";
				ul = $(html);
				parentElement.append(ul);
			}
			else
				ul.html("");

			if (data == null || data.length == 0)
				return;

			if (level === 3) {
				itemsPerColumn = Math.ceil(data.length / this.parameters.level3Columns);
				columnClass = "col-md-12 col-lg-" + (12 / this.parameters.level3Columns);
				ul.addClass("col-row");
			}

			html = "";
			for (var i = 0; i < data.length; i++) {
				columnItemCounter++;

				var value = data[i].value;
				var text = data[i].text;
				if (!text)
					text = value;
				var hasChildren = false;
				if (typeof data[i].hasChildren === "boolean")
					hasChildren = data[i].hasChildren;
				var selected = data[i].selected;
				var resultCount = 0;
				if (!isNaN(data[i].resultCount))
					resultCount = data[i].resultCount;
				//hasChildren = true;

				if (itemsPerColumn > 0 && columnItemCounter === 1)
					html += "<li class=\"" + columnClass + "\"><ul class=\"level-sub pad-c-after-sm\">";

				html += "<li data-value=\"" + value + "\" class=\"level-item pos-rel bor-t";
				if (hasChildren && !isLastLevel)
					html += " has-children";
				if (selected)
					html += " selected";
				html += "\">";
				html += "<div class=\"header flo-wrap color-lighter no-text-select"
				if (this.parameters.style === "default" && level === 1) {
					html += " gradient-gray";
					if (hasChildren && !isLastLevel)
						html += " mouse-react";
				}
				html += "\">";

				html += "<div class=\"title-wrap flo bor-b pad-e-sm text-cut\">";
				html += "<span class=\"checkbox bor-e\"><input type=\"checkbox\" value=\"" + value + "\"";
				if (selected)
					html += " checked=\"checked\"";
				if (parentSelected || parentDisabled)
					html += " class=\"disabled\"";
				html += "/></span>";

				if (!isLastLevel) {
					html += "<span class=\"toggle-children";
					if (!hasChildren)
						html += " vis-h";
					html += "\"><i class=\"fa fa-caret-down\"></i></span>";
				}
				html += "<span class=\"title\">";
				html += text;
				html += "</span>"
				if (this.parameters.showCounts && resultCount > 0)
					html += " <span class=\"count\">(" + context.localizer.formatDisplayNumber(resultCount) + ")</span>";
				html += "</div>";

				if (level === 1) {
					html += "<div class=\"checkbox-controls flo-o ali-o pad-e hide\">";
					//html += "<a class=\"check-all secondary-button\">" + context.localizer.translate("b_check_all") + "</a> ";
					html += "<a class=\"uncheck-all secondary-button\">" + context.localizer.translate("b_uncheck_all") + "</a>";
					html += "</div>";
				}

				html += "</div>";

				html += "</li>";

				if (itemsPerColumn > 0 && columnItemCounter === itemsPerColumn) {
					html += "</ul></li>";
					columnItemCounter = 0;
				}
			}
			ul.append(html);

			ul.find("li[data-value]").each(function(index) {
				$(this).data("option", data[index]);
			});

			if (level === 1) {
				ul.on("click.checkbox.check.all", "> li > .header .checkbox-controls > .check-all", function(e) {
					e.stopImmediatePropagation();
					self.toggleSelection($(this).closest("li"), true, true);
				});
				ul.on("click.checkbox.uncheck.all", "> li > .header .checkbox-controls > .uncheck-all", function(e) {
					e.stopImmediatePropagation();
					self.toggleSelection($(this).closest("li"), false, true);
				});
			}

			var selectorPrefix = itemsPerColumn > 0 ? "> li > ul " : "";

			ul.on("click.header", selectorPrefix + "> li > .header", function(e) {
				e.stopImmediatePropagation();
				self.toggleChildren($(this).closest("li"), level);
			});

			ul.on("click.checkbox", selectorPrefix + "> li > .header .checkbox", function(e) {
				e.stopImmediatePropagation();
				self.toggleSelection($(this).closest("li"), null, true);
			});

			ul.on("click.checkbox.input", selectorPrefix + "> li > .header .checkbox input", function(e) {
				e.stopImmediatePropagation();
				var checkbox = $(this);
				self.bubbleSelection(checkbox.closest("li"), checkbox.prop("checked"));
			});

			context.layout.hideLoadingIcon(parentElement);
			if (level === 1)
				ul.show();
			else
				this.toggleChildren(parentElement, level - 1);
		},

		toggleChildren: function(li, level) {
			var header = li.children(".header");
			var children = li.children("ul");
			if (children.length !== 0) {
				children.toggle();
				li.toggleClass("open");
				if (this.parameters.style === "default" && level === 1)
					header.toggleClass("gradient-orange color-white gradient-gray color-lighter");
			}
			else if (li.hasClass("has-children")) {
				if (this.parameters.levels.length >= level) {
					context.layout.showLoadingIcon(li);
					this.getData(level + 1, this.parameters.levels[level], li.data("value"), li.data("option"), li);
				}
			}
			else if (level == this.parameters.levels.length)
				this.toggleSelection(li, null, true);
		},

		toggleSelection: function(li, select, bubble) {
			var checkBox = li.find("> .header input");
			if (typeof select !== "boolean")
				select = !checkBox.prop("checked");
			checkBox.prop("checked", select);
			if (bubble)
				this.bubbleSelection(li, select);
		},

		bubbleSelection: function(li, selected) {
			var checkBox = li.find("> .header input");
			var ul = li.parent();
			var selector = "";
			if (ul.hasClass("level-sub")) {
				ul = ul.parent().parent();
				selector = "> li > ul ";
			}
			selector += "> li";
			var siblings = ul.find(selector);
			var checkBoxes = siblings.find("> .header input");
			var selectedCount = checkBoxes.filter(":checked").length;
			//alert(selectedCount + "/" + siblings.length);

			li.toggleClass("selected", selected);
			li.find("> ul .header input").each(function() {
				var childCheckBox = $(this);
				childCheckBox.prop("checked", false);
				childCheckBox.toggleClass("disabled", selected);
			});

			if (selectedCount === siblings.length) {
				if (siblings.length > 1) {
					checkBoxes.prop("checked", false);
					checkBoxes.addClass("disabled");
					ul.closest("li").addClass("selected").find("> .header input").prop("checked", true);
				}
				else {
					checkBox.removeClass("disabled");
					ul.parents("li").removeClass("selected").find("> .header input").prop("checked", false);
				}
			}
			else {
				if (selectedCount === 1 || checkBox.hasClass("disabled")) {
					checkBoxes.removeClass("disabled");
					ul.parents("li").removeClass("selected").find("> .header input").prop("checked", false);
				}
			}
		}
	}

	return {
		locationBrowser: locationBrowser
	}
});

jQuery.fn.mascusLocationBrowser = function(parameters) {
	return new mascus.navigation.locationBrowser(this, parameters);
};
mascus.extend("contact", function(context) {
	var contactType = {
		product: 1,
		company: 2,
		service: 3,
		product_popup: 4,
        user_product_popup: 5
	};

	function form(containerElement, parameters) {
		this.container = containerElement;
		this.similarAdsContainer = null;
		this.parameters = $.extend({
			ajaxUrl: "/ajax/ContactHandler.aspx",
			type: contactType.product,
			serviceType: 0,
			autoLoad: true,
			productId: null,
			catalog: null,
			companyId: null,
			ready: null
		}, parameters);

		this.init();
	};

    form.prototype = {
    	init: function() {
    		if (this.parameters.autoLoad)
    			this.loadHtml(this.parameters);
    		else if ($.isFunction(this.parameters.ready))
    			this.parameters.ready();
        },

        loadHtml: function (parameters, returnData) {
            var base = this;
            if (!parameters)
                parameters = base.parameters;

            if (typeof returnData == "object" && returnData != null) {
                //alert("returnData");
                if (returnData.success) {
                	base.container.html(returnData.content);
                	context.layout.customizeFormElements(base.container);
                	context.layout.disableEnterPress(base.container);
                    if (returnData.onload)
                    	eval(returnData.onload);
                    if ($.isFunction(base.parameters.ready))
                    	base.parameters.ready();
                }
            }
            else {
                //alert("load...");
                parameters = $.extend({
                    success: function (parameters, data) { base.loadHtml(parameters, data) },
                    error: function () { }
                }, parameters);
                base.getHtml(parameters);
            }
        },

        getHtml: function (parameters) {
            if (!parameters)
                return;

            var base = this;
            var url = base.parameters.ajaxUrl + "?action=getformhtml";
            if (this.parameters.type === contactType.service)
            	url += "&astype=" + this.parameters.serviceType;
            if (parameters.productId) {
                url += "&cf_productid=" + parameters.productId;
                if (parameters.catalog)
                    url += "&cf_catalog=" + parameters.catalog;
            }
            else if (parameters.companyId)
                url += "&cf_companyid=" + parameters.companyId;
        	//alert(url);
            if (this.parameters.type === contactType.product_popup)
                url += "&origin=popup";
            if (this.parameters.type === contactType.user_product_popup)
                url += "&origin=userpopup";
            context.ajax(url, function(data, textStatus, jqXHR) {
            	//alert("success: " + data);
            	parameters.success(parameters, data);
            });
        },

        sendMessage: function (step) {
            var base = this;
            var button = base.container.find(".contact-submit");

            if ((!step || step < 3) && button.data("disabled") == true)
                return false;
            button.data("disabled", true);

            var overlay = base.container.find(".popup-overlay");
            var popup = base.container.find(".popup-wrapper");
            var wait = popup.find(".wait");
            var result = popup.find(".result");
            var saveSearch = popup.find(".savesearch-div");
            var saveSearchChecked = saveSearch.find("#savesearch_checkbox").prop("checked") == true ? true : false;
            var message = result.find(".message");
            var close = result.find(".close");
            var postData = "action=sendmessage";
            if (this.parameters.type === contactType.service)
                postData += "&astype=" + this.parameters.serviceType;
            if (this.parameters.type === contactType.product_popup)
                postData += "&origin=popup";
            if (this.parameters.type === contactType.user_product_popup)
                postData += "&origin=userpopup";
            postData += "&" + base.container.find(".contact-post").serialize();
            //alert("step: " + step + ", contactType: " + this.parameters.type + ", postData: " + postData + ", saveSearchChecked: " + saveSearchChecked);
			//return;

            var captcha = $('#CRGoogleCaptcha1Value').val();
            postData += "&g-recaptcha-response=" + captcha;

            if (step == 3) {
                message.empty();
                result.hide();
            }
            
            overlay.show();
            popup.show();
            //wait.css("display", "inline-block");
            wait.show();

            result.removeClass("success");
            result.removeClass("error");

            $.ajax({
            	url: base.parameters.ajaxUrl,
                type: "POST",
                dataType: "json",
                cache: false,
                data: postData,
                success: function (data, textStatus, jqXHR) {
                    base.container.find(".contact-post").removeClass("error");
                    base.container.find("label").removeClass("error");
                    if (!data || $.isEmptyObject(data))
                        return;
                    if (!data.success) {
                        for (var i = 0; i < data.errorFields.length; i++) {
                            base.container.find("#lbl_" + data.errorFields[i]).addClass("error");
                            base.container.find(".contact-post[name='" + data.errorFields[i] + "']").addClass("error");
                        }

                        if (data.errorFields.length > 0 || data.step != 3) {
                            result.removeClass("success");
                            result.addClass("error");
                        }
                    }
                    else {
                        result.removeClass("error");
                        result.addClass("success");
                        base.container.find("input:text,textarea").val("");
                    	//tracking for Google Analytics
                        if (base.parameters.type === contactType.product || base.parameters.type === contactType.product_popup) {
                        	_gaq.push(['_setAccount', 'UA-330829-1']);
                        	_gaq.push(['_addTrans', '' + Math.floor((Math.random() * 10000) + 1) + '', '' + currentContext.domain + '', '1', '', '', '', '', '']);
                        	_gaq.push(['_addItem', '' + Math.floor((Math.random() * 10000) + 1) + '', '' + data.categoryName + '', 'contact', '' + data.companyName + '', '1', '1']);
                        	_gaq.push(['_trackTrans']);
                        	_gaq.push(['_trackEvent', 'call-to-action', 'sent-contact-form-desktop', '' + data.companyName + '']);
                        	_gaq.push(['_trackPageview', '/goal-contact-form-sent']);

                        	//if (currentContext.domain != "cn") {
                         //       window.optimizely.push({
                         //           "type": "event", "eventName": 'contact_sent'
                         //       });
                        	//}
                        	dlP('dlReadyCartSuccess', '', '');
                        	if (saveSearchChecked) {
                        		dlP('Save_search_button', '', '');
                        	}
                            /*
                        	if (currentContext.domain == "es")
                        	{
                        	    ga('create', 'UA-330829-8', 'auto', {'name': 'UAvgrn'});
                        	    ga('UAvgrn.requiere', 'ecommerce');
                        	    ga('UAvgrn.ecommerce:addTransaction',[''+Math.floor((Math.random() * 10000) + 1)+'',''+data.deviceType+'','1',' ',' ']);
                        	    ga('UAvgrn.ecommerce:addItem',[''+ Math.floor((Math.random() * 10000) + 1) +'','contact',''+data.categoryName+'','' + data.companyName + '', '1','1']);
                        	    ga('UAvgrn.ecommerce:send');
                        	}
                            */

                        }

                        //if (base.parameters.type === contactType.service && base.parameters.serviceType===1 ) {
                        //    window.optimizely.push({
                        //        "type": "event",
                        //        "eventName": "financial_form_sent"
                        //    });
                        //}
                    }

                    close.unbind("click");
                    close.click(function (event) {
                        message.empty();
                        result.hide();
                        overlay.hide();
                        popup.hide();
                        button.data("disabled", false);
                        if (data.success && base.parameters.type === contactType.service) {
                        	var modalId = base.container.closest(".overlay").attr("id");
                            context.layout.closeModalPopup(modalId);
                        }
                    });

                    wait.hide();
                    //if (data.step == 3 || (data.step == 4 && data.content))
                    if (data.step == 3) {
                        message.html(data.content);
                    }
                    else if (data.step == 4 && data.content) {
                        //message.html(data.message);
                        close.trigger("click");
                        base.initSimilarAds(data.content);
                        return;
                    }
                    else {
                        message.html(data.message);
                        saveSearch.hide();
                    }
                    //result.css("display", "inline-block");
                    result.show();

                    if (data.onload)
                        eval(data.onload);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //alert("Error: " + errorThrown);
                },
                complete: function (jqXHR, textStatus) {
                }
            });
        },

        sendMessageCopy: function() {
        	var base = this;
        	var button = base.similarAdsContainer.find(".contact-submit");

        	if (button.data("disabled") == true)
        		return false;
        	button.data("disabled", true);

        	var message = base.similarAdsContainer.find(".alert");
        	var postData = "action=sendcopy&" + base.similarAdsContainer.find(".contact-post").serialize();
        	//alert(postData);
        	//return;

        	var modal = base.similarAdsContainer.find(".modal-window");
        	var overlay = base.similarAdsContainer.find(".wait-overlay");
        	if (overlay.length == 0) {
        		modal.append("<div class=\"wait-overlay\"></div><div class=\"wait-icon\">&nbsp;</div>");
        		overlay = modal.find(".wait-overlay");
        		overlay.css("width", (modal.outerWidth() - 10) + "px");
        		overlay.css("height", (modal.outerHeight() - 10) + "px");
        		overlay.css({ "left": "5px", "top": "5px" });
        	}
        	var wait = modal.find(".wait-icon");
        	overlay.show();
        	wait.show();
        	//return;

        	$.ajax({
        		url: base.parameters.ajaxUrl,
        		type: "POST",
        		dataType: "json",
        		cache: false,
        		data: postData,
        		success: function(data, textStatus, jqXHR) {
        			if (!base.similarAdsContainer || base.similarAdsContainer.length == 0)
        				return;

        			wait.hide();
        			overlay.hide();

        			base.similarAdsContainer.find(".contact-post").removeClass("error");
        			base.similarAdsContainer.find("label").removeClass("error");
        			if (!data || $.isEmptyObject(data))
        				return;
        			if (!data.success) {
        				for (var i = 0; i < data.errorFields.length; i++) {
        					base.similarAdsContainer.find("#lbl_" + data.errorFields[i]).addClass("error");
        					base.similarAdsContainer.find(".contact-post[name='" + data.errorFields[i] + "']").addClass("error");
        				}
        				message.removeClass("success");
        				message.addClass("error");
        				message.find(".content").html("<b>" + data.message + "</b>");
        				button.data("disabled", false);
        			}
        			else {
        				message.removeClass("error");
        				message.addClass("success");
        				message.find(".content").html("<b>" + data.message + "</b>");
        				base.similarAdsContainer.find(".select-content").hide();
        				base.similarAdsContainer.find(".select-footer").show();
        				base.similarAdsContainer.click(function(e) {
        					e.preventDefault();
        					e.stopImmediatePropagation();
        					base.similarAdsContainer.remove();
        					base.similarAdsContainer = null;
        				});
        			}

        			if (data.onload)
        				eval(data.onload);
        		},
        		error: function(jqXHR, textStatus, errorThrown) {
        			//alert("Error: " + errorThrown);
        		},
        		complete: function(jqXHR, textStatus) {
        		}
        	});
        },

        initSimilarAds: function (html) {
        	var base = this;
        	$("body").append(html);
        	base.similarAdsContainer = $("#cf-similar-ads");

        	base.similarAdsContainer.find(".close-click").click(function(e) {
        		e.preventDefault();
        		base.similarAdsContainer.remove();
        		base.similarAdsContainer = null;
        	});

        	base.similarAdsContainer.find(".contact-submit").click(function(e) {
        		e.preventDefault();
        		base.sendMessageCopy();
        	});

        	base.similarAdsContainer.find("input[name='cf_productid']").click(function(e) {
        		var li = $(this).closest("li");
        		if (!this.checked)
        			li.css("opacity", "0.7");
				else
        			li.css("opacity", "1");
        	});

        	base.similarAdsContainer.find(".pic img").click(function(e) {
        		var li = $(this).closest("li");
        		var checkbox = li.find("input[name='cf_productid']")[0];
        		if (!checkbox.checked) {
        			checkbox.checked = true;
        			li.css("opacity", "1");
        		}
        		else {
        			checkbox.checked = false;
        			li.css("opacity", "0.7");
        		}
        	});

        	base.similarAdsContainer.show();
        	base.similarAdsContainer.find(".modal-window").show();
        },

        getRentalPriceCalculation: function (displayElementId, displayTabId) {
            var priceDaily, priceWeekly, priceMonthly, fromDate, toDate, currency, userCurrency;
            priceDaily = $('#rental_pricedaily_hidden').val();
            priceWeekly = $('#rental_priceweekly_hidden').val();
            priceMonthly = $('#rental_pricemonthly_hidden').val();
            currency = $('#rental_currency_hidden').val();
            fromDate = $('#cf_rental_from').val();
            toDate = $('#cf_rental_to').val();
            userCurrency = $('#rental_user_currency_hidden').val();
            if (fromDate && toDate) {

                //$(displayTabId).hide();
                var base = this;
                var url = base.parameters.ajaxUrl + "?action=rentpricecalculator";
                
                url += "&pricedaily=" + priceDaily + "&priceweekly=" + priceWeekly + "&pricemonthly=" + priceMonthly + "&currency=" + currency + "&fromDate=" + fromDate + "&todate=" + toDate + "&usercurrency="+userCurrency;
                
                context.ajax(url, function (data, textStatus, jqXHR) {
                    if (data.message!="") {
                       // $(displayTabId).slideDown("slow");
                        if ($(displayTabId).is(":hidden")) {
                            $(displayTabId).slideDown("slow");
                        } 
                        $(displayElementId).html(data.message);
                    }
                    else {
                        $(displayTabId).hide();
                    }
                });
            }
        }
    }

    return {
		contactType: contactType,
    	form: form
    }
});

jQuery.fn.mascusContactForm = function(parameters) {
	return this.each(function() {
		var container = $(this);
		var form = new mascus.contact.form(container, parameters);
		container.data("mascusContactForm", form);
	});
};

function doExport(event, object, exportType) {
    if (exportType == 1) {
        event.stopPropagation();
        event.preventDefault();
        oldAction = $("#aspnetForm").attr('action');
        $("#aspnetForm").attr('action', object.getAttribute("href"));
        document.forms[0].submit();
        $("#aspnetForm").attr('action', oldAction);
    }
}

function dlPush(event, currency, name, id, price, category, brand, position, d1, d2, d3, d4, d5, d6, d7, d8, d9, currentUrl, linkURL) {

    switch (event.toLowerCase()) {
        case "dlreadydetail":
            dataLayer.push({
                'ecommerce': {
                    'currencyCode': '' + currency + '',
                    'detail': {
                        'products': [{
                            'name': ''+ name + '',
                            'id': '' + id + '',
                            'price': '0',
                            'category': '' + category + '',
                            'brand': '' + brand + '',
                            'position': 1,
                            'dimension1': '' + d1 + '',
                            'dimension2': '' + d2 + '',
                            'dimension3': '' + d3 + '',
                            'dimension4': '' + d4 + '',
                            'dimension5': '' + d5 + '',
                            'dimension6': '' + d6 + '',
                            'dimension7': '' + d7 + '',
                            'dimension8': '' + d8 + '',
                            'dimension9': '' + d9 + ''
                        }]
                    }
                },
                'event': '' + event + ''
            });
            break;
        case "productclick":
            dataLayer.push({
                'event':'productClick',
                'ecommerce': {
                    'currencyCode': '' + currency + '',
                    'click': {
                        'actionField': {'list': '' + currentUrl + ''},
                        'products': [{
                            'name': ''+ name + '',
                            'id': '' + id + '',
                            'price': '0',
                            'category': '' + category + '',
                            'brand': '' + brand + '',
                            'position': 1,
                            'dimension1': '' + d1 + '',
                            'dimension2': '' + d2 + '',
                            'dimension3': '' + d3 + '',
                            'dimension4': '' + d4 + '',
                            'dimension5': '' + d5 + '',
                            'dimension6': '' + d6 + '',
                            'dimension7': '' + d7 + '',
                            'dimension8': '' + d8 + '',
                            'dimension9': '' + d9 + ''
                        }]
                    }
                },
                'eventCallback': function() {
                    document.location = '' + linkURL + ''
                }
            });
            break;
    }

    //alert(event + ' ' + d9);
    
}

function dlP(event, element, action) {

    switch (event.toLowerCase()) {
        case "dlreadycartsuccess":
            dataLayer.push({
                'ecommerce': {
                    'purchase': {
                        'actionfield': {
                            'id': 'placeholder',
                            'revenue': '' + jprice + '',
                            'tax': ''
                        },
                        'products': [{
                            'name': '' + jbrandmodel + '',
                            'id': '' + jprodid + '',
                            'price': '0',
                            'category': '' + jcompany + '',
                            'brand': '' + jbrand + '',
                            'position': 1,
                            'dimension1': '',
                            'dimension2': '' + jlogged + '',
                            'dimension3': '' + jcountry + '',
                            'dimension4': '' + jdevice + '',
                            'dimension5': '' + jbrandmodel + '',
                            'dimension6': '',
                            'dimension7': '' + jectg + '',
                            'dimension8': '' + jectl + '',
                            'dimension9': '' + jcompany + ''
                        }]
                    }
                },
                'event': '' + event + ''
            });
            dlP('Form_filling', '', '');
            break;
        case "addtocart":
            dataLayer.push({
                'event': '' + event + '',
                'ecommerce': {
                    'currencyCode': '' + jcurrency + '',
                        'add': {
                            'name': '' + jbrandmodel + '',
                            'id': '' + jprodid + '',
                            'price': '0',
                            'category': '' + jcompany + '',
                            'brand': '' + jbrand + '',
                            'position': 1,
                            'dimension1': '',
                            'dimension2': '' + jlogged + '',
                            'dimension3': '' + jcountry + '',
                            'dimension4': '' + jdevice + '',
                            'dimension5': '' + jbrandmodel + '',
                            'dimension6': '',
                            'dimension7': '' + jectg + '',
                            'dimension8': '' + jectl + '',
                            'dimension9': '' + jcompany + ''
                        }
                    }
            });
            dlP('Showed_whole_form', '', '');
            break;
        case "categorybox": case "menuclick": case "newregistration": case "navigation_bar": case "main_category_clicks" :
            dataLayer.push({
                'event': '' + event + '',
                'element': '' + element + ''
            })
            break;
        case "productpagebuttons": case "crosslinks" :
            dataLayer.push({
                'event': '' + event + '',
                'element': '' + element + '',
                'location': '' + action + ''
            })
            break;
        case "filters": case "use_filter" :
            dataLayer.push({
                'event': '' + event + '',
                'action': '' + element + '',
                'label': '' + action + ''
            })
            break;
        case "submitformfeedback":
            dataLayer.push({
                'event': 'success_send_otpravka_kontaktov'
            })
        default:
            dataLayer.push({
                'event': '' + event + ''
            })

    }

    //alert(event + ' ' + element);

}

function dlPCat(catalog, parentCategory, category, brand, model) {

    dataLayer.push({
        'contentGroup1': '' + catalog + '',
        'contentGroup2': '' + parentCategory + '',
        'contentGroup3': '' + category + '',
        'contentGroup4': '' + brand + ', ' + model + ''
    });
     
}



