mascus.extend("product", function(context) {
	function card(containerElement, parameters) {
		context.extensionBase.call(this, containerElement, parameters, {
            productId: null,
		    catalogName: null,
			priceOriginal: 0,
			priceOriginalUnit: "",
			priceWithTax: 0,
			vatAmount: 0,
            dealerPrice: 0,
			ajaxUrl: "/ajax/ProductHandler.aspx",
			ajaxUrlSearch: "/ajax/SearchHandler.aspx",
			saveSearchButton: ".follow-button",
			saveSearchAdsButton: ".follow-button-ads",
			showCRPopup: "false",
            populatedCRPopup: "false",
            timerVar: ""
		});

		if (this.container == null || this.container.length == 0)
			return;

		this.init();

	};

	card.prototype = {
		init: function() {
		    var self = this;

			self.container.find("#pc-print").click(function(e) {
				e.preventDefault();
				self.container.find($(".hidden-number")).each(function () {
				    self.showHiddenNumber($(this), false);
				   $(this).addClass("clicked");
				});
				window.print();
			});

			self.container.find("#pc-addtofavorites").click(function(e) {
				e.preventDefault();
				alert("TODO: add to favorites");
			});

			//context.layout.customizeFormElements(self.container);
			self.container.find(".select-currency").change(function(e) {
			    context.localizer.convertCurrency(self.parameters.priceOriginalUnit, $(this).val(), [self.parameters.priceOriginal, self.parameters.priceWithTax, self.parameters.vatAmount, self.parameters.dealerPrice], 0, function (data) {
					self.container.find("#pc-price").html(data[0].text);
					self.container.find("#pc-price-with-vat").html(data[1].text);
					self.container.find("#pc-price-vat").html(data[2].text);
					self.container.find("#dealer-price").html(data[3].text);
				});
			});

			/*self.container.find("#pc-share").click(function (e) {
			    $("#share-popup").addClass("open");
			    $("#share-popup > .modal-window").addClass("open");
			});*/

			//self.container.find("#show-contacts").click(function (e) {
			//    $("#show-contacts").addClass("hidden");
			//    $(".secondary-contact").removeClass("hidden");
			//    $("#hide-contacts").removeClass("hidden");
			//});
			//self.container.find("#hide-contacts").click(function (e) {
			//    $("#show-contacts").removeClass("hidden");
			//    $(".secondary-contact").addClass("hidden");
			//    $("#hide-contacts").addClass("hidden");
			//});

			self.container.find("#product_stats_button").click(function (e) {
                
			    if ($("#prod_stats_chart").length > 0)
			        $("#product_stats").slideToggle();

			    else {
			        context.layout.showLoadingIcon(self.container.find("#product_stats_button"));
			        $("#product_stats_button").prop("disabled", "true");
                    $.ajax({
                        url: self.parameters.ajaxUrl + "?action=chart&productid=" + self.parameters.productId,
			            type: "get",
			            success: function (result) {
			                var resultJSON = JSON.parse(result);
			                if (!resultJSON.error) {
			                    var image64 = resultJSON.image;
			                    var image = new Image();
			                    image.id = "prod_stats_chart";
			                    image.src = 'data:image/png;base64,' + image64;


			                    self.container.find("#product_stats").append("<h2>"+resultJSON.boxHeader+"</h2>");
			                    
			                    self.container.find("#product_stats").append(image);

			                    var stats = resultJSON.stats;

			                    var statsTableHtml = "<table class='prod-stats-table'><tr><td><b>" + resultJSON.tableHeaderCountry + "</b></td><td><b>" + resultJSON.tableHeaderVisits + "</b></td></tr>";

			                    for (var i = 0; i < stats.length; i++) {
			                        statsTableHtml += "<tr><td>" + stats[i].country + "</td><td>" + stats[i].hits + "</td></tr>";
			                    }

			                    statsTableHtml += "<tr><td><b>" + resultJSON.totalHeader + "</b></td><td><b>" + resultJSON.total + "</b></td></tr></table>";

			                    self.container.find("#product_stats").append(statsTableHtml);

			                    self.container.find("#product_stats").append("<div style='clear:both;'></div>");
			                }
			                else
			                {
			                    self.container.find("#product_stats").append("<h3 id=\"prod_stats_chart\">" + resultJSON.error + "</h3>");
			                }
			                $("#product_stats").slideToggle();
			                context.layout.hideLoadingIcon(self.container.find("#product_stats_button"));
			                $("#product_stats_button").prop("disabled", "false");
			            }
			        });
			    }

            });

            $("#product_export_button").click(function (e) {
                if ($("#product_export_links").is(":visible")) {
                    $("#product_export_links").hide();
                }
                else {
                    $("#product_export_links").show();
                }

            });
			   
			if ($(window).width() < 768) {
			    $(".product-tools").insertBefore(".product-info");
			    $(".price-details").appendTo("#product-header .price");
			}
            
			if ($(window).width() < 768) {
			    self.container.find(".hidden-number-inner").each(function (e) {
			        var wrapper = $(this);
				    if (wrapper.hasClass("fax-number")) {
				        self.showHiddenNumber(wrapper, false);
				    }
				    else {
				        self.showHiddenNumber(wrapper, true);
				    }
				});
				self.container.find(".call-button,.hidden-number").click(function (e) {
					var wrapper = $(this);
					_gaq.push(["_trackEvent", "call-to-action", "call-seller-btn-click", wrapper.data("hidden-number-id")]);
					dlP('callButtonClick','','');
					var phoneNumber = "";
					if (!wrapper.hasClass("fax-number")) {
					    if (wrapper.hasClass("call-button"))
					        phoneNumber = wrapper.attr("href").replace(/^tel:/, "");
					    else
                            phoneNumber = wrapper.find(".hidden-number-value").data("hidden-number-call");
                        //make request to FreeSpee for Call action
                        if (isFreeSpeeEnabled && wrapper.find(".fa-mobile").length > 0)
                            phoneNumber = self.callActionFreeSpee(self, phoneNumber, wrapper);
					    mascus.log.track("click-call-button", { productId: self.parameters.productId, number: phoneNumber });
					}
				});
			}
			else {
                $(".hidden-number").click(function (e) {
                    var wrapper = $(this);
                    //make request to FreeSpee for Reveal action
                    if (isFreeSpeeEnabled && wrapper.find(".fa-mobile").length > 0 && wrapper.find(".fax-number").length == 0 && wrapper.find(".instantMssClick").length == 0)
                        self.revealActionFreeSpee(self, wrapper, "reveal-number-desktop");
                    else {
                        $(this).addClass('clicked');
                        _gaq.push(["_trackEvent", "call-to-action", "reveal-number-desktop", wrapper.data("hidden-number-id")]);
                        dlP('Show_phone_number', '', '');
                        self.showHiddenNumber(wrapper, false);
                        var phoneNumber = wrapper.find(".hidden-number-value").data("hidden-number-call");
                        var logMss = "reveal-phone-number";
                        if (wrapper.find(".instantMssClick").length > 0) {
                            itemCls = wrapper.find(".instantMssClick").attr("class");
                            map = {
                                'instantMssClick': '',
                                'hidden-number-inner': '',
                                '_instantMessage': ''
                            };

                            var re = new RegExp(Object.keys(map).join("|"), "gi");
                            item = itemCls.replace(re, function (matched) {
                                return map[matched];
                            });

                            logMss = "instant-messaging-click-" + item.trim();
                        }
                        mascus.log.track(logMss, { productId: self.parameters.productId, number: phoneNumber });
                    }
				});
			}

			self.container.find(".click-rental-price-link").click(function (e) {
			    mascus.log.track("click-rental-price-link", { productId: self.parameters.productId, link: $(this).attr('href') });
			});

			/*self.container.find(".instantMssClick").click(function (e) {
			    //mascus.log.track("click-rental-price-link", { productId: self.parameters.productId, link: $(this).attr('href') });
			    alert("iuhuuuu");
			})*/


			self.container.find(".as-popup-opener").click(function(e) {
				e.preventDefault();
				self.openAdditionalServices($(this));
			});

			self.container.find(".show-details").click(function (e) {
			    $(this).removeClass("sm-show");
			    self.container.find(".hidden-detail").removeClass("sm-hide");
			});

			self.container.find(this.parameters.saveSearchButton).click(function (e) {
			    self.saveSearchFollowDealer();
			});

			$("#follow-dealer-email").keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					self.saveSearchFollowDealer();
				}
			});
			
			self.container.find(".follow-dealer-link").click(function (e) {
			    $(".follow-dealer-form").removeClass("hidecss");
			});

			self.container.find(".unfollow-button").click(function (e) {
			    $(".follow-dealer-link").removeClass("hidecss");
			    $(".follow-dealer-following").addClass("hidecss");
            });
           
            //follow ads
            self.container.find(this.parameters.saveSearchAdsButton).click(function (e) {
                self.saveSearchFollowAds();
            });
            $("#follow-ads-email").keydown(function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    self.saveSearchFollowAds();
                }
            });

            self.container.find(".follow-ads-link").click(function (e) {
                $(".follow-ads-form").removeClass("hideadscss");
            });

            self.container.find(".unfollow-button").click(function (e) {
                $(".follow-ads-link").removeClass("hideadscss");
                $(".follow-ads-following").addClass("hideadscss");
            });
			
			self.initSideBarCR(self);

			self.container.find(".sidebar-cr-button").click(function (e) {
			    $("#sidebar_contact_form").slideToggle();
			});

			self.container.find(".close-button.sidebar-close").click(function (e) {
			    $("#sidebar_contact_form").slideToggle();
			});
			
			$('#top-sticker').find(".sticker-contact-button").click(function (e) {
			    if (!$("#sidebar_contact_form").is(":visible")) {
			        if (self.parameters.populatedCRPopup == "true")
			            $("#sidebar_contact_form").slideToggle();
                    else
			            self.populateSideBarCR(self, 'useraction');
			    }
			});


			setTimeout(function () { self.showCRAfterInterval(self); }, 45000);
            
		},

		initSideBarCR: function (self) {
		    $(window).scroll(function () {
		        $(".sidebar-contact-form-block").css("bottom", Math.max(10, (($(window).scrollTop()+$(window).height())-$(document).height()+$("#footer").height()+50)));
		    });

		    $("#sidebar_contact_form").hide();
		    $(".sidebar-cr-button").hide();
		},

		populateSideBarCR: function (self, source) {
		    if ((self.parameters.showCRPopup == "true" && source=='timer') || (source=='useraction'))
		    {
		        var popupType = context.contact.contactType.product_popup;
		        if (source == 'useraction')
		            popupType = context.contact.contactType.user_product_popup;

		        $(".sidebar-cr-button").slideToggle();
		        $("#sidebar_contact_form_content").mascusContactForm({
		            type: popupType,
		            catalog: self.parameters.catalogName,
		            productId: self.parameters.productId.substr(1, 8),
		            ready: function () {
		                $("#sidebar_contact_form").slideToggle();
		                self.parameters.showCRPopup = "false";
		                self.parameters.populatedCRPopup = "true";
                        $("#sidebar_contact_form_content .hidden-number").click(function (e) {
                            var wrapper = $(this);
                            //make request to FreeSpee for Reveal action
                            if (isFreeSpeeEnabled && wrapper.find(".fa-mobile").length > 0)
                                self.revealActionFreeSpee(self, wrapper, "reveal-number-desktop-popup");
                            else {
                                $(this).addClass('clicked');
                                _gaq.push(["_trackEvent", "call-to-action", "reveal-number-desktop-popup", wrapper.data("hidden-number-id")]);
                                dlP('Show_phone_number', '', '');
                                self.showHiddenNumber(wrapper, false);
                                var phoneNumber = wrapper.find(".hidden-number-value").data("hidden-number-call");
                                mascus.log.track("reveal-phone-number", { productId: self.parameters.productId, number: phoneNumber });
                            }
		                });
		            }
		        });
		       
		    }
		},

        callActionFreeSpee: function (self, phoneNumber, wrapper) {
            if (companyId.length == 38) {//company Id is present so is a dealer Ad
                var emailAddress = "";
                if (wrapper.hasClass("call-button"))
                    emailAddress = wrapper.next(".contactEmail").text();
                else
                    emailAddress = wrapper.find(".contactEmail").text();
                $.ajax({
                    url: "/ajax/FreespeeHandler.aspx",
                    type: "POST",
                    dataType: "json",
                    data: {
                        "productId": self.parameters.productId,
                        "companyId": companyId,
                        "companyName": jcompany,
                        "phoneNumber": phoneNumber,
                        "pageUrl": window.location.href,
                        "brand": jbrand,
                        "model": jmodel,
                        "year": jyear,
                        "price": jprice,
                        "currency": jcurrency,
                        "imageUrl": $('.image_main').attr('src'),
                        "sellerCountryCode": sellerCountryCode,
                        "emailAddress": emailAddress,
                        "type": "call"
                    },
                    async: false,
                    success: function (result) {
                        if (result) {
                            var trackingPhone = result.trackingPhone;
                            if (wrapper.hasClass("call-button"))
                                wrapper.attr("href", "tel:" + trackingPhone);
                            else {
                                var hiddenNumberValueElem = wrapper.find(".hidden-number-value");
                                hiddenNumberValueElem.attr('data-hidden-number-call', trackingPhone);
                                hiddenNumberValueElem.attr('data-hidden-number-full', trackingPhone);
                                hiddenNumberValueElem.find('.orange-link').attr("href", "tel:" + trackingPhone);
                            }
                            phoneNumber = trackingPhone;
                        }
                    }
                });
            }
            return phoneNumber;
        },

        revealActionFreeSpee: function (self, wrapper, revealType) {
            if (companyId.length == 38 && !wrapper.hasClass('clicked')) {//company Id is present so is a dealer Ad
                wrapper.find(".revealLoadingIcon").show();
                $.ajax({
                    url: "/ajax/FreespeeHandler.aspx",
                    type: "POST",
                    dataType: "json",
                    data: {
                        "productId": self.parameters.productId,
                        "companyId": companyId,
                        "companyName": jcompany,
                        "phoneNumber": wrapper.find(".hidden-number-value").data("hidden-number-call"),
                        "pageUrl": window.location.href,
                        "brand": jbrand,
                        "model": jmodel,
                        "year": jyear,
                        "price": jprice,
                        "currency": jcurrency,
                        "imageUrl": $('.image_main').attr('src'),
                        "sellerCountryCode": sellerCountryCode,
                        "emailAddress": wrapper.find(".contactEmail").text(),
                        "type": "reveal"
                    },
                    async: true,
                    success: function (result) {
                        wrapper.find(".revealLoadingIcon").hide();
                        if (result) {
                            var trackingPhone = result.trackingPhone;
                            var hiddenNumberValueElem = wrapper.find(".hidden-number-value");
                            hiddenNumberValueElem.text(trackingPhone);
                            hiddenNumberValueElem.attr('data-hidden-number-full', trackingPhone);
                            hiddenNumberValueElem.attr('data-hidden-number-call', trackingPhone);
                            var freespeeInfo = wrapper.find('div.freespeeInfo');
                            if (freespeeInfo.length == 1) freespeeInfo.show();
                        }
                        wrapper.addClass('clicked');
                        _gaq.push(["_trackEvent", "call-to-action", revealType, wrapper.data("hidden-number-id")]);
                        dlP('Show_phone_number', '', '');
                        self.showHiddenNumber(wrapper, false);
                        var phoneNumber = wrapper.find(".hidden-number-value").data("hidden-number-call");
                        mascus.log.track("reveal-phone-number", { productId: self.parameters.productId, number: phoneNumber });
                    },
                    error: function (response) {
                        wrapper.find(".revealLoadingIcon").hide();
                        wrapper.addClass('clicked');
                        _gaq.push(["_trackEvent", "call-to-action", revealType, wrapper.data("hidden-number-id")]);
                        dlP('Show_phone_number', '', '');
                        self.showHiddenNumber(wrapper, false);
                        var phoneNumber = wrapper.find(".hidden-number-value").data("hidden-number-call");
                        mascus.log.track("reveal-phone-number", { productId: self.parameters.productId, number: phoneNumber });
                    }
                });
            }
        },

		showCRAfterInterval: function (self) {
		    if (self.parameters.showCRPopup == "true" && $(".overlay.open").length == 0) {
                
		        if (self.isScrolledOutsideView($('#main_contact_form'))) {
		            if (!$("#sidebar_contact_form").is(":visible")) {
		                self.populateSideBarCR(self,'timer');
		            }
		        }
		        else
		            setTimeout(function () { self.showCRAfterInterval(self); }, 5000);
		    }
		},


		isScrolledOutsideView: function(elem)
        {
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();

            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();

            return ((elemBottom <= docViewTop));
        },

		showHiddenNumber: function (wrapper, makeLink) {
			wrapper.css("cursor", "auto");
			var valueElem = wrapper.find(".hidden-number-value");
			if (makeLink) {
				var callTo = valueElem.data("hidden-number-call") ? valueElem.data("hidden-number-call") : valueElem.data("hidden-number-full");
				valueElem.html("<a class=\"orange-link\" href=\"tel:" + callTo + "\">" + valueElem.data("hidden-number-full") + "</a>");
			}
			else {
				valueElem.text(valueElem.data("hidden-number-full"));
				valueElem.removeClass("orange-link");
			}
		},

		saveSearchFollowDealer: function () {
		    var inputs = $(".follow-dealer-form").find("input");
		    var query = inputs.serialize();
		    var email = $("#follow-dealer-email").val();
		    var message = context.localizer.translate("followdealer_followingmessage");
		    var handler = this.parameters.ajaxUrlAlert;

		    if (validateEmail(email) == false) {
		        createFieldAlert("follow-dealer-email-container", "error", context.localizer.translate("savesearch_email_notvalid"), "follow-dealer-email");

		    }
		    else {
		        $.ajax({
		            url: this.parameters.ajaxUrlSearch + "?action=savesearch",
		            data: query,
		            type: "post",
		            success: function (searchid) {		              
		                ShowDialogBox("", message, 'OK', 'information', '');
		                try {
		                    dlP('Follow_dealer', '', ''); //New tracking code to GA -Katriina
		                    //window.optimizely.push(['trackEvent', 'follow_dealer']);
		                    $(".follow-dealer-form").addClass("hidecss");
		                    $(".follow-dealer-link").addClass("hidecss");
		                    $(".follow-dealer-following").removeClass("hidecss");
		                    document.getElementById('follow-dealer-unfollow-button').removeAttribute("onclick");
		                    $(".unfollow-button").click(function (e) {
                                deleteFollowDealer(searchid);
		                    });
		                }
		                catch (e) {
		                }
		            }
		        });

		    }
        },
        saveSearchFollowAds: function () {
            var inputs = $(".follow-ads-form").find("input");
            var query = inputs.serialize();
            var email = $("#follow-ads-email").val();
            var message = context.localizer.translate("followads_followingmessage");
            var handler = this.parameters.ajaxUrlAlert;

            if (validateEmail(email) == false) {
                createFieldAlert("follow-ads-email-container", "error", context.localizer.translate("savesearch_email_notvalid"), "follow-ads-email");

            }
            else {
                $.ajax({
                    url: this.parameters.ajaxUrlSearch + "?action=savesearch",
                    data: query,
                    type: "post",
                    success: function (searchid) {
                        ShowDialogBox("", message, 'OK', 'information', '');
                        try {
                            //window.optimizely.push(['trackEvent', 'follow_ads']);
                            $(".follow-ads-form").addClass("hideadscss");
                            $(".follow-ads-link").addClass("hideadscss");
                            $(".follow-ads-following").removeClass("hideadscss");
                            document.getElementById('follow-ads-unfollow-button').removeAttribute("onclick");
                            $(".unfollow-button").click(function (e) {
                                deleteFollowAds(searchid);
                            });
                        }
                        catch (e) {
                        }
                    }
                });

            }
        },

        openAdditionalServices: function(button) {
        	var self = this;

        	var type = parseInt(button.data("as-type"));
        	var popupId = "as-form-" + type;
        	var popup = context.layout.openModalPopup(popupId);
        	if (popup == null) {
        		popup = context.layout.openModalPopup(popupId, "", "<div class=\"as-form\"></div>", "");
        		context.layout.showLoadingIcon(popup.content);        		
        		popup.closeButton.click(function(e) {
        			context.layout.hideLoadingIcon(popup.content);
        		});
       			popup.content.find(".as-form").mascusContactForm({
       				type: context.contact.contactType.service,
       				serviceType: type,
       				catalog: self.parameters.catalogName,
       				productId: self.parameters.productId.substr(1, 8),
       				ready: function() {
       				    context.layout.hideLoadingIcon(popup.content);       				    
       				}
       			});
        	}
        },

        openContactPopup: function () {

            var self = this;

            var popupId = "contact-form-popup";
            var popup = context.layout.openModalPopup(popupId);
            if (popup == null) {
                popup = context.layout.openModalPopup(popupId, "", "<div class=\"contact-form\"></div>", "");
                context.layout.showLoadingIcon(popup.content);
                popup.closeButton.click(function (e) {
                    context.layout.hideLoadingIcon(popup.content);
                });
                popup.content.find(".contact-form").mascusContactForm({
                    type: context.contact.contactType.product_popup,
                    catalog: self.parameters.catalogName,
                    productId: self.parameters.productId.substr(1, 8),
                    ready: function () {
                        context.layout.hideLoadingIcon(popup.content);
                    }
                });
            }
        }
	}

	return {
		card: card
	}
});

