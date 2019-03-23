// with help from (MIT license):
// https://github.com/barisaydinoglu/Detectizr/blob/master/src/detectizr.js
var UA = {
  userAgent: null,
  getUserAgentStr: function() {
    return (navigator.userAgent || navigator.vendor || window.opera || "").toLowerCase()
  },
  is: function(key) { return UA.userAgent.indexOf(key) > -1 },
  test: function(regex) { return regex.test(UA.userAgent) },
  setVersion: function(os, version, modern) {
    os.version = version
    os.modern = modern
  },
  detectOSX: function(os, version) {
    var map = UA.osxVersions
    for (var key in map) {
      if (map.hasOwnProperty(key) && RegExp("("+key+")").test(version)) {
        os.version = map[key].name
        os.bitness = map[key].bitness
        os.modern = map[key].modern
        return
      }
    }
    os.version = "unknown"
    os.bitness = "unknown"
  },
  // map string fragment to osx version
  osxVersions: {
    "10_6": {name: "10.6 Snow Leopard", bitness: "unknown"},
    "10_7": {name: "10.7 Lion", bitness: "64bit"},
    "10_8": {name: "10.8 Mountain Lion", bitness: "64bit"},
    "10_9": {name: "10.9 Mavericks", bitness: "64bit"},
    "10_10": {name: "10.10 Yosemite", bitness: "64bit", modern: true},
    "10_11": {name: "10.11 El Capitan", bitness: "64bit", modern: true},
    "10_12": {name: "10.12 Sierra", bitness: "64bit", modern: true},
    "10_13": {name: "10.13 High Sierra", bitness: "64bit", modern: true}
  },
  detect: function(userAgent) {
    UA.userAgent = userAgent.toLowerCase()
    var os = { modern: false }
    if (UA.is("win") || UA.is("16bit")) {
      os.name = "Windows"
      if (UA.is("windows nt 10")) {
        UA.setVersion(os, "10", true)
      } else if (UA.is("windows nt 6.3")) {
        UA.setVersion(os, "8.1", true)
      } else if (UA.is("windows nt 6.2") || UA.test(/\(windows 8\)/)) {
        UA.setVersion(os, "8", true)
      } else if (UA.is("windows nt 6.1")) {
        UA.setVersion(os, "7")
      } else if (UA.is("windows nt 6.0")) {
        UA.setVersion(os, "vista")
      } else if (UA.is("windows nt 5.2") || UA.is("windows nt 5.1") || UA.is("windows xp")) {
        UA.setVersion(os, "xp")
      } else if (UA.is("windows nt 5.0") || UA.is("windows 2000")) {
        UA.setVersion(os, "2k")
      } else if (UA.is("winnt") || UA.is("windows nt")) {
        UA.setVersion(os, "nt")
      } else if (UA.is("win98") || UA.is("windows 98")) {
        UA.setVersion(os, "98")
      } else if (UA.is("win95") || UA.is("windows 95")) {
        UA.setVersion(os, "95")
      }
    } else if (UA.is("mac") || UA.is("darwin")) {
      os.name = "Mac OS"
      if (UA.is("68k") || UA.is("68000")) {
        UA.setVersion(os, "68k")
      } else if (UA.is("ppc") || UA.is("powerpc")) {
        UA.setVersion(os, "ppc")
      } else if (UA.is("os x")) {
        if (UA.test(/os\sx\s([\d_]+)/) ) {
          os.name = "Mac OS X"
          UA.detectOSX(os, RegExp.$1)
        }
      }
    } else if (UA.is("x11") || UA.is("inux")) {
      os.name = "Linux"
    }
    if (UA.test(/\sx64|\sx86|\swin64|\swow64|\samd64/)) {
      os.bitness = "64bit"
    } else {
      os.bitness = "32bit"
    }
    return os
    }
  }

  var os = UA.detect(UA.getUserAgentStr())

  document.getElementById('os').innerHTML = os.name
  document.getElementById('bitness').innerHTML = os.bitness || "unknown"
  document.getElementById('version').innerHTML = os.version || "unknown"
