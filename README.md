# shark.github.io

## Building

### Prerequisites

- Ruby 2.3.0 with Bundler
- NodeJS with npm

### Installing

- `git clone git@github.com:Shark/shark.github.io.git portfolio`
- `cd portfolio`
- `git clone git@github.com:Shark/shark.github.io.git -b master _site`
- `bundle`
- `npm install -g bower grunt-cli`
- `npm install`
- `bower install`

## Usage

`grunt serve` starts a local web server with live reload

`rake deploy` builds the site, commits the result in `_site` and pushes the `_site` Git repo to `origin` `master`.
