// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import "phoenix_html"

import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()

// to resize the sections on base of the scrollHeight
window.auto_grow = function auto_grow(element) {
  console.log("ok")
  element.style.height = "5px";
  element.style.height = (element.scrollHeight)+"px";
}

// particles OwO
import "particles.js"

particlesJS.load('particles-js', '/particles.json', function() {
  console.log('callback - particles.js config loaded');
});
