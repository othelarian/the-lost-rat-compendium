!function(){"use strict";var e,t,n,r,i;n=function(e,t,n,r){var i,c,o,l;for(c=document.createElement(e),i=function([e,t]){return c.setAttribute(e,t)},
                                                                           o=0,l=t.length;o<l;o++)i(t[o]);return null!=n?c.innerText=n:null!=r&&(c.innerHTML=r),c},
  r=function(e){return document.getElementById(e)},i=function(e,t){return r(e).style.display=t},t={act:function(t){switch(t){case"close":return e.menu.close();
  case"open":return e.menu.open()}},close:function(){return r("tlrc-menu").removeAttribute("style"),r("tlrc-veil").removeAttribute("style"),e.menu.opened=!1},
                                                                                                   init:function(){var t,i,c,o,l,u,s;for(l=r("tlrc-menu-inner"),
                                                                                                                                         i=function(t){var r,i,c;
                                                                                                                                         return c=t.querySelector(".title").innerText,i=t.getAttribute("id").substring(13),e.routes.push(i),r=n("div",[["class","entry"],["onclick",`TLRC.show('${i}')`],["id",`tlrc-entry-${i}`]],c),l.append(r)},s=[],c=0,o=(u=document.querySelectorAll(".tlrc-article")).length;c<o;c++)t=u[c],s.push(i(t));return s},opened:!1,
                                                                                                   open:function(){return r("tlrc-menu").setAttribute("style","display:block"),r("tlrc-veil").setAttribute("style","display:block"),e.menu.opened=!0},resize:function(t){if(e.menu.opened&&window.innerWidth>700)return e.menu.close()}},e={article:"",routes:[],menu:t,
                                                                                                   init:function(){return window.addEventListener("resize",e.menu.resize),e.menu.init(),e.reach(),window.addEventListener("hashchange",e.reach)},show:function(t){return""!==e.article&&(i(`tlrc-article-${e.article}`,"none"),r(`tlrc-entry-${e.article}`).classList.remove("selected")),i(`tlrc-article-${t}`,"block"),r(`tlrc-entry-${t}`).classList.add("selected"),location.hash=t,e.article=t},
                                                                                                   reach:function(){var t,n;return t=""===location.hash?"welcome":(n=location.hash.substring(1),e.routes.includes(n)?n:(location.hash="","welcome")),e.show(t)}},window.TLRC=e,
  window.initTlrc=function(){
    return null!==navigator.serviceWorker&&(console.log("loading sw"),
      navigator.serviceWorker.register("/the-lost-rat-compendium/sw.js",
            {"scope":"/the-lost-rat-compendium/"}
                )),e.init()}}();