jQuery.fn.mascusProductCard = function(parameters) {
	return this.each(function() {
		var container = $(this);
		var card = new mascus.product.card(container, parameters);
	});
};

$(window).scroll(function () {
    if (eventFired == false) {
        if (isScrolledIntoView($('.contact-form'))) {
            dlP('addToCart', '', '');
            eventFired = true;
        }
    }

    if ($(window).scrollTop() > 90) {
        $("#top-sticker").removeClass("hidden");
        if ($('.sticker-model').width() > 470) {
            $('.sticker-model').css('width', '470px');
        }
    }
    else {
        $("#top-sticker").addClass("hidden");
    }
})

function isScrolledIntoView(elem) { 
   if ((typeof elem !== 'undefined') && (elem != null) && (typeof $(elem) !== 'undefined') && ($(elem) != null) && ($(elem).length))
   { 
        var $elem = $(elem);
        var $window = $(window);

        var docViewTop = $window.scrollTop();
        var docViewBottom = docViewTop + $window.height();

        var elemTop = $elem.offset().top;
        var elemBottom = elemTop + $elem.height();

        return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
    }
    else
    {
        return false;
    }
}

function pcShowAllRegions() {
    $('#allRegionsToggle').hide();
    $('#pcAllRegions').slideToggle("slow", function () {
        // Animation complete.
    });
}
/*
 * blueimp Gallery JS 2.14.1
 * https://github.com/blueimp/Gallery
 *
 * Copyright 2013, Sebastian Tschan
 * https://blueimp.net
 *
 * Swipe implementation based on
 * https://github.com/bradbirdsall/Swipe
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/* global define, window, document, DocumentTouch */

