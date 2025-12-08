let addons = [
   "https://addons.mozilla.org/firefox/downloads/file/4629131/ublock_origin-1.68.0.xpi",
   "https://addons.mozilla.org/firefox/downloads/file/4625542/darkreader-4.9.116.xpi",
   "https://addons.mozilla.org/firefox/downloads/file/4608179/sponsorblock-6.1.0.xpi",
   "https://addons.mozilla.org/firefox/downloads/file/4568486/torrent_control-0.2.44.xpi",
   "https://addons.mozilla.org/firefox/downloads/file/4432106/clearurls-1.27.3.xpi",
   "https://addons.mozilla.org/firefox/downloads/file/4570378/privacy_badger17-2025.9.2.xpi",
];

for (let addon of addons) { 
    glide.addons.install(addon);
}
