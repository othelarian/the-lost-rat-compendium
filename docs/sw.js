const OFFLINE_VERSION = 2;
const CACHE_NAME = "tlrc_offline";
const OFFLINE_URL = "/the-lost-rat-compendium/index.html";

self.addEventListener("install", (evt) => {
  evt.waitUntil((async () => {
    const cache = await caches.open(CACHE_NAME);
    await cache.add(new Request(OFFLINE_URL, {cache: "reload"}));
  })());
});

self.addEventListener("activate", (evt) => {
  evt.waitUntil((async () => {
    if ("navigationPreload" in self.registration) {
      await self.registration.navigationPreload.enable();
    }
  })());
  self.clients.claim();
});

self.addEventListener("fetch", (evt) => {
  if (evt.request.mode == "navigate") {
    //
    // TODO: maybe one day
    //
  }
});

