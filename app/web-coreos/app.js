var express = require('express'),
    app = express(),
    redis = require("redis");

var PORT = 8080;

function redisConnect(host) {
  var redisclient = redis.createClient(6379, host);

  redisclient.on("error", function (err) {
    console.log("Redis error: " + err);
  });

  redisclient.on("ready", function () {
    console.log("Redis is ready");

    app.get('/', function (req, res) {
      redisclient.incr("counter", function (err, reply) {
	res.send('Redis reply: ' + reply + '\n');
      });
    });
  });
}

function etcdConnect(host) {
  var exec = require('child_process').exec;

  console.log('default gw: ' + host);

  var curl = exec('curl -L 10.1.42.1:4001/v2/keys/service/redis');

  curl.stdout.on('data', function (json) {
    console.log('etcdctl: json="' + json + '"');

    var obj = JSON.parse(json || '{}');
    var host = obj && obj.node ? obj.node.value : null;

    console.log('etcdctl: json="' + json + '", host="' + host + '"');
    redisConnect(host);
  });

  curl.stderr.on('data', function (err) {
    console.log('etcdctl: err="' + err + '"');
  });
}

require('child_process')
  .exec("ip route show | grep ^default | awk '{ print $3}'")
  .stdout.on('data', etcdConnect);

app.listen(PORT);
console.log('Listening on ' + PORT);
