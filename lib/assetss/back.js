#!/usr/bin/env node

"use strict";

var expect = require("chai").expect;
var svgcode = require("../index");
var assert = require('assert');

describe("#conversion test", function() {
    const result = svgcode()
    .loadFile(__dirname + "/helloworld.svg")
    .generateGcode()
    .getGcode();

    it("Try to convert an svg to gcode", function() {
    expect(result).to.be.a('array');
});
it("Check that the gcode contains values", function() {
    expect(result).to.have.lengthOf.at.least(100);
});

});

const express = require('express');
const sharp = require('sharp');
const { SvGcoder } = require('./SvGcoder');

const app = express();
const port = process.env.PORT || 3000;

app.post('/convert', async (req, res) => {
    try {
        const { files } = req;
        const imageData = await sharp(files.image.data).grayscale().toBuffer();
        const svg = await sharp(imageData).toSvg();
        const gcoder = new SvGcoder();
        gcoder.loadFile(svg.toString());
        const gcode = await gcoder.generateGcode().getGcode();
        res.json(gcode);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error converting image');
    }
});

app.listen(port, () => console.log(`Server listening on port ${port}`));
