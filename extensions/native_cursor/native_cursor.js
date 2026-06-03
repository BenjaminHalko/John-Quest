// native_cursor.js
// CSS-based custom cursor for GameMaker HTML5 / GX Games targets.
//
// Design:
//   - Each cursor frame is encoded as a PNG data URL and installed as a CSS
//     rule of the form:
//         canvas[data-cursor="cID-N"] { cursor: url("data:image/png;...") HX HY, auto; }
//   - Switching cursors / animation frames is a single setAttribute call, so the
//     browser's compositor paints the cursor at the display refresh rate,
//     completely independent of the GameMaker step rate.
//   - Animation is driven by requestAnimationFrame, NOT setInterval and NOT the
//     GML step event, which is what "framerate independent of the game update
//     rate" means here.
//
// All 12 functions exported below match the names registered in
// native_cursor.yy for the JS file. Return types match the desktop autogen
// path closely enough that scripts/nativeCursorFunctions/nativeCursorFunctions.gml
// can treat the returned ID as an opaque cursor handle.

(function () {
    "use strict";

    // ------------------------------------------------------------------
    // Module state
    // ------------------------------------------------------------------
    var cursors        = Object.create(null); // id -> Cursor
    var nextId         = 1;
    var current        = null;                // currently active Cursor (or null)
    var canvas         = null;                // target <canvas> element
    var styleEl        = null;                // <style> we own
    var styleSheet     = null;                // styleEl.sheet
    var rafId          = 0;                   // active requestAnimationFrame id
    var lastFrameKey   = "";                  // last data-cursor value we wrote
    var encodeCanvas   = null;                // offscreen canvas reused for PNG encode

    // ------------------------------------------------------------------
    // Canvas resolution
    //
    // window_handle() in current GameMaker HTML5 / GX Games runtimes returns
    // the canvas DOM element directly, not an ID string. The previous Haxe-
    // generated code called document.getElementById on it, which silently
    // returned null and broke everything. Handle every plausible form.
    // ------------------------------------------------------------------
    function resolveCanvas(arg) {
        if (arg && typeof arg === "object" && arg.nodeType === 1) {
            return arg;
        }
        if (typeof arg === "string" && arg.length > 0) {
            var byId = document.getElementById(arg);
            if (byId) return byId;
        }
        return (
            document.getElementById("canvas") ||
            document.getElementById("gm-canvas") ||
            document.querySelector("canvas")
        );
    }

    // ------------------------------------------------------------------
    // PNG encoding
    //
    // GameMaker hands us base64(RGBA pixels) from buffer_get_surface. Decode
    // into a Uint8ClampedArray, drop it into an ImageData, blit it to a
    // hidden canvas, then ask the canvas for a PNG data URL. Chromium
    // (and therefore GX Games) accepts PNG data URLs as CSS cursors with
    // hotspot offsets, so we do not need the old ICO encoder.
    // ------------------------------------------------------------------
    function pixelsToPngDataURL(b64, width, height) {
        var bin    = atob(b64);
        var stride = width * height * 4;
        var bytes  = new Uint8ClampedArray(stride);
        for (var i = 0; i < stride; i++) bytes[i] = bin.charCodeAt(i);

        if (!encodeCanvas) encodeCanvas = document.createElement("canvas");
        encodeCanvas.width  = width;
        encodeCanvas.height = height;

        var ctx = encodeCanvas.getContext("2d");
        ctx.clearRect(0, 0, width, height);
        ctx.putImageData(new ImageData(bytes, width, height), 0, 0);
        return encodeCanvas.toDataURL("image/png");
    }

    // ------------------------------------------------------------------
    // Cursor: a list of frames, each its own CSS rule.
    // ------------------------------------------------------------------
    function Cursor(id) {
        this.id         = id;
        this.frames     = [];        // [{hx, hy}, ...] - URL is encoded into the CSS rule
        this.framerate  = 30;        // frames per second
        this.timeStart  = Date.now();
        this.timeOffset = 0;
    }

    Cursor.prototype.addFrame = function (b64, w, h, hx, hy) {
        var url        = pixelsToPngDataURL(b64, w, h);
        var frameIndex = this.frames.length;
        this.frames.push({ hx: hx, hy: hy });

        if (styleSheet) {
            // !important is required because GameMaker's HTML5 runner can
            // touch canvas.style.cursor during its own init / focus / fullscreen
            // paths, and inline styles otherwise beat stylesheet rules on
            // specificity. With !important the rule always wins.
            var selector = 'canvas[data-cursor="c' + this.id + "-" + frameIndex + '"]';
            var rule     = selector + ' { cursor: url("' + url + '") ' + hx + ' ' + hy + ', auto !important; }';
            try {
                styleSheet.insertRule(rule, styleSheet.cssRules.length);
            } catch (e) {}
        }
    };

    Cursor.prototype.frameIndex = function () {
        var n = this.frames.length;
        if (n <= 1) return 0;
        var elapsed = (this === current)
            ? (Date.now() - this.timeStart)
            : this.timeOffset;
        var idx = Math.floor(elapsed * this.framerate / 1000) % n;
        if (idx < 0) idx += n;
        return idx;
    };

    Cursor.prototype.dispose = function () {
        if (!styleSheet) return;
        var prefix = 'canvas[data-cursor="c' + this.id + "-";
        var rules  = styleSheet.cssRules;
        for (var i = rules.length - 1; i >= 0; i--) {
            var sel = rules[i].selectorText || "";
            if (sel.indexOf(prefix) === 0) {
                styleSheet.deleteRule(i);
            }
        }
        this.frames = [];
    };

    // ------------------------------------------------------------------
    // Animation loop
    //
    // requestAnimationFrame is paced by the browser's compositor, so the
    // cursor's visible frame advances at display refresh rate regardless of
    // how often GameMaker steps. We only start the loop when the current
    // cursor actually has multiple frames; a single-frame cursor is applied
    // once in native_cursor_set and the loop stays idle.
    // ------------------------------------------------------------------
    function tickStep() {
        rafId = 0;
        if (!current || current.frames.length <= 1) return;

        if (!canvas || !canvas.isConnected) {
            canvas = resolveCanvas(null);
            if (!canvas) return;
            if (canvas.style.cursor !== "") canvas.style.cursor = "";
        }

        var key = "c" + current.id + "-" + current.frameIndex();
        if (key !== lastFrameKey) {
            lastFrameKey = key;
            canvas.setAttribute("data-cursor", key);
        }
        rafId = window.requestAnimationFrame(tickStep);
    }

    function startTick() {
        if (rafId) return;
        rafId = window.requestAnimationFrame(tickStep);
    }

    function stopTick() {
        if (rafId) {
            window.cancelAnimationFrame(rafId);
            rafId = 0;
        }
    }

    // ------------------------------------------------------------------
    // Init
    // ------------------------------------------------------------------
    function init(canvasArg) {
        canvas = resolveCanvas(canvasArg);
        if (!canvas) return false;

        if (!styleEl) {
            styleEl    = document.createElement("style");
            styleEl.id = "native-cursor-styles";
            (document.head || document.body || document.documentElement).appendChild(styleEl);
            styleSheet = styleEl.sheet;
            try {
                styleSheet.insertRule(
                    'canvas[data-cursor="hide"] { cursor: none !important; }',
                    0
                );
            } catch (e) {}
        }
        return true;
    }

    // ------------------------------------------------------------------
    // Exports
    //
    // Names must match the function names registered for native_cursor.js
    // in native_cursor.yy. GameMaker's HTML5 runner looks them up on the
    // global object, so we attach to window.
    // ------------------------------------------------------------------
    window.native_cursor_preinit_raw = function (canvasArg /*, _swap_br */) {
        return init(canvasArg);
    };

    window.native_cursor_create_empty = function () {
        var id = nextId++;
        cursors[id] = new Cursor(id);
        return id;
    };

    window.native_cursor_create_from_buffer = function (buf, w, h, hx, hy, fps) {
        var id = window.native_cursor_create_empty();
        var c  = cursors[id];
        if (typeof fps === "number" && fps > 0) c.framerate = fps;
        c.addFrame(buf, w, h, hx, hy);
        return id;
    };

    window.native_cursor_add_from_buffer = function (id, buf, w, h, hx, hy) {
        var c = cursors[id];
        if (c) c.addFrame(buf, w, h, hx, hy);
        return id;
    };

    window.native_cursor_destroy = function (id) {
        var c = cursors[id];
        if (!c) return;
        if (c === current) {
            current      = null;
            lastFrameKey = "";
            if (canvas) canvas.removeAttribute("data-cursor");
            stopTick();
        }
        c.dispose();
        delete cursors[id];
    };

    window.native_cursor_set = function (id) {
        var c = cursors[id];
        if (!c) return;

        // Preserve animation phase on the outgoing cursor.
        if (current && current !== c) {
            current.timeOffset = Date.now() - current.timeStart;
        }
        current      = c;
        c.timeStart  = Date.now() - c.timeOffset;
        lastFrameKey = "";

        if (!canvas || !canvas.isConnected) canvas = resolveCanvas(null);
        if (!canvas) return;

        // Clear any inline cursor so our stylesheet rule can apply. An
        // inline style would otherwise out-specificity the rule (the rule
        // also carries !important; this is belt-and-suspenders).
        if (canvas.style.cursor !== "") canvas.style.cursor = "";

        if (c.frames.length > 0) {
            var key = "c" + c.id + "-" + c.frameIndex();
            lastFrameKey = key;
            canvas.setAttribute("data-cursor", key);
        }

        if (c.frames.length > 1) startTick();
        else stopTick();
    };

    window.native_cursor_reset = function () {
        if (current) {
            current.timeOffset = Date.now() - current.timeStart;
            current = null;
        }
        lastFrameKey = "";
        if (!canvas || !canvas.isConnected) canvas = resolveCanvas(null);
        if (canvas) {
            if (canvas.style.cursor !== "") canvas.style.cursor = "";
            canvas.setAttribute("data-cursor", "hide");
        }
        stopTick();
    };

    window.native_cursor_update = function () {
        // Kept for ABI compatibility with the desktop libs. The rAF loop is
        // the real driver here, so this is intentionally a no-op.
        return false;
    };

    window.native_cursor_get_frame = function (id) {
        var c = cursors[id];
        return c ? c.frameIndex() : -1;
    };

    window.native_cursor_set_frame = function (id, frame) {
        var c = cursors[id];
        if (!c) return;
        var n = c.frames.length;
        if (n <= 0) return;
        frame = ((frame % n) + n) % n;
        var off = Math.floor(frame * 1000 / c.framerate);
        if (c === current) c.timeStart  = Date.now() - off;
        else               c.timeOffset = off;
    };

    window.native_cursor_get_framerate = function (id) {
        var c = cursors[id];
        return c ? c.framerate : 0;
    };

    window.native_cursor_set_framerate = function (id, fps) {
        var c = cursors[id];
        if (c && fps > 0) c.framerate = fps;
    };
})();
