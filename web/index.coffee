createElt = (tag, attrs, txt, html) ->
  elt = document.createElement tag
  afn = ([k, v]) -> elt.setAttribute k, v
  afn attr for attr in attrs
  if txt? then elt.innerText = txt
  else if html? then elt.innerHTML = html
  elt

getId = (id) -> document.getElementById id

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
    handleArticle = (article, i) ->
      title = article.querySelector('.title').innerText
      attrs = [
        ['class', 'entry']
        ['onclick', "TLRC.menu.select(#{i})"]
        ['id', "tlrc-entry-#{i}"]
      ]
      entry = createElt 'div', attrs, title
      menu.append entry
      article.setAttribute 'id', "tlrc-article-#{i}"
      if i is 0 then entry.classList.add 'selected'
    handleArticle article, i for article, i in document.querySelectorAll '.tlrc-article'
  selected: 0
  select: (i) ->
    getId("tlrc-entry-#{TLRC.menu.selected}").classList.remove 'selected'
    getId("tlrc-article-#{TLRC.menu.selected}").style.display = 'none'
    getId("tlrc-entry-#{i}").classList.add 'selected'
    getId("tlrc-article-#{i}").style.display = 'block'
    TLRC.menu.selected = i
  opened: false
  open: ->
    getId('tlrc-menu').setAttribute 'style', 'display:block'
    getId('tlrc-veil').setAttribute 'style', 'display:block'
    TLRC.menu.opened = true
  resize: (_) ->
    if TLRC.menu.opened and window.innerWidth > 700 then TLRC.menu.close()

TLRC =
  menu: TLRCmenu
  init: ->
    window.addEventListener 'resize', TLRC.menu.resize
    TLRC.menu.init()

window.TLRC = TLRC

window.initTlrc = ->
  if navigator.serviceWorker? then navigator.serviceWorker.register 'sw.js'
  TLRC.init()

