#!/usr/bin/env node

let puppeteer = require('puppeteer');

(async function() {
  const browser = await puppeteer.launch({args: ['--no-sandbox']});
  const page = await browser.newPage();
  await page.goto('http://localhost:4000/resume', {waitUntil: 'networkidle2'});
  await page.pdf({path: '_site/resume.pdf', format: 'A4'});
  browser.close();
})();
