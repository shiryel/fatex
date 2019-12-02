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

// handle add images
const hooks = {
    evidence_upload: {
        mounted() {
            this.el.addEventListener("change", e => {
                
                toBase64(this.el.files[0]).then(base64 => {
                    var hidden = document.getElementById("values_evidence_upload_base64") // change this to the ID of your hidden input
                    hidden.value = base64;
                    hidden.focus() // this is needed to register the new value with live view
                });        
            })
        }
    }
}

// start liveview
let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()

// handle add images
const toBase64 = file => new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
});


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

