!function(n){var t={tooltip:{show:!1,cssClass:"flotTip",content:"%s | X: %x | Y: %y",xDateFormat:null,yDateFormat:null,monthNames:null,dayNames:null,shifts:{x:10,y:20},defaultTheme:!0,lines:!1,onHover:function(){},$compat:!1}};t.tooltipOpts=t.tooltip;var e=function(t){this.tipPosition={x:0,y:0},this.init(t)};e.prototype.init=function(f){function i(t){var e={};e.x=t.pageX,e.y=t.pageY,f.setTooltipPosition(e)}function o(t,d,e){var c=function(t,e,i,o){return Math.sqrt((i-t)*(i-t)+(o-e)*(o-e))},x=function(i,o,s,n,a,p,t){if(!t||(t=function(){if(void 0!==s)return{x:s,y:o};if(void 0!==n)return{x:i,y:n};var t,e=-1/((p-n)/(a-s));return{x:t=(a*(i*e-o+n)+s*(i*-e+o-p))/(e*(a-s)+n-p),y:e*t-e*i+o}}()).x>=Math.min(s,a)&&t.x<=Math.max(s,a)&&t.y>=Math.min(n,p)&&t.y<=Math.max(n,p)){var e=n-p,r=a-s,l=s*p-n*a;return Math.abs(e*i+r*o+l)/Math.sqrt(e*e+r*r)}var d=c(i,o,s,n),x=c(i,o,a,p);return x<d?x:d};if(e)f.showTooltip(e,d);else if(s.plotOptions.series.lines.show&&!0===s.tooltipOptions.lines){var i=s.plotOptions.grid.mouseActiveRadius,u={distance:i+1};n.each(f.getData(),function(t,e){for(var i=0,o=-1,s=1;s<e.data.length;s++)e.data[s-1][0]<=d.x&&e.data[s][0]>=d.x&&(i=s-1,o=s);if(-1!==o){var n={x:e.data[i][0],y:e.data[i][1]},a={x:e.data[o][0],y:e.data[o][1]},p=x(e.xaxis.p2c(d.x),e.yaxis.p2c(d.y),e.xaxis.p2c(n.x),e.yaxis.p2c(n.y),e.xaxis.p2c(a.x),e.yaxis.p2c(a.y),!1);if(p<u.distance){var r=c(n.x,n.y,d.x,d.y)<c(d.x,d.y,a.x,a.y)?i:o,l=(e.datapoints.pointsize,[d.x,n.y+(a.y-n.y)*((d.x-n.x)/(a.x-n.x))]);u={distance:p,item:{datapoint:l,dataIndex:r,series:e,seriesIndex:t}}}}else f.hideTooltip()}),u.distance<i+1?f.showTooltip(u.item,d):f.hideTooltip()}else f.hideTooltip()}var s=this,t=n.plot.plugins.length;if(this.plotPlugins=[],t)for(var e=0;e<t;e++)this.plotPlugins.push(n.plot.plugins[e].name);f.hooks.bindEvents.push(function(t,e){s.plotOptions=t.getOptions(),"boolean"==typeof s.plotOptions.tooltip&&(s.plotOptions.tooltipOpts.show=s.plotOptions.tooltip,s.plotOptions.tooltip=s.plotOptions.tooltipOpts,delete s.plotOptions.tooltipOpts),!1!==s.plotOptions.tooltip.show&&"undefined"!=typeof s.plotOptions.tooltip.show&&(s.tooltipOptions=s.plotOptions.tooltip,s.tooltipOptions.$compat?(s.wfunc="width",s.hfunc="height"):(s.wfunc="innerWidth",s.hfunc="innerHeight"),s.getDomElement(),n(t.getPlaceholder()).bind("plothover",o),n(e).bind("mousemove",i))}),f.hooks.shutdown.push(function(t,e){n(t.getPlaceholder()).unbind("plothover",o),n(e).unbind("mousemove",i)}),f.setTooltipPosition=function(t){var e=s.getDomElement(),i=e.outerWidth()+s.tooltipOptions.shifts.x,o=e.outerHeight()+s.tooltipOptions.shifts.y;t.x-n(window).scrollLeft()>n(window)[s.wfunc]()-i&&(t.x-=i),t.y-n(window).scrollTop()>n(window)[s.hfunc]()-o&&(t.y-=o),s.tipPosition.x=t.x,s.tipPosition.y=t.y},f.showTooltip=function(t,e){var i=s.getDomElement(),o=s.stringFormat(s.tooltipOptions.content,t);""!==o&&(i.html(o),f.setTooltipPosition({x:e.pageX,y:e.pageY}),i.css({left:s.tipPosition.x+s.tooltipOptions.shifts.x,top:s.tipPosition.y+s.tooltipOptions.shifts.y}).show(),"function"==typeof s.tooltipOptions.onHover&&s.tooltipOptions.onHover(t,i))},f.hideTooltip=function(){s.getDomElement().hide().html("")}},e.prototype.getDomElement=function(){var t=n("."+this.tooltipOptions.cssClass);return 0===t.length&&((t=n("<div />").addClass(this.tooltipOptions.cssClass)).appendTo("body").hide().css({position:"absolute"}),this.tooltipOptions.defaultTheme&&t.css({background:"#fff","z-index":"1040",padding:"0.4em 0.6em","border-radius":"0.5em","font-size":"0.8em",border:"1px solid #111",display:"none","white-space":"nowrap"})),t},e.prototype.stringFormat=function(t,e){var i,o,s,n,a=/%p\.{0,1}(\d{0,})/,p=/%s/,r=/%c/,l=/%lx/,d=/%ly/,x=/%x\.{0,1}(\d{0,})/,c=/%y\.{0,1}(\d{0,})/,u="%x",f="%y",h="%ct";if(s="undefined"!=typeof e.series.threshold?(i=e.datapoint[0],o=e.datapoint[1],e.datapoint[2]):"undefined"!=typeof e.series.lines&&e.series.lines.steps?(i=e.series.datapoints.points[2*e.dataIndex],o=e.series.datapoints.points[2*e.dataIndex+1],""):(i=e.series.data[e.dataIndex][0],o=e.series.data[e.dataIndex][1],e.series.data[e.dataIndex][2]),null===e.series.label&&e.series.originSeries&&(e.series.label=e.series.originSeries.label),"function"==typeof t&&(t=t(e.series.label,i,o,e)),"boolean"==typeof t&&!t)return"";if("undefined"!=typeof e.series.percent?n=e.series.percent:"undefined"!=typeof e.series.percents&&(n=e.series.percents[e.dataIndex]),"number"==typeof n&&(t=this.adjustValPrecision(a,t,n)),t="undefined"!=typeof e.series.label?t.replace(p,e.series.label):t.replace(p,""),t="undefined"!=typeof e.series.color?t.replace(r,e.series.color):t.replace(r,""),t=this.hasAxisLabel("xaxis",e)?t.replace(l,e.series.xaxis.options.axisLabel):t.replace(l,""),t=this.hasAxisLabel("yaxis",e)?t.replace(d,e.series.yaxis.options.axisLabel):t.replace(d,""),this.isTimeMode("xaxis",e)&&this.isXDateFormat(e)&&(t=t.replace(x,this.timestampToDate(i,this.tooltipOptions.xDateFormat,e.series.xaxis.options))),this.isTimeMode("yaxis",e)&&this.isYDateFormat(e)&&(t=t.replace(c,this.timestampToDate(o,this.tooltipOptions.yDateFormat,e.series.yaxis.options))),"number"==typeof i&&(t=this.adjustValPrecision(x,t,i)),"number"==typeof o&&(t=this.adjustValPrecision(c,t,o)),"undefined"!=typeof e.series.xaxis.ticks){var y;y=this.hasRotatedXAxisTicks(e)?"rotatedTicks":"ticks";var m=e.dataIndex+e.seriesIndex;for(var g in e.series.xaxis[y])if(e.series.xaxis[y].hasOwnProperty(m)&&!this.isTimeMode("xaxis",e)){(this.isCategoriesMode("xaxis",e)?e.series.xaxis[y][m].label:e.series.xaxis[y][m].v)===i&&(t=t.replace(x,e.series.xaxis[y][m].label))}}if("undefined"!=typeof e.series.yaxis.ticks)for(var g in e.series.yaxis.ticks)if(e.series.yaxis.ticks.hasOwnProperty(g)){(this.isCategoriesMode("yaxis",e)?e.series.yaxis.ticks[g].label:e.series.yaxis.ticks[g].v)===o&&(t=t.replace(c,e.series.yaxis.ticks[g].label))}return"undefined"!=typeof e.series.xaxis.tickFormatter&&(t=t.replace(u,e.series.xaxis.tickFormatter(i,e.series.xaxis).replace(/\$/g,"$$"))),"undefined"!=typeof e.series.yaxis.tickFormatter&&(t=t.replace(f,e.series.yaxis.tickFormatter(o,e.series.yaxis).replace(/\$/g,"$$"))),s&&(t=t.replace(h,s)),t},e.prototype.isTimeMode=function(t,e){return"undefined"!=typeof e.series[t].options.mode&&"time"===e.series[t].options.mode},e.prototype.isXDateFormat=function(){return"undefined"!=typeof this.tooltipOptions.xDateFormat&&null!==this.tooltipOptions.xDateFormat},e.prototype.isYDateFormat=function(){return"undefined"!=typeof this.tooltipOptions.yDateFormat&&null!==this.tooltipOptions.yDateFormat},e.prototype.isCategoriesMode=function(t,e){return"undefined"!=typeof e.series[t].options.mode&&"categories"===e.series[t].options.mode},e.prototype.timestampToDate=function(t,e,i){var o=n.plot.dateGenerator(t,i);return n.plot.formatDate(o,e,this.tooltipOptions.monthNames,this.tooltipOptions.dayNames)},e.prototype.adjustValPrecision=function(t,e,i){var o;return null!==e.match(t)&&""!==RegExp.$1&&(o=RegExp.$1,i=i.toFixed(o),e=e.replace(t,i)),e},e.prototype.hasAxisLabel=function(t,e){return-1!==n.inArray(this.plotPlugins,"axisLabels")&&"undefined"!=typeof e.series[t].options.axisLabel&&0<e.series[t].options.axisLabel.length},e.prototype.hasRotatedXAxisTicks=function(t){return-1!==n.inArray(this.plotPlugins,"tickRotor")&&"undefined"!=typeof t.series.xaxis.rotatedTicks};var i=function(t){new e(t)};n.plot.plugins.push({init:i,options:t,name:"tooltip",version:"0.8.5"})}(jQuery);