(function (factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        // Register as an anonymous AMD module:
        define(['./blueimp-helper'], factory);
    } else {
        // Browser globals:
        window.blueimp = window.blueimp || {};
        window.blueimp.Gallery = factory(
            window.blueimp.helper || window.jQuery
        );
    }
}(function ($) {
    'use strict';

    function Gallery(list, options) {
        if (document.body.style.maxHeight === undefined) {
            // document.body.style.maxHeight is undefined on IE6 and lower
            return null;
        }
        if (!this || this.options !== Gallery.prototype.options) {
            // Called as function instead of as constructor,
            // so we simply return a new instance:
            return new Gallery(list, options);
        }
        if (!list || !list.length) {
            this.console.log(
                'blueimp Gallery: No or empty list provided as first argument.',
                list
            );
            return;
        }
        this.list = list;
        this.num = list.length;
        this.initOptions(options);
        this.initialize();
    }

    $.extend(Gallery.prototype, {

        options: {
            // The Id, element or querySelector of the gallery widget:
            container: '#blueimp-gallery',
            // The tag name, Id, element or querySelector of the slides container:
            slidesContainer: 'div',
            // The tag name, Id, element or querySelector of the title element:
            titleElement: 'h3',
            // The class to add when the gallery is visible:
            displayClass: 'blueimp-gallery-display',
            // The class to add when the gallery controls are visible:
            controlsClass: 'blueimp-gallery-controls',
            // The class to add when the gallery only displays one element:
            singleClass: 'blueimp-gallery-single',
            // The class to add when the left edge has been reached:
            leftEdgeClass: 'blueimp-gallery-left',
            // The class to add when the right edge has been reached:
            rightEdgeClass: 'blueimp-gallery-right',
            // The class to add when the automatic slideshow is active:
            playingClass: 'blueimp-gallery-playing',
            // The class for all slides:
            slideClass: 'slide',
            // The slide class for loading elements:
            slideLoadingClass: 'slide-loading',
            // The slide class for elements that failed to load:
            slideErrorClass: 'slide-error',
            // The class for the content element loaded into each slide:
            slideContentClass: 'slide-content',
            // The class for the "toggle" control:
            toggleClass: 'toggle',
            // The class for the "prev" control:
            prevClass: 'prev',
            // The class for the "next" control:
            nextClass: 'next',
            // The class for the "close" control:
            closeClass: 'close',
            // The class for the "play-pause" toggle control:
            playPauseClass: 'play-pause',
            // The list object property (or data attribute) with the object type:
            typeProperty: 'type',
            // The list object property (or data attribute) with the object title:
            titleProperty: 'title',
            // The list object property (or data attribute) with the object URL:
            urlProperty: 'href',
            // The gallery listens for transitionend events before triggering the
            // opened and closed events, unless the following option is set to false:
            displayTransition: true,
            // Defines if the gallery slides are cleared from the gallery modal,
            // or reused for the next gallery initialization:
            clearSlides: true,
            // Defines if images should be stretched to fill the available space,
            // while maintaining their aspect ratio (will only be enabled for browsers
            // supporting background-size="contain", which excludes IE < 9).
            // Set to "cover", to make images cover all available space (requires
            // support for background-size="cover", which excludes IE < 9):
            stretchImages: false,
            // Toggle the controls on pressing the Return key:
            toggleControlsOnReturn: true,
            // Toggle the automatic slideshow interval on pressing the Space key:
            toggleSlideshowOnSpace: true,
            // Navigate the gallery by pressing left and right on the keyboard:
            enableKeyboardNavigation: true,
            // Close the gallery on pressing the Esc key:
            closeOnEscape: true,
            // Close the gallery when clicking on an empty slide area:
            closeOnSlideClick: true,
            // Close the gallery by swiping up or down:
            closeOnSwipeUpOrDown: true,
            // Emulate touch events on mouse-pointer devices such as desktop browsers:
            emulateTouchEvents: true,
            // Stop touch events from bubbling up to ancestor elements of the Gallery:
            stopTouchEventsPropagation: false,
            // Hide the page scrollbars:
            hidePageScrollbars: true,
            // Stops any touches on the container from scrolling the page:
            disableScroll: true,
            // Carousel mode (shortcut for carousel specific options):
            carousel: false,
            // Allow continuous navigation, moving from last to first
            // and from first to last slide:
            continuous: true,
            // Remove elements outside of the preload range from the DOM:
            unloadElements: true,
            // Start with the automatic slideshow:
            startSlideshow: false,
            // Delay in milliseconds between slides for the automatic slideshow:
            slideshowInterval: 5000,
            // The starting index as integer.
            // Can also be an object of the given list,
            // or an equal object with the same url property:
            index: 0,
            // The number of elements to load around the current index:
            preloadRange: 2,
            // The transition speed between slide changes in milliseconds:
            transitionSpeed: 400,
            // The transition speed for automatic slide changes, set to an integer
            // greater 0 to override the default transition speed:
            slideshowTransitionSpeed: undefined,
            // The event object for which the default action will be canceled
            // on Gallery initialization (e.g. the click event to open the Gallery):
            event: undefined,
            // Callback function executed when the Gallery is initialized.
            // Is called with the gallery instance as "this" object:
            onopen: undefined,
            // Callback function executed when the Gallery has been initialized
            // and the initialization transition has been completed.
            // Is called with the gallery instance as "this" object:
            onopened: undefined,
            // Callback function executed on slide change.
            // Is called with the gallery instance as "this" object and the
            // current index and slide as arguments:
            onslide: undefined,
            // Callback function executed after the slide change transition.
            // Is called with the gallery instance as "this" object and the
            // current index and slide as arguments:
            onslideend: undefined,
            // Callback function executed on slide content load.
            // Is called with the gallery instance as "this" object and the
            // slide index and slide element as arguments:
            onslidecomplete: undefined,
            // Callback function executed when the Gallery is about to be closed.
            // Is called with the gallery instance as "this" object:
            onclose: undefined,
            // Callback function executed when the Gallery has been closed
            // and the closing transition has been completed.
            // Is called with the gallery instance as "this" object:
            onclosed: undefined
        },

        carouselOptions: {
            hidePageScrollbars: false,
            toggleControlsOnReturn: false,
            toggleSlideshowOnSpace: false,
            enableKeyboardNavigation: false,
            closeOnEscape: false,
            closeOnSlideClick: false,
            closeOnSwipeUpOrDown: false,
            disableScroll: false,
            startSlideshow: true
        },

        console: window.console && typeof window.console.log === 'function' ?
            window.console :
            { log: function () { } },

        // Detect touch, transition, transform and background-size support:
        support: (function (element) {
            var support = {
                touch: window.ontouchstart !== undefined ||
                    (window.DocumentTouch && document instanceof DocumentTouch)
            },
                transitions = {
                    webkitTransition: {
                        end: 'webkitTransitionEnd',
                        prefix: '-webkit-'
                    },
                    MozTransition: {
                        end: 'transitionend',
                        prefix: '-moz-'
                    },
                    OTransition: {
                        end: 'otransitionend',
                        prefix: '-o-'
                    },
                    transition: {
                        end: 'transitionend',
                        prefix: ''
                    }
                },
                elementTests = function () {
                    var transition = support.transition,
                        prop,
                        translateZ;
                    document.body.appendChild(element);
                    if (transition) {
                        prop = transition.name.slice(0, -9) + 'ransform';
                        if (element.style[prop] !== undefined) {
                            element.style[prop] = 'translateZ(0)';
                            translateZ = window.getComputedStyle(element)
                                .getPropertyValue(transition.prefix + 'transform');
                            support.transform = {
                                prefix: transition.prefix,
                                name: prop,
                                translate: true,
                                translateZ: !!translateZ && translateZ !== 'none'
                            };
                        }
                    }
                    if (element.style.backgroundSize !== undefined) {
                        support.backgroundSize = {};
                        element.style.backgroundSize = 'contain';
                        support.backgroundSize.contain = window
                                .getComputedStyle(element)
                                .getPropertyValue('background-size') === 'contain';
                        element.style.backgroundSize = 'cover';
                        support.backgroundSize.cover = window
                                .getComputedStyle(element)
                                .getPropertyValue('background-size') === 'cover';
                    }
                    document.body.removeChild(element);
                };
            (function (support, transitions) {
                var prop;
                for (prop in transitions) {
                    if (transitions.hasOwnProperty(prop) &&
                            element.style[prop] !== undefined) {
                        support.transition = transitions[prop];
                        support.transition.name = prop;
                        break;
                    }
                }
            }(support, transitions));
            if (document.body) {
                elementTests();
            } else {
                $(document).on('DOMContentLoaded', elementTests);
            }
            return support;
            // Test element, has to be standard HTML and must not be hidden
            // for the CSS3 tests using window.getComputedStyle to be applicable:
        }(document.createElement('div'))),

        requestAnimationFrame: window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame,

        initialize: function () {
            this.initStartIndex();
            if (this.initWidget() === false) {
                return false;
            }
            this.initEventListeners();
            // Load the slide at the given index:s
            this.onslide(this.index);
            // Manually trigger the slideend event for the initial slide:
            this.ontransitionend();
            // Start the automatic slideshow if applicable:
            if (this.options.startSlideshow) {
                this.play();
            }
            this.container.addClass('blueimp-gallery-controls');


        
        },

        slide: function (to, speed) {
            window.clearTimeout(this.timeout);
            var index = this.index,
                direction,
                naturalDirection,
                diff;
            if (index === to || this.num === 1) {
                return;
            }
            if (!speed) {
                speed = this.options.transitionSpeed;
            }
            if (this.support.transform) {
                if (!this.options.continuous) {
                    to = this.circle(to);
                }
                // 1: backward, -1: forward:
                direction = Math.abs(index - to) / (index - to);
                // Get the actual position of the slide:
                if (this.options.continuous) {
                    naturalDirection = direction;
                    direction = -this.positions[this.circle(to)] / this.slideWidth;
                    // If going forward but to < index, use to = slides.length + to
                    // If going backward but to > index, use to = -slides.length + to
                    if (direction !== naturalDirection) {
                        to = -direction * this.num + to;
                    }
                }
                diff = Math.abs(index - to) - 1;
                // Move all the slides between index and to in the right direction:
                while (diff) {
                    diff -= 1;
                    this.move(
                        this.circle((to > index ? to : index) - diff - 1),
                        this.slideWidth * direction,
                        0
                    );
                }
                to = this.circle(to);
                this.move(index, this.slideWidth * direction, speed);
                this.move(to, 0, speed);
                if (this.options.continuous) {
                    this.move(
                        this.circle(to - direction),
                        -(this.slideWidth * direction),
                        0
                    );
                }
            } else {
                to = this.circle(to);
                this.animate(index * -this.slideWidth, to * -this.slideWidth, speed);
            }
            this.onslide(to);
        },

        getIndex: function () {
            return this.index;
        },

        getNumber: function () {
            return this.num;
        },

        prev: function () {
            if (this.options.continuous || this.index) {
                this.slide(this.index - 1);
            }
        },

        next: function () {
            if (this.options.continuous || this.index < this.num - 1) {
                this.slide(this.index + 1);
            }
        },

        play: function (time) {
            var that = this;
            window.clearTimeout(this.timeout);
            this.interval = time || this.options.slideshowInterval;
            if (this.elements[this.index] > 1) {
                this.timeout = this.setTimeout(
                    (!this.requestAnimationFrame && this.slide) || function (to, speed) {
                        that.animationFrameId = that.requestAnimationFrame.call(
                            window,
                            function () {
                                that.slide(to, speed);
                            }
                        );
                    },
                    [this.index + 1, this.options.slideshowTransitionSpeed],
                    this.interval
                );
            }
            this.container.addClass(this.options.playingClass);
        },

        pause: function () {
            window.clearTimeout(this.timeout);
            this.interval = null;
            this.container.removeClass(this.options.playingClass);
        },

        add: function (list) {
            var i;
            if (!list.concat) {
                // Make a real array out of the list to add:
                list = Array.prototype.slice.call(list);
            }
            if (!this.list.concat) {
                // Make a real array out of the Gallery list:
                this.list = Array.prototype.slice.call(this.list);
            }
            this.list = this.list.concat(list);
            this.num = this.list.length;
            if (this.num > 2 && this.options.continuous === null) {
                this.options.continuous = true;
                this.container.removeClass(this.options.leftEdgeClass);
            }
            this.container
                .removeClass(this.options.rightEdgeClass)
                .removeClass(this.options.singleClass);
            for (i = this.num - list.length; i < this.num; i += 1) {
                this.addSlide(i);
                this.positionSlide(i);
            }
            this.positions.length = this.num;
            this.initSlides(true);
        },

        resetSlides: function () {
            this.slidesContainer.empty();
            this.slides = [];
        },

        handleClose: function () {
            var options = this.options;
            this.destroyEventListeners();
            // Cancel the slideshow:
            this.pause();
            this.container[0].style.display = 'none';
            this.container
                .removeClass(options.displayClass)
                .removeClass(options.singleClass)
                .removeClass(options.leftEdgeClass)
                .removeClass(options.rightEdgeClass);
            if (options.hidePageScrollbars) {
                document.body.style.overflow = this.bodyOverflowStyle;
            }
            if (this.options.clearSlides) {
                this.resetSlides();
            }
            if (this.options.onclosed) {
                this.options.onclosed.call(this);
            }
        },

        close: function () {
            var that = this,
                closeHandler = function (event) {
                    if (event.target === that.container[0]) {
                        that.container.off(
                            that.support.transition.end,
                            closeHandler
                        );
                        that.handleClose();
                    }
                };
            if (this.options.onclose) {
                this.options.onclose.call(this);
            }
            if (this.support.transition && this.options.displayTransition) {
                this.container.on(
                    this.support.transition.end,
                    closeHandler
                );
                this.container.removeClass(this.options.displayClass);
            } else {
                this.handleClose();
            }
        },

        circle: function (index) {
            // Always return a number inside of the slides index range:
            return (this.num + (index % this.num)) % this.num;
        },

        move: function (index, dist, speed) {
            this.translateX(index, dist, speed);
            this.positions[index] = dist;
        },

        translate: function (index, x, y, speed) {
            var style = this.slides[index].style,
                transition = this.support.transition,
                transform = this.support.transform;
            style[transition.name + 'Duration'] = speed + 'ms';
            style[transform.name] = 'translate(' + x + 'px, ' + y + 'px)' +
                (transform.translateZ ? ' translateZ(0)' : '');
        },

        translateX: function (index, x, speed) {
            this.translate(index, x, 0, speed);
        },

        translateY: function (index, y, speed) {
            this.translate(index, 0, y, speed);
        },

        animate: function (from, to, speed) {
            if (!speed) {
                this.slidesContainer[0].style.left = to + 'px';
                return;
            }
            var that = this,
                start = new Date().getTime(),
                timer = window.setInterval(function () {
                    var timeElap = new Date().getTime() - start;
                    if (timeElap > speed) {
                        that.slidesContainer[0].style.left = to + 'px';
                        that.ontransitionend();
                        window.clearInterval(timer);
                        return;
                    }
                    that.slidesContainer[0].style.left = (((to - from) *
                        (Math.floor((timeElap / speed) * 100) / 100)) +
                            from) + 'px';
                }, 4);
        },

        preventDefault: function (event) {
            if (event.preventDefault) {
                event.preventDefault();
            } else {
                event.returnValue = false;
            }
        },

        stopPropagation: function (event) {
            if (event.stopPropagation) {
                event.stopPropagation();
            } else {
                event.cancelBubble = true;
            }
        },

        onresize: function () {
            this.initSlides(true);
        },

        onmousedown: function (event) {
            // Trigger on clicks of the left mouse button only
            // and exclude video elements:
            if (event.which && event.which === 1 &&
                    event.target.nodeName !== 'VIDEO') {
                // Preventing the default mousedown action is required
                // to make touch emulation work with Firefox:
                event.preventDefault();
                (event.originalEvent || event).touches = [{
                    pageX: event.pageX,
                    pageY: event.pageY
                }];
                this.ontouchstart(event);
            }
        },

        onmousemove: function (event) {
            if (this.touchStart) {
                (event.originalEvent || event).touches = [{
                    pageX: event.pageX,
                    pageY: event.pageY
                }];
                this.ontouchmove(event);
            }
        },

        onmouseup: function (event) {
            if (this.touchStart) {
                this.ontouchend(event);
                delete this.touchStart;
            }
        },

        onmouseout: function (event) {
            if (this.touchStart) {
                var target = event.target,
                    related = event.relatedTarget;
                if (!related || (related !== target &&
                        !$.contains(target, related))) {
                    this.onmouseup(event);
                }
            }
        },

        ontouchstart: function (event) {
            if (this.options.stopTouchEventsPropagation) {
                this.stopPropagation(event);
            }
            // jQuery doesn't copy touch event properties by default,
            // so we have to access the originalEvent object:
            var touches = (event.originalEvent || event).touches[0];
            this.touchStart = {
                // Remember the initial touch coordinates:
                x: touches.pageX,
                y: touches.pageY,
                // Store the time to determine touch duration:
                time: Date.now()
            };
            // Helper variable to detect scroll movement:
            this.isScrolling = undefined;
            // Reset delta values:
            this.touchDelta = {};
        },

        ontouchmove: function (event) {
            if (this.options.stopTouchEventsPropagation) {
                this.stopPropagation(event);
            }
            // jQuery doesn't copy touch event properties by default,
            // so we have to access the originalEvent object:
            var touches = (event.originalEvent || event).touches[0],
                scale = (event.originalEvent || event).scale,
                index = this.index,
                touchDeltaX,
                indices;
            // Ensure this is a one touch swipe and not, e.g. a pinch:
            if (touches.length > 1 || (scale && scale !== 1)) {
                return;
            }
            if (this.options.disableScroll) {
                event.preventDefault();
            }
            // Measure change in x and y coordinates:
            this.touchDelta = {
                x: touches.pageX - this.touchStart.x,
                y: touches.pageY - this.touchStart.y
            };
            touchDeltaX = this.touchDelta.x;
            // Detect if this is a vertical scroll movement (run only once per touch):
            if (this.isScrolling === undefined) {
                this.isScrolling = this.isScrolling ||
                    Math.abs(touchDeltaX) < Math.abs(this.touchDelta.y);
            }
            if (!this.isScrolling) {
                // Always prevent horizontal scroll:
                event.preventDefault();
                // Stop the slideshow:
                window.clearTimeout(this.timeout);
                if (this.options.continuous) {
                    indices = [
                        this.circle(index + 1),
                        index,
                        this.circle(index - 1)
                    ];
                } else {
                    // Increase resistance if first slide and sliding left
                    // or last slide and sliding right:
                    this.touchDelta.x = touchDeltaX =
                        touchDeltaX /
                        (((!index && touchDeltaX > 0) ||
                            (index === this.num - 1 && touchDeltaX < 0)) ?
                                (Math.abs(touchDeltaX) / this.slideWidth + 1) : 1);
                    indices = [index];
                    if (index) {
                        indices.push(index - 1);
                    }
                    if (index < this.num - 1) {
                        indices.unshift(index + 1);
                    }
                }
                while (indices.length) {
                    index = indices.pop();
                    this.translateX(index, touchDeltaX + this.positions[index], 0);
                }
            } else if (this.options.closeOnSwipeUpOrDown) {
                this.translateY(index, this.touchDelta.y + this.positions[index], 0);
            }
        },

        ontouchend: function (event) {
            if (this.options.stopTouchEventsPropagation) {
                this.stopPropagation(event);
            }
            var index = this.index,
                speed = this.options.transitionSpeed,
                slideWidth = this.slideWidth,
                isShortDuration = Number(Date.now() - this.touchStart.time) < 250,
                // Determine if slide attempt triggers next/prev slide:
                isValidSlide = (isShortDuration && Math.abs(this.touchDelta.x) > 20) ||
                    Math.abs(this.touchDelta.x) > slideWidth / 2,
                // Determine if slide attempt is past start or end:
                isPastBounds = (!index && this.touchDelta.x > 0) ||
                        (index === this.num - 1 && this.touchDelta.x < 0),
                isValidClose = !isValidSlide && this.options.closeOnSwipeUpOrDown &&
                    ((isShortDuration && Math.abs(this.touchDelta.y) > 20) ||
                        Math.abs(this.touchDelta.y) > this.slideHeight / 2),
                direction,
                indexForward,
                indexBackward,
                distanceForward,
                distanceBackward;
            if (this.options.continuous) {
                isPastBounds = false;
            }
            // Determine direction of swipe (true: right, false: left):
            direction = this.touchDelta.x < 0 ? -1 : 1;
            if (!this.isScrolling) {
                if (isValidSlide && !isPastBounds) {
                    indexForward = index + direction;
                    indexBackward = index - direction;
                    distanceForward = slideWidth * direction;
                    distanceBackward = -slideWidth * direction;
                    if (this.options.continuous) {
                        this.move(this.circle(indexForward), distanceForward, 0);
                        this.move(this.circle(index - 2 * direction), distanceBackward, 0);
                    } else if (indexForward >= 0 &&
                            indexForward < this.num) {
                        this.move(indexForward, distanceForward, 0);
                    }
                    this.move(index, this.positions[index] + distanceForward, speed);
                    this.move(
                        this.circle(indexBackward),
                        this.positions[this.circle(indexBackward)] + distanceForward,
                        speed
                    );
                    index = this.circle(indexBackward);
                    this.onslide(index);
                } else {
                    // Move back into position
                    if (this.options.continuous) {
                        this.move(this.circle(index - 1), -slideWidth, speed);
                        this.move(index, 0, speed);
                        this.move(this.circle(index + 1), slideWidth, speed);
                    } else {
                        if (index) {
                            this.move(index - 1, -slideWidth, speed);
                        }
                        this.move(index, 0, speed);
                        if (index < this.num - 1) {
                            this.move(index + 1, slideWidth, speed);
                        }
                    }
                }
            } else {
                if (isValidClose) {
                    this.close();
                } else {
                    // Move back into position
                    this.translateY(index, 0, speed);
                }
            }
        },

        ontouchcancel: function (event) {
            if (this.touchStart) {
                this.ontouchend(event);
                delete this.touchStart;
            }
        },

        ontransitionend: function (event) {
            var slide = this.slides[this.index];
            if (!event || slide === event.target) {
                if (this.interval) {
                    this.play();
                }
                this.setTimeout(
                    this.options.onslideend,
                    [this.index, slide]
                );
            }
        },

        oncomplete: function (event) {
            var target = event.target || event.srcElement,
                parent = target && target.parentNode,
                index;
            if (!target || !parent) {
                return;
            }
            index = this.getNodeIndex(parent);
            $(parent).removeClass(this.options.slideLoadingClass);
            if (event.type === 'error') {
                $(parent).addClass(this.options.slideErrorClass);
                this.elements[index] = 3; // Fail
            } else {
                this.elements[index] = 2; // Done
            }
            // Fix for IE7's lack of support for percentage max-height:
            if (target.clientHeight > this.container[0].clientHeight) {
                target.style.maxHeight = this.container[0].clientHeight;
            }
            if (this.interval && this.slides[this.index] === parent) {
                this.play();
            }
            this.setTimeout(
                this.options.onslidecomplete,
                [index, parent]
            );
        },

        onload: function (event) {
            this.oncomplete(event);
        },

        onerror: function (event) {
            this.oncomplete(event);
        },

        onkeydown: function (event) {
            switch (event.which || event.keyCode) {
                case 13: // Return
                    if (this.options.toggleControlsOnReturn) {
                        this.preventDefault(event);
                        this.toggleControls();
                    }
                    break;
                case 27: // Esc
                    if (this.options.closeOnEscape) {
                        this.close();
                    }
                    break;
                case 32: // Space
                    if (this.options.toggleSlideshowOnSpace) {
                        this.preventDefault(event);
                        this.toggleSlideshow();
                    }
                    break;
                case 37: // Left
                    if (this.options.enableKeyboardNavigation) {
                        this.preventDefault(event);
                        this.prev();
                    }
                    break;
                case 39: // Right
                    if (this.options.enableKeyboardNavigation) {
                        this.preventDefault(event);
                        this.next();
                    }
                    break;
            }
        },

        handleClick: function (event) {
            var options = this.options,
                target = event.target || event.srcElement,
                parent = target.parentNode,
                isTarget = function (className) {
                    return $(target).hasClass(className) ||
                        $(parent).hasClass(className);
                };
            if (isTarget(options.toggleClass)) {
                // Click on "toggle" control
                this.preventDefault(event);
                this.toggleControls();
            } else if (isTarget(options.prevClass)) {
                // Click on "prev" control
                this.preventDefault(event);
                this.prev();
            } else if (isTarget(options.nextClass)) {
                // Click on "next" control
                this.preventDefault(event);
                this.next();
            } else if (isTarget(options.closeClass)) {
                // Click on "close" control
                this.preventDefault(event);
                this.close();
            } else if (isTarget(options.playPauseClass)) {
                // Click on "play-pause" control
                this.preventDefault(event);
                this.toggleSlideshow();
            } else if (parent === this.slidesContainer[0]) {
                // Click on slide background
                this.preventDefault(event);
                if (options.closeOnSlideClick) {
                    this.close();
                } else {
                    this.toggleControls();
                }
            } else if (parent.parentNode &&
                    parent.parentNode === this.slidesContainer[0]) {
                // Click on displayed element
                this.preventDefault(event);
                this.toggleControls();
            }
        },

        onclick: function (event) {
            if (this.options.emulateTouchEvents &&
                    this.touchDelta && (Math.abs(this.touchDelta.x) > 20 ||
                        Math.abs(this.touchDelta.y) > 20)) {
                delete this.touchDelta;
                return;
            }
            return this.handleClick(event);
        },

        updateEdgeClasses: function (index) {
            if (!index) {
                this.container.addClass(this.options.leftEdgeClass);
            } else {
                this.container.removeClass(this.options.leftEdgeClass);
            }
            if (index === this.num - 1) {
                this.container.addClass(this.options.rightEdgeClass);
            } else {
                this.container.removeClass(this.options.rightEdgeClass);
            }
        },

        handleSlide: function (index) {
            if (!this.options.continuous) {
                this.updateEdgeClasses(index);
            }
            this.loadElements(index);
            if (this.options.unloadElements) {
                this.unloadElements(index);
            }
            this.setTitle(index);
        },

        onslide: function (index) {
            this.index = index;
            this.handleSlide(index);
            this.setTimeout(this.options.onslide, [index, this.slides[index]]);
        },

        setTitle: function (index) {
            var text = this.slides[index].firstChild.title,
                titleElement = this.titleElement;
            if (titleElement.length) {
                this.titleElement.empty();
                if (text) {
                    titleElement[0].appendChild(document.createTextNode(text));
                }
            }
        },

        setTimeout: function (func, args, wait) {
            var that = this;
            return func && window.setTimeout(function () {
                func.apply(that, args || []);
            }, wait || 0);
        },

        imageFactory: function (obj, callback) {
            var that = this,
                img = this.imagePrototype.cloneNode(false),
                url = obj,
                backgroundSize = this.options.stretchImages,
                called,
                element,
                callbackWrapper = function (event) {
                    if (!called) {
                        event = {
                            type: event.type,
                            target: element
                        };
                        if (!element.parentNode) {
                            // Fix for IE7 firing the load event for
                            // cached images before the element could
                            // be added to the DOM:
                            return that.setTimeout(callbackWrapper, [event]);
                        }
                        called = true;
                        $(img).off('load error', callbackWrapper);
                        if (backgroundSize) {
                            if (event.type === 'load') {
                                element.style.background = 'url("' + url +
                                    '") center no-repeat';
                                element.style.backgroundSize = backgroundSize;
                            }
                        }
                        callback(event);
                    }
                },
                title;
            if (typeof url !== 'string') {
                url = this.getItemProperty(obj, this.options.urlProperty);
                title = this.getItemProperty(obj, this.options.titleProperty);
            }
            if (backgroundSize === true) {
                backgroundSize = 'contain';
            }
            backgroundSize = this.support.backgroundSize &&
                this.support.backgroundSize[backgroundSize] && backgroundSize;
            if (backgroundSize) {
                element = this.elementPrototype.cloneNode(false);
            } else {
                element = img;
                img.draggable = false;
            }
            if (title) {
                element.title = title;
            }
            $(img).on('load error', callbackWrapper);
            img.src = url;
            return element;
        },

        createElement: function (obj, callback) {
            var type = obj && this.getItemProperty(obj, this.options.typeProperty),
                factory = (type && this[type.split('/')[0] + 'Factory']) ||
                    this.imageFactory,
                element = obj && factory.call(this, obj, callback);
            if (!element) {
                element = this.elementPrototype.cloneNode(false);
                this.setTimeout(callback, [{
                    type: 'error',
                    target: element
                }]);
            }
            $(element).addClass(this.options.slideContentClass);
            return element;
        },

        loadElement: function (index) {
            if (!this.elements[index]) {
                if (this.slides[index].firstChild) {
                    this.elements[index] = $(this.slides[index])
                        .hasClass(this.options.slideErrorClass) ? 3 : 2;
                } else {
                    this.elements[index] = 1; // Loading
                    $(this.slides[index]).addClass(this.options.slideLoadingClass);
                    this.slides[index].appendChild(this.createElement(
                        this.list[index],
                        this.proxyListener
                    ));
                }
            }
        },

        loadElements: function (index) {
            var limit = Math.min(this.num, this.options.preloadRange * 2 + 1),
                j = index,
                i;
            for (i = 0; i < limit; i += 1) {
                // First load the current slide element (0),
                // then the next one (+1),
                // then the previous one (-2),
                // then the next after next (+2), etc.:
                j += i * (i % 2 === 0 ? -1 : 1);
                // Connect the ends of the list to load slide elements for
                // continuous navigation:
                j = this.circle(j);
                this.loadElement(j);
            }
        },

        unloadElements: function (index) {
            var i,
                slide,
                diff;
            for (i in this.elements) {
                if (this.elements.hasOwnProperty(i)) {
                    diff = Math.abs(index - i);
                    if (diff > this.options.preloadRange &&
                            diff + this.options.preloadRange < this.num) {
                        slide = this.slides[i];
                        slide.removeChild(slide.firstChild);
                        delete this.elements[i];
                    }
                }
            }
        },

        addSlide: function (index) {
            var slide = this.slidePrototype.cloneNode(false);
            slide.setAttribute('data-index', index);
            this.slidesContainer[0].appendChild(slide);
            this.slides.push(slide);
        },

        positionSlide: function (index) {
            var slide = this.slides[index];
            slide.style.width = this.slideWidth + 'px';
            if (this.support.transform) {
                slide.style.left = (index * -this.slideWidth) + 'px';
                this.move(index, this.index > index ? -this.slideWidth :
                        (this.index < index ? this.slideWidth : 0), 0);
            }
        },

        initSlides: function (reload) {
            var clearSlides,
                i;
            if (!reload) {
                this.positions = [];
                this.positions.length = this.num;
                this.elements = {};
                this.imagePrototype = document.createElement('img');
                this.elementPrototype = document.createElement('div');
                this.slidePrototype = document.createElement('div');
                $(this.slidePrototype).addClass(this.options.slideClass);
                this.slides = this.slidesContainer[0].children;
                clearSlides = this.options.clearSlides ||
                    this.slides.length !== this.num;
            }
            this.slideWidth = this.container[0].offsetWidth;
            this.slideHeight = this.container[0].offsetHeight;
            this.slidesContainer[0].style.width =
                (this.num * this.slideWidth) + 'px';
            if (clearSlides) {
                this.resetSlides();
            }
            for (i = 0; i < this.num; i += 1) {
                if (clearSlides) {
                    this.addSlide(i);
                }
                this.positionSlide(i);
            }
            // Reposition the slides before and after the given index:
            if (this.options.continuous && this.support.transform) {
                this.move(this.circle(this.index - 1), -this.slideWidth, 0);
                this.move(this.circle(this.index + 1), this.slideWidth, 0);
            }
            if (!this.support.transform) {
                this.slidesContainer[0].style.left =
                    (this.index * -this.slideWidth) + 'px';
            }
        },

        toggleControls: function () {
            var controlsClass = this.options.controlsClass;
            if (this.container.hasClass(controlsClass)) {
                this.container.removeClass(controlsClass);
            } else {
                this.container.addClass(controlsClass);
            }
        },

        toggleSlideshow: function () {
            if (!this.interval) {
                this.play();
            } else {
                this.pause();
            }
        },

        getNodeIndex: function (element) {
            return parseInt(element.getAttribute('data-index'), 10);
        },

        getNestedProperty: function (obj, property) {
            property.replace(
                // Matches native JavaScript notation in a String,
                // e.g. '["doubleQuoteProp"].dotProp[2]'
                /\[(?:'([^']+)'|"([^"]+)"|(\d+))\]|(?:(?:^|\.)([^\.\[]+))/g,
                function (str, singleQuoteProp, doubleQuoteProp, arrayIndex, dotProp) {
                    var prop = dotProp || singleQuoteProp || doubleQuoteProp ||
                            (arrayIndex && parseInt(arrayIndex, 10));
                    if (str && obj) {
                        obj = obj[prop];
                    }
                }
            );
            return obj;
        },

        getDataProperty: function (obj, property) {
            if (obj.getAttribute) {
                var prop = obj.getAttribute('data-' +
                        property.replace(/([A-Z])/g, '-$1').toLowerCase());
                if (typeof prop === 'string') {
                    if (/^(true|false|null|-?\d+(\.\d+)?|\{[\s\S]*\}|\[[\s\S]*\])$/
                            .test(prop)) {
                        try {
                            return $.parseJSON(prop);
                        } catch (ignore) { }
                    }
                    return prop;
                }
            }
        },

        getItemProperty: function (obj, property) {
            var prop = obj[property];
            if (prop === undefined) {
                prop = this.getDataProperty(obj, property);
                if (prop === undefined) {
                    prop = this.getNestedProperty(obj, property);
                }
            }
            return prop;
        },

        initStartIndex: function () {
            var index = this.options.index,
                urlProperty = this.options.urlProperty,
                i;
            // Check if the index is given as a list object:
            if (index && typeof index !== 'number') {
                for (i = 0; i < this.num; i += 1) {
                    if (this.list[i] === index ||
                            this.getItemProperty(this.list[i], urlProperty) ===
                                this.getItemProperty(index, urlProperty)) {
                        index = i;
                        break;
                    }
                }
            }
            // Make sure the index is in the list range:
            this.index = this.circle(parseInt(index, 10) || 0);
        },

        initEventListeners: function () {
            var that = this,
                slidesContainer = this.slidesContainer,
                proxyListener = function (event) {
                    var type = that.support.transition &&
                            that.support.transition.end === event.type ?
                                    'transitionend' : event.type;
                    that['on' + type](event);
                };
            $(window).on('resize', proxyListener);
            $(document.body).on('keydown', proxyListener);
            this.container.on('click', proxyListener);
            if (this.support.touch) {
                slidesContainer
                    .on('touchstart touchmove touchend touchcancel', proxyListener);
            } else if (this.options.emulateTouchEvents &&
                    this.support.transition) {
                slidesContainer
                    .on('mousedown mousemove mouseup mouseout', proxyListener);
            }
            if (this.support.transition) {
                slidesContainer.on(
                    this.support.transition.end,
                    proxyListener
                );
            }
            this.proxyListener = proxyListener;
        },

        destroyEventListeners: function () {
            var slidesContainer = this.slidesContainer,
                proxyListener = this.proxyListener;
            $(window).off('resize', proxyListener);
            $(document.body).off('keydown', proxyListener);
            this.container.off('click', proxyListener);
            if (this.support.touch) {
                slidesContainer
                    .off('touchstart touchmove touchend touchcancel', proxyListener);
            } else if (this.options.emulateTouchEvents &&
                    this.support.transition) {
                slidesContainer
                    .off('mousedown mousemove mouseup mouseout', proxyListener);
            }
            if (this.support.transition) {
                slidesContainer.off(
                    this.support.transition.end,
                    proxyListener
                );
            }
        },

        handleOpen: function () {
            if (this.options.onopened) {
                this.options.onopened.call(this);
            }
        },

        initWidget: function () {
            var that = this,
                openHandler = function (event) {
                    if (event.target === that.container[0]) {
                        that.container.off(
                            that.support.transition.end,
                            openHandler
                        );
                        that.handleOpen();
                    }
                };
            this.container = $(this.options.container);
            if (!this.container.length) {
                this.console.log(
                    'blueimp Gallery: Widget container not found.',
                    this.options.container
                );
                return false;
            }
            this.slidesContainer = this.container.find(
                this.options.slidesContainer
            ).first();
            if (!this.slidesContainer.length) {
                this.console.log(
                    'blueimp Gallery: Slides container not found.',
                    this.options.slidesContainer
                );
                return false;
            }
            this.titleElement = this.container.find(
                this.options.titleElement
            ).first();
            if (this.num === 1) {
                this.container.addClass(this.options.singleClass);
            }
            if (this.options.onopen) {
                this.options.onopen.call(this);
            }
            if (this.support.transition && this.options.displayTransition) {
                this.container.on(
                    this.support.transition.end,
                    openHandler
                );
            } else {
                this.handleOpen();
            }
            if (this.options.hidePageScrollbars) {
                // Hide the page scrollbars:
                this.bodyOverflowStyle = document.body.style.overflow;
                document.body.style.overflow = 'hidden';
            }
            this.container[0].style.display = 'block';
            this.initSlides();
            this.container.addClass(this.options.displayClass);
        },

        initOptions: function (options) {
            // Create a copy of the prototype options:
            this.options = $.extend({}, this.options);
            // Check if carousel mode is enabled:
            if ((options && options.carousel) ||
                    (this.options.carousel && (!options || options.carousel !== false))) {
                $.extend(this.options, this.carouselOptions);
            }
            // Override any given options:
            $.extend(this.options, options);
            if (this.num < 3) {
                // 1 or 2 slides cannot be displayed continuous,
                // remember the original option by setting to null instead of false:
                this.options.continuous = this.options.continuous ? null : false;
            }
            if (!this.support.transition) {
                this.options.emulateTouchEvents = false;
            }
            if (this.options.event) {
                this.preventDefault(this.options.event);
            }
        }

    });

    return Gallery;
}));

