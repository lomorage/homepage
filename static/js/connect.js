// Landing page for the setup QR code shown on a fresh Lomorage server.
// The QR code is https://lomorage.com/s/#server=<host:port>&uuid=...&name=...
// When LomoMobile is installed, the OS opens the app directly (App Links /
// Universal Links) and this page never loads. Otherwise the phone lands
// here to install the app. The parameters are in the fragment, so the
// server's LAN address never reaches the web host.
(function () {
  var params = new URLSearchParams(location.hash.slice(1));
  var server = params.get('server') || '';
  var name = params.get('name') || '';
  // Only display something that looks like host[:port]; anyone can craft this link.
  if (!/^[\w.\-\[\]:]{1,100}$/.test(server)) server = '';
  name = name.slice(0, 60);

  var ua = navigator.userAgent || '';
  var isIOS = /iPhone|iPad|iPod/i.test(ua) || (/Macintosh/i.test(ua) && navigator.maxTouchPoints > 1);
  var isAndroid = /Android/i.test(ua);
  var inWeChat = /MicroMessenger|QQ\//i.test(ua);

  var shown = document.querySelector('[data-connect-lang="' + document.documentElement.lang + '"]');
  if (shown) document.title = shown.dataset.title;

  document.querySelectorAll('[data-connect-lang]').forEach(function (page) {
    if (server) {
      page.querySelector('[data-server-box]').hidden = false;
      page.querySelector('[data-server-name]').textContent = name ? name + ' · ' + server : server;
      page.querySelector('[data-manual]').hidden = false;
      page.querySelector('[data-server-address]').textContent = server;
    }
    if (inWeChat) page.querySelector('[data-wechat]').hidden = false;
    // On a phone, offer only its own store; elsewhere show both.
    if (isIOS || isAndroid) {
      page.querySelectorAll('[data-store]').forEach(function (link) {
        link.hidden = link.dataset.store !== (isIOS ? 'ios' : 'android');
      });
    }
    var copy = page.querySelector('[data-copy]');
    var address = page.querySelector('[data-server-address]');
    // Some in-app browsers have no clipboard API or refuse the write; then
    // select the address so the user can copy it from the system menu.
    var selectAddress = function () {
      var range = document.createRange();
      range.selectNodeContents(address);
      var selection = window.getSelection();
      selection.removeAllRanges();
      selection.addRange(range);
    };
    copy.addEventListener('click', function () {
      if (!navigator.clipboard) return selectAddress();
      navigator.clipboard.writeText(server).then(function () {
        copy.textContent = copy.dataset.copiedText;
      }, selectAddress);
    });
  });
})();
