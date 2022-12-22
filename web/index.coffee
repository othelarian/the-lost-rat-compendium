createElt = (tag, attrs, txt, html) ->
  elt = document.createElement tag
  afn = ([k, v]) -> elt.setAttribute k, v
  afn attr for attr in attrs
  if txt? then elt.innerText = txt
  else if html? then elt.innerHTML = html
  elt

getId = (id) -> document.getElementById id

setDis = (id, display) -> getId(id).style.display = display

TLRCmenu =
  act: (action) ->
    switch (action)
      when 'close' then TLRC.menu.close()
      when 'open' then TLRC.menu.open()
  close: ->
    getId('tlrc-menu').removeAttribute 'style'
    getId('tlrc-veil').removeAttribute 'style'
    TLRC.menu.opened = false
  init: ->
    menu = getId 'tlrc-menu-inner'
    handleArticle = (article) ->
      title = article.querySelector('.title').innerText
      id = article.getAttribute('id').substring 13
      TLRC.routes.push id
      attrs = [
        ['class', 'entry']
        ['onclick', "TLRC.show('#{id}')"]
        ['id', "tlrc-entry-#{id}"]
      ]
      entry = createElt 'div', attrs, title
      menu.append entry
    handleArticle article for article in document.querySelectorAll '.tlrc-article'
  opened: false
  open: ->
    getId('tlrc-menu').setAttribute 'style', 'display:block'
    getId('tlrc-veil').setAttribute 'style', 'display:block'
    TLRC.menu.opened = true
  resize: (_) ->
    if TLRC.menu.opened and window.innerWidth > 700 then TLRC.menu.close()

TLRC =
  article: ''
  routes: []
  menu: TLRCmenu
  init: ->
    window.addEventListener 'resize', TLRC.menu.resize
    TLRC.menu.init()
    TLRC.reach()
    window.addEventListener 'hashchange', TLRC.reach
  show: (article) ->
    if TLRC.article isnt ''
      setDis "tlrc-article-#{TLRC.article}", 'none'
      getId("tlrc-entry-#{TLRC.article}").classList.remove 'selected'
    setDis "tlrc-article-#{article}", 'block'
    getId("tlrc-entry-#{article}").classList.add 'selected'
    location.hash = article
    TLRC.article = article
  reach: ->
    article =
      if location.hash is '' then 'welcome'
      else
        hsh = location.hash.substring 1
        if TLRC.routes.includes hsh then hsh
        else
          location.hash = ''
          'welcome'
    TLRC.show article

window.TLRC = TLRC

window.initTlrc = ->
  if navigator.serviceWorker isnt null
    console.log 'loading sw'
    navigator.serviceWorker.register 'sw.js'
  TLRC.init()

