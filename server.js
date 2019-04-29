var http = require('http');
var express = require('express');
var util = require('util');
var config = require('./config');
var logger = require('./utils/logger');
var middlewares = require('./middlewares/index');
var app = express();
var fs = require('fs');

//set port and ipv4/ipv6 address.

app.set('port', config.get('server.port'));

//setup middlewares
middlewares(app, express, __dirname);

//start http server  
http.createServer(app).listen('7000', app.get('ipAddress'), function () {
  logger.info(util.format('app server with pid:%s listening on port:%s', process.pid, app.get('port')));
  logger.info(util.format('Environment:%s', config.get('env')));
});