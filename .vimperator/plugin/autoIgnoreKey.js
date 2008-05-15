(function(){
/**
 * String or RegExp
 * e.g)
 * /^https?:\/\/mail\.google\.com\//
 * 'http://reader.livedoor.com/reader/'
 */

var ignorePageList = [
    /^https?:\/\/mail\.google\.com\//,
    'http://reader.livedoor.com/reader/',
    /^http:\/\/www\.nicovideo\.jp\//,
];

document.getElementById('appcontent').addEventListener('TabSelect', function(event) {
    var d = gBrowser.selectedBrowser.contentDocument;
    if(isMatch(d.URL)) {
        vimperator.addMode(null, vimperator.modes.ESCAPE_ALL_KEYS);
        vimperator.log('Map ignored: ' + d.URL);
    }
}, false);

function isMatch(uri) {
    return ignorePageList.some(function(e,i,a) {
        if (typeof e == 'string'){
            return uri.indexOf(e) != -1;
        } else if (e instanceof RegExp) {
            return e.test(uri);
        }
    });
}
})();

