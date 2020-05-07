#!/usr/bin/env node

var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.json({"hello": "world"});
});

app.listen(8002, function () {});
