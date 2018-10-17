!function(n){"function"==typeof define&&define.amd?define(["jquery","datatables.net"],function(e){return n(e,window,document)}):"object"==typeof exports?module.exports=function(e,t){return e||(e=window),t&&t.fn.dataTable||(t=require("datatables.net")(e,t).$),n(t,e,e.document)}:n(jQuery,window,document)}(function(f,h,o,s){"use strict";var r=f.fn.dataTable,i=function(e,t){if(!r.versionCheck||!r.versionCheck("1.10.3"))throw"DataTables Responsive requires DataTables 1.10.3 or newer";this.s={dt:new r.Api(e),columns:[],current:[]},this.s.dt.settings()[0].responsive||(t&&"string"==typeof t.details&&(t.details={type:t.details}),this.c=f.extend(!0,{},i.defaults,r.defaults.responsive,t),(e.responsive=this)._constructor())};f.extend(i.prototype,{_constructor:function(){var i=this,n=this.s.dt,e=n.settings()[0];n.settings()[0]._responsive=this,f(h).on("resize.dtr orientationchange.dtr",r.util.throttle(function(){i._resize()})),e.oApi._fnCallbackReg(e,"aoRowCreatedCallback",function(e){-1!==f.inArray(!1,i.s.current)&&f("td, th",e).each(function(e){var t=n.column.index("toData",e);!1===i.s.current[t]&&f(this).css("display","none")})}),n.on("destroy.dtr",function(){n.off(".dtr"),f(n.table().body()).off(".dtr"),f(h).off("resize.dtr orientationchange.dtr"),f.each(i.s.current,function(e,t){!1===t&&i._setColumnVis(e,!0)})}),this.c.breakpoints.sort(function(e,t){return e.width<t.width?1:e.width>t.width?-1:0}),this._classLogic(),this._resizeAuto();var t=this.c.details;!1!==t.type&&(i._detailsInit(),n.on("column-visibility.dtr",function(){i._classLogic(),i._resizeAuto(),i._resize()}),n.on("draw.dtr",function(){i._redrawChildren()}),f(n.table().node()).addClass("dtr-"+t.type)),n.on("column-reorder.dtr",function(e,t,n){n.drop&&(i._classLogic(),i._resizeAuto(),i._resize())}),this._resize()},_columnsVisiblity:function(t){var e,n,i=this.s.dt,r=this.s.columns,s=r.map(function(e,t){return{columnIdx:t,priority:e.priority}}).sort(function(e,t){return e.priority!==t.priority?e.priority-t.priority:e.columnIdx-t.columnIdx}),o=f.map(r,function(e){return(!e.auto||null!==e.minWidth)&&(!0===e.auto?"-":-1!==f.inArray(t,e.includeIn))}),a=0;for(e=0,n=o.length;e<n;e++)!0===o[e]&&(a+=r[e].minWidth);var d=i.settings()[0].oScroll,l=d.sY||d.sX?d.iBarWidth:0,c=i.table().container().offsetWidth-l-a;for(e=0,n=o.length;e<n;e++)r[e].control&&(c-=r[e].minWidth);var u=!1;for(e=0,n=s.length;e<n;e++){var h=s[e].columnIdx;"-"===o[h]&&!r[h].control&&r[h].minWidth&&(u||c-r[h].minWidth<0?(u=!0,o[h]=!1):o[h]=!0,c-=r[h].minWidth)}var p=!1;for(e=0,n=r.length;e<n;e++)if(!r[e].control&&!r[e].never&&!o[e]){p=!0;break}for(e=0,n=r.length;e<n;e++)r[e].control&&(o[e]=p);return-1===f.inArray(!0,o)&&(o[0]=!0),o},_classLogic:function(){var a=this,d=this.c.breakpoints,r=this.s.dt,l=r.columns().eq(0).map(function(e){var t=this.column(e),n=t.header().className,i=r.settings()[0].aoColumns[e].responsivePriority;return i===s&&(i=f(t.header).data("priority")!==s?1*f(t.header).data("priority"):1e4),{className:n,includeIn:[],auto:!1,control:!1,never:!!n.match(/\bnever\b/),priority:i}}),c=function(e,t){var n=l[e].includeIn;-1===f.inArray(t,n)&&n.push(t)},u=function(e,t,n,i){var r,s,o;if(n){if("max-"===n)for(r=a._find(t).width,s=0,o=d.length;s<o;s++)d[s].width<=r&&c(e,d[s].name);else if("min-"===n)for(r=a._find(t).width,s=0,o=d.length;s<o;s++)d[s].width>=r&&c(e,d[s].name);else if("not-"===n)for(s=0,o=d.length;s<o;s++)-1===d[s].name.indexOf(i)&&c(e,d[s].name)}else l[e].includeIn.push(t)};l.each(function(e,s){for(var t=e.className.split(" "),o=!1,n=0,i=t.length;n<i;n++){var a=f.trim(t[n]);if("all"===a)return o=!0,void(e.includeIn=f.map(d,function(e){return e.name}));if("none"===a||e.never)return void(o=!0);if("control"===a)return o=!0,void(e.control=!0);f.each(d,function(e,t){var n=t.name.split("-"),i=new RegExp("(min\\-|max\\-|not\\-)?("+n[0]+")(\\-[_a-zA-Z0-9])?"),r=a.match(i);r&&(o=!0,r[2]===n[0]&&r[3]==="-"+n[1]?u(s,t.name,r[1],r[2]+r[3]):r[2]!==n[0]||r[3]||u(s,t.name,r[1],r[2]))})}o||(e.auto=!0)}),this.s.columns=l},_detailsDisplay:function(e,t){var n=this,i=this.s.dt,r=this.c.details.display(e,t,function(){return n.c.details.renderer(i,e[0],n._detailsObj(e[0]))});!0!==r&&!1!==r||f(i.table().node()).triggerHandler("responsive-display.dt",[i,e,r,t])},_detailsInit:function(){var n=this,i=this.s.dt,e=this.c.details;"inline"===e.type&&(e.target="td:first-child"),i.on("draw.dtr",function(){n._tabIndexes()}),n._tabIndexes(),f(i.table().body()).on("keyup.dtr","td",function(e){13===e.keyCode&&f(this).data("dtr-keyboard")&&f(this).click()});var r=e.target,t="string"==typeof r?r:"td";f(i.table().body()).on("mousedown.dtr",t,function(e){e.preventDefault()}).on("click.dtr",t,function(){if(f(i.table().node()).hasClass("collapsed")&&i.row(f(this).closest("tr")).length){if("number"==typeof r){var e=r<0?i.columns().eq(0).length+r:r;if(i.cell(this).index().column!==e)return}var t=i.row(f(this).closest("tr"));n._detailsDisplay(t,!1)}})},_detailsObj:function(n){var i=this,r=this.s.dt;return f.map(this.s.columns,function(e,t){if(!e.never)return{title:r.settings()[0].aoColumns[t].sTitle,data:r.cell(n,t).render(i.c.orthogonal),hidden:r.column(t).visible()&&!i.s.current[t]}})},_find:function(e){for(var t=this.c.breakpoints,n=0,i=t.length;n<i;n++)if(t[n].name===e)return t[n]},_redrawChildren:function(){var n=this,i=this.s.dt;i.rows({page:"current"}).iterator("row",function(e,t){i.row(t);n._detailsDisplay(i.row(t),!0)})},_resize:function(){var e,t,n=this,i=this.s.dt,r=f(h).width(),s=this.c.breakpoints,o=s[0].name,a=this.s.columns,d=this.s.current.slice();for(e=s.length-1;0<=e;e--)if(r<=s[e].width){o=s[e].name;break}var l=this._columnsVisiblity(o);this.s.current=l;var c=!1;for(e=0,t=a.length;e<t;e++)if(!1===l[e]&&!a[e].never){c=!0;break}f(i.table().node()).toggleClass("collapsed",c);var u=!1;i.columns().eq(0).each(function(e,t){l[t]!==d[t]&&(u=!0,n._setColumnVis(e,l[t]))}),u&&this._redrawChildren()},_resizeAuto:function(){var n=this.s.dt,i=this.s.columns;if(this.c.auto&&-1!==f.inArray(!0,f.map(i,function(e){return e.auto}))){n.table().node().offsetWidth,n.columns;var e=n.table().node().cloneNode(!1),t=f(n.table().header().cloneNode(!1)).appendTo(e),r=f(n.table().body().cloneNode(!1)).appendTo(e),s=n.columns().header().filter(function(e){return n.column(e).visible()}).to$().clone(!1).css("display","table-cell");f(r).append(f(n.rows({page:"current"}).nodes()).clone(!1)).find("th, td").css("display","");var o=n.table().footer();if(o){var a=f(o.cloneNode(!1)).appendTo(e),d=n.columns().header().filter(function(e){return n.column(e).visible()}).to$().clone(!1).css("display","table-cell");f("<tr/>").append(d).appendTo(a)}f("<tr/>").append(s).appendTo(t),"inline"===this.c.details.type&&f(e).addClass("dtr-inline collapsed");var l=f("<div/>").css({width:1,height:1,overflow:"hidden"}).append(e);l.insertBefore(n.table().node()),s.each(function(e){var t=n.column.index("fromVisible",e);i[t].minWidth=this.offsetWidth||0}),l.remove()}},_setColumnVis:function(e,t){var n=this.s.dt,i=t?"":"none";f(n.column(e).header()).css("display",i),f(n.column(e).footer()).css("display",i),n.column(e).nodes().to$().css("display",i)},_tabIndexes:function(){var e=this.s.dt,t=e.cells({page:"current"}).nodes().to$(),n=e.settings()[0],i=this.c.details.target;t.filter("[data-dtr-keyboard]").removeData("[data-dtr-keyboard]"),f("number"==typeof i?":eq("+i+")":i,e.rows({page:"current"}).nodes()).attr("tabIndex",n.iTabIndex).data("dtr-keyboard",1)}}),i.breakpoints=[{name:"desktop",width:Infinity},{name:"tablet-l",width:1024},{name:"tablet-p",width:768},{name:"mobile-l",width:480},{name:"mobile-p",width:320}],i.display={childRow:function(e,t,n){return t?f(e.node()).hasClass("parent")?(e.child(n(),"child").show(),!0):void 0:e.child.isShown()?(e.child(!1),f(e.node()).removeClass("parent"),!1):(e.child(n(),"child").show(),f(e.node()).addClass("parent"),!0)},childRowImmediate:function(e,t,n){return!t&&e.child.isShown()||!e.responsive.hasHidden()?(e.child(!1),f(e.node()).removeClass("parent"),!1):(e.child(n(),"child").show(),f(e.node()).addClass("parent"),!0)},modal:function(s){return function(e,t,n){if(t)f("div.dtr-modal-content").empty().append(n());else{var i=function(){r.remove(),f(o).off("keypress.dtr")},r=f('<div class="dtr-modal"/>').append(f('<div class="dtr-modal-display"/>').append(f('<div class="dtr-modal-content"/>').append(n())).append(f('<div class="dtr-modal-close">&times;</div>').click(function(){i()}))).append(f('<div class="dtr-modal-background"/>').click(function(){i()})).appendTo("body");s&&s.header&&r.find("div.dtr-modal-content").prepend("<h2>"+s.header(e)+"</h2>"),f(o).on("keyup.dtr",function(e){27===e.keyCode&&(e.stopPropagation(),i())})}}}},i.defaults={breakpoints:i.breakpoints,auto:!0,details:{display:i.display.childRow,renderer:function(e,t,n){var i=f.map(n,function(e,t){return e.hidden?'<li data-dtr-index="'+t+'"><span class="dtr-title">'+e.title+'</span> <span class="dtr-data">'+e.data+"</span></li>":""}).join("");return!!i&&f('<ul data-dtr-index="'+t+'"/>').append(i)},target:0,type:"inline"},orthogonal:"display"};var e=f.fn.dataTable.Api;return e.register("responsive()",function(){return this}),e.register("responsive.index()",function(e){return{column:(e=f(e)).data("dtr-index"),row:e.parent().data("dtr-index")}}),e.register("responsive.rebuild()",function(){return this.iterator("table",function(e){e._responsive&&e._responsive._classLogic()})}),e.register("responsive.recalc()",function(){return this.iterator("table",function(e){e._responsive&&(e._responsive._resizeAuto(),e._responsive._resize())})}),e.register("responsive.hasHidden()",function(){var e=this.context[0];return!!e._responsive&&-1!==f.inArray(!1,e._responsive.s.current)}),i.version="2.0.0",f.fn.dataTable.Responsive=i,f.fn.DataTable.Responsive=i,f(o).on("init.dt.dtr",function(e,t){if("dt"===e.namespace&&(f(t.nTable).hasClass("responsive")||f(t.nTable).hasClass("dt-responsive")||t.oInit.responsive||r.defaults.responsive)){var n=t.oInit.responsive;!1!==n&&new i(t,f.isPlainObject(n)?n:{})}}),i});