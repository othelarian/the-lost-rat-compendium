icndir = 'icons'
pwapath = 'pwa'
webpath = 'web'

exports.cfg =
  dest_path:
    debug: 'dist'
    release: 'out'
    github: 'docs'
  icon:
    dir: icndir
    src: ["#{pwapath}/icon.pug"]
    out: "#{icndir}/icon.svg"
  pwa:
    background_color: 'darkgray'
    description: 'The compendium of all the rules made by the lost rat'
    display: 'standalone'
    icon_sizes: [128, 192, 256, 512]
    icon_mask: [false, false, true, true]
    icon_svg: '72x72 96x96 1024x1024'
    lang: 'en'
    name: 'The Lost Rat Compendium'
    path: pwapath
    service_worker: {src: "#{pwapath}/sw.coffee", out: 'sw.js'}
    'short-name': 'TLRC'
    start_url: 'index.html'
    theme_color: '#333'
  static: 'static'
  version: '0.1.0'
  web:
    html:
      src: ("#{webpath}/#{file}" for file in ['index.pug'])
      out: 'index.html'
    path: webpath
    sass:
      src: "#{webpath}/style.sass"
      out: 'style.css'
    coffee:
      src: "#{webpath}/index.coffee"
      out: 'index.js'
