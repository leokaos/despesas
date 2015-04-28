/*! angular-slick  v0.2.0 */
"use strict";angular.module("slick",[]).directive("slick",["$timeout",function(a){return{restrict:"AEC",scope:{initOnload:"@",data:"=",currentIndex:"=",accessibility:"@",adaptiveHeight:"@",arrows:"@",asNavFor:"@",appendArrows:"@",appendDots:"@",autoplay:"@",autoplaySpeed:"@",centerMode:"@",centerPadding:"@",cssEase:"@",customPaging:"&",dots:"@",draggable:"@",easing:"@",fade:"@",focusOnSelect:"@",infinite:"@",initialSlide:"@",lazyLoad:"@",onBeforeChange:"&",onAfterChange:"&",onInit:"&",onReInit:"&",onSetPosition:"&",pauseOnHover:"@",pauseOnDotsHover:"@",responsive:"=",rtl:"@",slide:"@",slidesToShow:"@",slidesToScroll:"@",speed:"@",swipe:"@",swipeToSlide:"@",touchMove:"@",touchThreshold:"@",useCSS:"@",variableWidth:"@",vertical:"@",prevArrow:"@",nextArrow:"@"},link:function(b,c,d){var e,f,g;return e=function(){return a(function(){var a;return a=$(c),a.slick("unslick"),a.find(".slick-list").remove(),a})},f=function(){return a(function(){var a,e,f;return f=$(c),null!=b.currentIndex&&(a=b.currentIndex),e=function(a,c){return b.customPaging({slick:a,index:c})},f.slick({accessibility:"false"!==b.accessibility,adaptiveHeight:"true"===b.adaptiveHeight,arrows:"false"!==b.arrows,asNavFor:b.asNavFor?b.asNavFor:void 0,appendArrows:$(b.appendArrows?b.appendArrows:c),appendDots:$(b.appendDots?b.appendDots:c),autoplay:"true"===b.autoplay,autoplaySpeed:null!=b.autoplaySpeed?parseInt(b.autoplaySpeed,10):3e3,centerMode:"true"===b.centerMode,centerPadding:b.centerPadding||"50px",cssEase:b.cssEase||"ease",customPaging:d.customPaging?e:void 0,dots:"true"===b.dots,draggable:"false"!==b.draggable,easing:b.easing||"linear",fade:"true"===b.fade,focusOnSelect:"true"===b.focusOnSelect,infinite:"false"!==b.infinite,initialSlide:b.initialSlide||0,lazyLoad:b.lazyLoad||"ondemand",beforeChange:d.onBeforeChange?b.onBeforeChange:void 0,onReInit:d.onReInit?b.onReInit:void 0,onSetPosition:d.onSetPosition?b.onSetPosition:void 0,pauseOnHover:"false"!==b.pauseOnHover,responsive:b.responsive||void 0,rtl:"true"===b.rtl,slide:b.slide||"div",slidesToShow:null!=b.slidesToShow?parseInt(b.slidesToShow,10):1,slidesToScroll:null!=b.slidesToScroll?parseInt(b.slidesToScroll,10):1,speed:null!=b.speed?parseInt(b.speed,10):300,swipe:"false"!==b.swipe,swipeToSlide:"true"===b.swipeToSlide,touchMove:"false"!==b.touchMove,touchThreshold:b.touchThreshold?parseInt(b.touchThreshold,10):5,useCSS:"false"!==b.useCSS,variableWidth:"true"===b.variableWidth,vertical:"true"===b.vertical,prevArrow:b.prevArrow?$(b.prevArrow):void 0,nextArrow:b.nextArrow?$(b.nextArrow):void 0}),f.on("init",function(c){return d.onInit&&b.onInit(),null!=a?c.slideHandler(a):void 0}),f.on("afterChange",function(c,d,e){return b.onAfterChange&&b.onAfterChange(),null!=a?b.$apply(function(){return a=e,b.currentIndex=e}):void 0}),b.$watch("currentIndex",function(b){return null!=a&&null!=b&&b!==a?f.slick("slickGoTo",b):void 0})})},b.initOnload?(g=!1,b.$watch("data",function(a){return null!=a?(g&&e(),f(),g=!0):void 0})):f()}}}]);