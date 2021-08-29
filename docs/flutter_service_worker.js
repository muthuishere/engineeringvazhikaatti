'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "43801d8af182576e0c128f1ed3cb955f",
"assets/assets/allbranches.json": "d10585ad5a1a766194e1d38aac3f7866",
"assets/assets/colleges.json": "28298441f8ac2d1c961dd4640153f357",
"assets/assets/districts.json": "c3fb257f585552909035f090fd93bc73",
"assets/assets/fonts/OpenSans-Bold.ttf": "0062c34665a3fc0f2278cd4e955702ec",
"assets/assets/fonts/OpenSans-Light.ttf": "f51d593e2ab59a38dd41cc76a3f88460",
"assets/assets/fonts/OpenSans-Regular.ttf": "5a798cdadc7cd321e3f72425b70bface",
"assets/assets/images/icon_128.png": "39bec2257462be55532c04d07706939f",
"assets/assets/images/main_image.png": "26177034f112b09dd2d1a6a50e47cf52",
"assets/assets/pincodes.json": "0ae74ea4adf60d50e4783b96fa428fc0",
"assets/FontManifest.json": "ffe42c25c79de54e7efb0f3586d432b1",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "c3015cc75d0cbfd88deef028f33d48a4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "d81dac4b0f13300ab65034e59d06049c",
"icons/android-icon-144x144.png": "4f4aa85154a31bf1067a770366c60389",
"icons/android-icon-192x192.png": "fd7eb57bc3b9fe0d73d51bd9cbea1554",
"icons/android-icon-36x36.png": "ef49ca92d1a029e4a5fe75f25aea88a1",
"icons/android-icon-48x48.png": "2ce34ca3d10721a5142ee0a26305d3e5",
"icons/android-icon-72x72.png": "fa64995c4b67f3f6d0d3dd339174c679",
"icons/android-icon-96x96.png": "f14d43af3e593153156ebd9d4bb5571b",
"icons/apple-icon-114x114.png": "83b375a9a0eb270bd85d3b20b2d9ee92",
"icons/apple-icon-120x120.png": "cf187f013179f693d4748ef5633e19ec",
"icons/apple-icon-144x144.png": "4f4aa85154a31bf1067a770366c60389",
"icons/apple-icon-152x152.png": "41d880287b874e7a4d3d446dc5d704ec",
"icons/apple-icon-180x180.png": "704d53bb119851e18183b3b0749f779a",
"icons/apple-icon-57x57.png": "029ecbee1673d0a1df54bae3586e0393",
"icons/apple-icon-60x60.png": "e9b17d0956e1d3817cb5f9efbeaf36d2",
"icons/apple-icon-72x72.png": "fa64995c4b67f3f6d0d3dd339174c679",
"icons/apple-icon-76x76.png": "852098fc880f72f7844fe0bf129067d4",
"icons/apple-icon-precomposed.png": "ed19712ab134c985149cdcbaf2987b86",
"icons/apple-icon.png": "ed19712ab134c985149cdcbaf2987b86",
"icons/favicon-16x16.png": "d81dac4b0f13300ab65034e59d06049c",
"icons/favicon-32x32.png": "52ce24e3d189c2d21c43af9cd706bb1e",
"icons/favicon-96x96.png": "de8014bfd0a9d3084a963545d3759bbc",
"icons/Icon-192.png": "fd7eb57bc3b9fe0d73d51bd9cbea1554",
"icons/Icon-512.png": "7d610473ad1305ad5295cd1f964ea2e9",
"icons/ms-icon-144x144.png": "5bdadd8b7a3f976fde85fe0791bdeedc",
"icons/ms-icon-150x150.png": "27a5e65ab2637e4d878ec098c813f7cf",
"icons/ms-icon-310x310.png": "2c47a9502092482f6696cd95ca1ef047",
"icons/ms-icon-70x70.png": "5dde95da72b808f21a3e49fc11f5fbec",
"index.html": "9d91114935623421c770f1639f28fce2",
"/": "9d91114935623421c770f1639f28fce2",
"main.dart.js": "f93cf61e6806ac3e0ddcbaa2b74d7a78",
"manifest.json": "b0adbbf46ddf483bed3b93d2862ee1c1",
"privacy_policy.html": "4c0869e99d62fbd13088b99f00db0f56",
"version.json": "15d3b9ea05c77d1036c140e1b7a5f980"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
