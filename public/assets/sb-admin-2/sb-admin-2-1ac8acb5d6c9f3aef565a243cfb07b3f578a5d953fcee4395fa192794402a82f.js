$(function(){$("#side-menu").metisMenu()}),$(function(){$(window).bind("load resize",function(){topOffset=50,width=0<this.window.innerWidth?this.window.innerWidth:this.screen.width,width<768?($("div.navbar-collapse").addClass("collapse"),topOffset=100):$("div.navbar-collapse").removeClass("collapse"),height=(0<this.window.innerHeight?this.window.innerHeight:this.screen.height)-1,height-=topOffset,height<1&&(height=1),height>topOffset&&$("#page-wrapper").css("min-height",height+"px")});var i=window.location,e=$("ul.nav a").filter(function(){return this.href==i}).addClass("active").parents("ul").addClass("in");e.is("li")&&e.addClass("active")});