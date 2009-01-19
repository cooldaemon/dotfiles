load(environment.HOME + '/bin/js/fulljslint.js');

var file   = arguments[0];
var source = arguments[1];

if (!file || !source) {
  print('Usage: jslint.js [File Name] [Source]');
  quit(1);
}

if (JSLINT(source, {passfail: false})) {
  print('All good.');
  quit();
}

for (var i = 0; i < JSLINT.errors.length; i += 1) {
  var e = JSLINT.errors[i];
  if (e) {
    print(
      file + ':' +
      (e.line + 1) + ':' +
      (e.character + 1) + ': ' +
      e.reason
    );
  }
}

