#!/usr/bin/env node
'use strict';

var Gcanvas = require("gcanvas");

var canvg = require("canvg");

var fs = require("fs");

var SvGcoder = function SvGcoder() {
  var output2Array = function output2Array(target) {
    return {
      write: function write(cmd) {
        target.push(cmd);
      }
    };
  };

  var defaultOptions = {
    toolDiameter: 1,
    depth: 10,
    ramping: false,
    precision: 0.1
  };
  var obj = {
    svgFile: null,
    gCode: [],
    gctx: {},
    loadFile: function loadFile(input) {
      this.svgFile = fs.readFileSync(input, "utf8");
      return this;
    },
    setDriver: function setDriver(input) {
      this.gctx = new Gcanvas(new Gcanvas.GcodeDriver(input));
      return this;
    },
    setOptions: function setOptions(input) {
      var _this = this;

      Object.keys(input).forEach(function (opt) {
        _this.gctx[opt] = input[opt];
      });
      return this;
    },
    generateGcode: function generateGcode() {
      canvg(this.gctx.canvas, this.svgFile);
      return this;
    },
    printGcode: function printGcode() {
      console.log(this.gCode);
    },
    getGcode: function getGcode() {
      return this.gCode;
    }
  };
  obj.setDriver(output2Array(obj.gCode));
  obj.setOptions(defaultOptions);
  return obj;
};

module.exports = SvGcoder;