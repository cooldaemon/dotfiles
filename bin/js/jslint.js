load(environment.HOME + '/bin/js/fulljslint.js');
(function (file, source) {
  if (!file || !source) {
    print('Usage: jslint.js [File Name] [Source]');
    quit(1);
  }

  if (JSLINT(source, {passfail: false})) {
    print('All good.');
    quit();
  }

  JSLINT.errors.forEach(function (error) {
    var message;
    [
      file,
      error.line + 1,
      error.character + 1,
      error.reason
    ].forEach(function (elem) {
      if (message) {
        message += ':' + elem;
      } else {
        message = elem;
      }
    });
    print(message);
  });
})(arguments[0], arguments[1]);

