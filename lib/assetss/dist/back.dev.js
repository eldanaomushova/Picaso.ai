#!/usr/bin/env node
"use strict";

var expect = require("chai").expect;

var svgcode = require("../index");

var assert = require('assert');

describe("#conversion test", function () {
  var result = svgcode().loadFile(__dirname + "/helloworld.svg").generateGcode().getGcode();
  it("Try to convert an svg to gcode", function () {
    expect(result).to.be.a('array');
  });
  it("Check that the gcode contains values", function () {
    expect(result).to.have.lengthOf.at.least(100);
  });
});

var express = require('express');

var sharp = require('sharp');

var _require = require('./SvGcoder'),
    SvGcoder = _require.SvGcoder;

var app = express();
var port = process.env.PORT || 3000;
app.post('/convert', function _callee(req, res) {
  var files, imageData, svg, gcoder, gcode;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          files = req.files;
          _context.next = 4;
          return regeneratorRuntime.awrap(sharp(files.image.data).grayscale().toBuffer());

        case 4:
          imageData = _context.sent;
          _context.next = 7;
          return regeneratorRuntime.awrap(sharp(imageData).toSvg());

        case 7:
          svg = _context.sent;
          gcoder = new SvGcoder();
          gcoder.loadFile(svg.toString());
          _context.next = 12;
          return regeneratorRuntime.awrap(gcoder.generateGcode().getGcode());

        case 12:
          gcode = _context.sent;
          res.json(gcode);
          _context.next = 20;
          break;

        case 16:
          _context.prev = 16;
          _context.t0 = _context["catch"](0);
          console.error(_context.t0);
          res.status(500).send('Error converting image');

        case 20:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 16]]);
});
app.listen(port, function () {
  return console.log("Server listening on port ".concat(port));
});