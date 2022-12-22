OFFLINE_VERSION = 1
CACHE_NAME = 'tlrc_offline'
OFFLINE_URL = 'index.html'

self.addEventListener 'install', (evt) =>
  evt.waitUntil(( =>
    cache = await caches.open CACHE_NAME
    await cache.add new Request OFFLINE_URL, {cache: 'reload'}
  )())

self.addEventListener 'activate', (evt) =>
  evt.waitUntil(( =>
    if self.registration.navigationPreload?
      await self.registration.navigationPreload.enable()
  )())

