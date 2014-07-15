var express = require('express'),
    app = express(),
    redis = require("redis"),
    redisclient = redis.createClient(6379, "redis");

var PORT = 8080;

redisclient.on("error", function (err) {
  console.log("Error " + err);
});

redisclient.on("ready", function () {
  console.log("Redis is ready");

  app.get('/', function (req, res) {
    redisclient.incr("counter", function (err, reply) {
      res.send('Redis reply: ' + reply + '\n');
    });
  });
});

app.listen(PORT);
console.log('Listening on ' + PORT);
