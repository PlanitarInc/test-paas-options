var express = require('express'),
    app = express(),
    redis = require("redis"),
    redisclient = redis.createClient(6379, "redis");

var PORT = 8080;

redisclient.on("error", function (err) {
  console.log("Error " + err);
});

app.get('/', function (req, res) {
  console.log('req: ' + JSON.stringify({q:1,b:2}, null, 2));
  redisclient.incr("counter", function (res) {
    console.log('args: ' + JSON.stringify(arguments, null, 2));
    console.log('res: ' + JSON.stringify(res, null, 2));
    res.send('Hello world\n');
  });
});

app.listen(PORT);
console.log('Listening on ' + PORT);
