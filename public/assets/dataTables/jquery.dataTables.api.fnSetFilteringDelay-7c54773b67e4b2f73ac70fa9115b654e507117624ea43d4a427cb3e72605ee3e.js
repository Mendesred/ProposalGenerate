jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay=function(n,a){var u=this;return a===undefined&&(a=250),this.each(function(n){$.fn.dataTableExt.iApiIndex=n;var t=null,e=null,i=$("input",u.fnSettings().aanFeatures.f);return i.off("keyup search input").on("keyup search input",function(){null!==e&&e==i.val()||(window.clearTimeout(t),e=i.val(),t=window.setTimeout(function(){$.fn.dataTableExt.iApiIndex=n,u.fnFilter(i.val())},a))}),this}),this};