//------------------------------------------------------------------------------
// node.js test app for kubernetes
//------------------------------------------------------------------------------

// This application uses express as its web server
// for more info, see: http://expressjs.com
var express = require('express');

// create a new express server
var app = express();

// get fs module for parsing HTML files
var fs = require('fs');

// serve the files out of ./public as our main files
app.use(express.static(__dirname + '/public'));

// define trivial template engine
app.engine('thtml', function (filePath, options, callback) {
  fs.readFile(filePath, function (err, content) {
    if (err) return callback(err)
    // this is an extremely simple template engine
    var rendered = content.toString();
    Object.keys(options).forEach( function(prop) {
      rendered = rendered.replace('#='+prop+'=#', options[prop]);
    })
    return callback(null, rendered)
  })
})

app.set('views', './views') // specify the views directory
app.set('view engine', 'thtml') // register the template engine

/********************************************************************/
var os = require('os');
var ifaces = os.networkInterfaces();

var iflist = ''
Object.keys(ifaces).forEach(function (ifname) {
  ifaces[ifname].forEach(function (iface) {
    if ('IPv4' === iface.family && iface.internal === false) {
        iflist = iflist + ifname + ':' + iface.address + ' ';
    }
  });
});

var os = require("os");
var hostname = os.hostname();
/********************************************************************/


// now we are ready to define routes
app.get('/', function (req, res) {
  let options = {
    title: 'Hello from Kube!'
  }
  options.podname = hostname
  options.cip = iflist
  options.chn = hostname
  res.render('index', options)
})

// start server on the specified port and binding host
app.listen(3000, '0.0.0.0', function() {
  // print a message when the server starts listening
  console.log("server starting on http://localhost:3000");
});
