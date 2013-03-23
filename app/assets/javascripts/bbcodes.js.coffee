# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $.each $("[data-tag]"), (index, value) ->
    $(value).click ->
      i = $("#message_text")[0].selectionStart
      e = $("#message_text")[0].selectionEnd
      text = $("#message_text").val()
      mid = $(this).data("tag").replace(/^(.+)\?(.+?)$/, '$1'+text.substring(i, e)+'$2')
      $("#message_text").val text.substring(0, i) + mid + text.substring(e, text.length)
      true
    true
  true
#
# * jQuery CSSEmoticons plugin 0.2.9
# *
# * Copyright (c) 2010 Steve Schwartz (JangoSteve)
# *
# * Dual licensed under the MIT and GPL licenses:
# *   http://www.opensource.org/licenses/mit-license.php
# *   http://www.gnu.org/licenses/gpl.html
# *
# * Date: Sun Oct 22 1:00:00 2010 -0500
# 
((a) ->
  a.fn.emoticonize = (m) ->
    c = a.extend({}, a.fn.emoticonize.defaults, m)
    d = [")", "(", "*", "[", "]", "{", "}", "|", "^", "<", ">", "\\", "?", "+", "=", "."]
    l = [":-)", ":o)", ":c)", ":^)", ":-D", ":-(", ":-9", ";-)", ":-P", ":-p", ":-Þ", ":-b", ":-O", ":-/", ":-X", ":-#", ":'(", "B-)", "8-)", ";*(", ":-*", ":-\\", "?-)", ": )", ": ]", "= ]", "= )", "8 )", ": }", ": D", "8 D", "X D", "x D", "= D", ": (", ": [", ": {", "= (", "; )", "; ]", "; D", ": P", ": p", "= P", "= p", ": b", ": Þ", ": O", "8 O", ": /", "= /", ": S", ": #", ": X", "B )", ": |", ": \\", "= \\", ": *", ": &gt;", ": &lt;"]
    j = [":)", ":]", "=]", "=)", "8)", ":}", ":D", ":(", ":[", ":{", "=(", ";)", ";]", ";D", ":P", ":p", "=P", "=p", ":b", ":Þ", ":O", ":/", "=/", ":S", ":#", ":X", "B)", ":|", ":\\", "=\\", ":*", ":&gt;", ":&lt;"]
    h =
      "&gt;:)":
        cssClass: "red-emoticon small-emoticon spaced-emoticon"

      "&gt;;)":
        cssClass: "red-emoticon small-emoticon spaced-emoticon"

      "&gt;:(":
        cssClass: "red-emoticon small-emoticon spaced-emoticon"

      "&gt;: )":
        cssClass: "red-emoticon small-emoticon"

      "&gt;; )":
        cssClass: "red-emoticon small-emoticon"

      "&gt;: (":
        cssClass: "red-emoticon small-emoticon"

      ";(":
        cssClass: "red-emoticon spaced-emoticon"

      "&lt;3":
        cssClass: "pink-emoticon counter-rotated"

      "&lt;/3":
        cssClass: "red-emoticon counter-rotated"

      "&lt;|3":
        cssClass: "red-emoticon counter-rotated"

      "&lt;\\3":
        cssClass: "red-emoticon counter-rotated"

      O_O:
        cssClass: "no-rotate"

      o_o:
        cssClass: "no-rotate"

      "0_o":
        cssClass: "no-rotate"

      O_o:
        cssClass: "no-rotate"

      T_T:
        cssClass: "no-rotate"

      "^_^":
        cssClass: "no-rotate"

      "O:)":
        cssClass: "small-emoticon spaced-emoticon"

      "O: )":
        cssClass: "small-emoticon"

      "8D":
        cssClass: "small-emoticon spaced-emoticon"

      XD:
        cssClass: "small-emoticon spaced-emoticon"

      xD:
        cssClass: "small-emoticon spaced-emoticon"

      "=D":
        cssClass: "small-emoticon spaced-emoticon"

      "8O":
        cssClass: "small-emoticon spaced-emoticon"

      "[+=..]":
        cssClass: "no-rotate nintendo-controller"

    f = new RegExp("(\\" + d.join("|\\") + ")", "g")
    n = "(^|[\\s\\0])"
    g = l.length - 1

    while g >= 0
      l[g] = l[g].replace(f, "\\$1")
      l[g] = new RegExp(n + "(" + l[g] + ")", "g")
      --g
    g = j.length - 1

    while g >= 0
      j[g] = j[g].replace(f, "\\$1")
      j[g] = new RegExp(n + "(" + j[g] + ")", "g")
      --g
    for k of h
      h[k].regexp = k.replace(f, "\\$1")
      h[k].regexp = new RegExp(n + "(" + h[k].regexp + ")", "g")
    e = "span.css-emoticon"
    e += "," + c.exclude  if c.exclude
    b = e.split(",")
    @not(e).each ->
      o = a(this)
      i = "css-emoticon"
      i += " un-transformed-emoticon animated-emoticon"  if c.animate
      for p of h
        specialCssClass = i + " " + h[p].cssClass
        o.html o.html().replace(h[p].regexp, "$1<span class='" + specialCssClass + "'>$2</span>")
      a(l).each ->
        o.html o.html().replace(this, "$1<span class='" + i + "'>$2</span>")

      a(j).each ->
        o.html o.html().replace(this, "$1<span class='" + i + " spaced-emoticon'>$2</span>")

      a.each b, (q, r) ->
        o.find(a.trim(r) + " span.css-emoticon").each ->
          a(this).replaceWith a(this).text()


      if c.animate
        setTimeout (->
          a(".un-transformed-emoticon").removeClass "un-transformed-emoticon"
        ), c.delay


  a.fn.unemoticonize = (b) ->
    c = a.extend({}, a.fn.emoticonize.defaults, b)
    @each ->
      d = a(this)
      d.find("span.css-emoticon").each ->
        e = a(this)
        if c.animate
          e.addClass "un-transformed-emoticon"
          setTimeout (->
            e.replaceWith e.text()
          ), c.delay
        else
          e.replaceWith e.text()



  a.fn.emoticonize.defaults =
    animate: true
    delay: 500
    exclude: "pre,code,.no-emoticons"
) jQuery
