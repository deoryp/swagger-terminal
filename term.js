var readline = require('readline');

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  completer: completer
});

function completer(line, callback) {
  var completions = 'hello bye exit'.split(' ')
  var hits = completions.filter(function(c) { return c.indexOf(line) == 0 })
  // show all completions if none found
  callback(null, [hits.length ? hits : completions, line], line);
}


rl.setPrompt('OHAI> ');
rl.prompt();

rl.on('line', function(line) {
  switch(line.trim()) {
    case 'hello':
      console.log('world!');
      break;
    case 'bye':
      console.log('son!');
      break;
    case 'exit':
      rl.close();
    default:
      console.log('Say what? I might have heard `' + line.trim() + '`');
      break;
  }
  rl.prompt();
}).on('close', function() {
  console.log('Have a great day!');
  process.exit(0);
});

