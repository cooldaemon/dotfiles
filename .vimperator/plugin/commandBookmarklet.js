(function(){
  var filter = "javascript:";
  var items = vimperator.completion.bookmark(filter);

  if (items.length == 0) {
    if (filter.length > 0) {
      vimperator.echoerr("E283: No bookmarks matching \"" + filter + "\"");
    } else {
      vimperator.echoerr("No bookmarks set");
    }  
  }

  for (var i = 0; i < items.length; i++) {
    var title = vimperator.util.escapeHTML(items[i][1]);
    if (title.length > 50) {
      title = title.substr(0, 47) + "...";
    }  

    var url = vimperator.util.escapeHTML(items[i][0]);
    var command = new Function('', 'vimperator.open("' + url + '");');
    vimperator.commands.add(new vimperator.Command(
        [title],
        command,
        {  
            shortHelp: 'bookmarklet',
            help: title + '<br>' + url
        }  
    ));
  }
})();

