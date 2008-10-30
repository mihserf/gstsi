// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function fixPNG(element)
{
  if (/MSIE (5\.5|6).+Win/.test(navigator.userAgent))
  {
    var src;
    if (element.tagName=='IMG')
    {
      if (/\.png$/.test(element.src))
      {
        src = element.src;
        element.src = "image/blank.gif";
      }
    }
    else
    {

      src = element.currentStyle.backgroundImage.match(/url\("(.+\.png)"\)/i);
      if (src)
      {
        src = src[1];
        element.runtimeStyle.backgroundImage="none";
      }
    }
    if (src) element.runtimeStyle.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod='scale')";
  }
}

var browser_name = navigator.appName;
var browser_version = parseFloat(navigator.appVersion);
ie=false;
if (browser_name=="Microsoft Internet Explorer") ie=true;



$(document).ready(function(){
    $(".toggle_link_change").click(function(){$(this).next(".toggle_div").toggle("fast"); if ($(this).text()=="Read more") {$(this).text("Hide");} else {$(this).text("Read more")}  return false});
    $(".toggle_button").click(function(){$(this).next(".toggle_div").toggle("fast"); if ($(this).find("img").attr({src:'/images/max_ico.gif'})) {$(this).find("img").attr({src:'/images/min_ico.gif'});} else {$(this).find("img").attr({src:'/images/max_ico.gif'})}  return false});
    $(".toggle_div").toggle();
    $(".toggle_div_display").toggle(); // показывает див, скрытый вышеидущей командой, используется например в списке стран
    $(".toggle_link").click(function(){$(this).parent().find(".toggle_div").toggle("fast");   return false});
});