/*
 * blueimp Gallery Indicator JS 1.1.0
 * https://github.com/blueimp/Gallery
 *
 * Copyright 2013, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/* global define, window, document */

(function (factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        // Register as an anonymous AMD module:
        define([
            './blueimp-helper',
            './blueimp-gallery'
        ], factory);
    } else {
        // Browser globals:
        factory(
            window.blueimp.helper || window.jQuery,
            window.blueimp.Gallery
        );
    }
}(function ($, Gallery) {
    'use strict';

    if ($(window).width() < 768)
        return 0;

    $.extend(Gallery.prototype.options, {
        // The tag name, Id, element or querySelector of the indicator container:
        indicatorContainer: 'ol',
        // The class for the active indicator:
        activeIndicatorClass: 'active',
        // The list object property (or data attribute) with the thumbnail URL,
        // used as alternative to a thumbnail child element:
        thumbnailProperty: 'thumbnail',
        // Defines if the gallery indicators should display a thumbnail:
        thumbnailIndicators: true
    });

    var initSlides = Gallery.prototype.initSlides,
        addSlide = Gallery.prototype.addSlide,
        resetSlides = Gallery.prototype.resetSlides,
        handleClick = Gallery.prototype.handleClick,
        handleSlide = Gallery.prototype.handleSlide,
        handleClose = Gallery.prototype.handleClose;

    $.extend(Gallery.prototype, {

        createIndicator: function (obj) {
            var indicator = this.indicatorPrototype.cloneNode(false),
                title = this.getItemProperty(obj, this.options.titleProperty),
                thumbnailProperty = this.options.thumbnailProperty,
                thumbnailUrl,
                thumbnail;
            if (this.options.thumbnailIndicators) {
                thumbnail = obj.getElementsByTagName && $(obj).find('img')[0];
                if (thumbnail) {
                    thumbnailUrl = thumbnail.src;
                } else if (thumbnailProperty) {
                    thumbnailUrl = this.getItemProperty(obj, thumbnailProperty);
                }
                if (thumbnailUrl) {
                    indicator.style.backgroundImage = 'url("' + thumbnailUrl + '")';
                }
            }
            if (title) {
                indicator.title = title;
            }
            return indicator;
        },

        addIndicator: function (index) {
            if (this.indicatorContainer.length) {
                var indicator = this.createIndicator(this.list[index]);
                indicator.setAttribute('data-index', index);
                this.indicatorContainer[0].appendChild(indicator);
                this.indicators.push(indicator);
            }
        },

        setActiveIndicator: function (index) {
            if (this.indicators) {
                if (this.activeIndicator) {
                    this.activeIndicator
                        .removeClass(this.options.activeIndicatorClass);
                }
                this.activeIndicator = $(this.indicators[index]);
                this.activeIndicator
                    .addClass(this.options.activeIndicatorClass);
            }
        },

        initSlides: function (reload) {
            if (!reload) {
                this.indicatorContainer = this.container.find(
                    this.options.indicatorContainer
                );
                if (this.indicatorContainer.length) {
                    this.indicatorPrototype = document.createElement('li');
                    this.indicators = this.indicatorContainer[0].children;
                }
            }
            initSlides.call(this, reload);
        },

        addSlide: function (index) {
            addSlide.call(this, index);
            this.addIndicator(index);
        },

        resetSlides: function () {
            resetSlides.call(this);
            this.indicatorContainer.empty();
            this.indicators = [];
        },

        handleClick: function (event) {
            var target = event.target || event.srcElement,
                parent = target.parentNode;
            if (parent === this.indicatorContainer[0]) {
                // Click on indicator element
                this.preventDefault(event);
                this.slide(this.getNodeIndex(target));
            } else if (parent.parentNode === this.indicatorContainer[0]) {
                // Click on indicator child element
                this.preventDefault(event);
                this.slide(this.getNodeIndex(parent));
            } else {
                return handleClick.call(this, event);
            }
        },

        handleSlide: function (index) {
            handleSlide.call(this, index);
            this.setActiveIndicator(index);
        },

        handleClose: function () {
            if (this.activeIndicator) {
                this.activeIndicator
                    .removeClass(this.options.activeIndicatorClass);
            }
            handleClose.call(this);
        }

    });

    return Gallery;
}));



function replaceMain(e, id) {
    //if (e == null)
    //    return null;
    //var replacer = "";
    //if (e.id == 'links') {
    //    replacer = e.children[0].getAttribute("href");
    //    console.log('links' + e.children[0]);
    //}
    //else {
        
    //    console.log('else' + e);
    //}
    if (id) {
        document.getElementById('Master_ContentArea_Slideshow_imgMain').title = document.getElementById(id).getAttribute("title");
        document.getElementById('Master_ContentArea_Slideshow_imgMain').alt = document.getElementById(id).getAttribute("alt");
    }
    replacer = e.getAttribute("href");
    document.getElementById('Master_ContentArea_Slideshow_imgMain').src = replacer;
    
}

