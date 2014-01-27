root = exports ? this

String::trim ?= ->
  @replace /^\s+|\s+$/gm, ''

String::stripQuotes ?= ->
  [first, last] = [0, @length]
  first += 1 if @[0] is '"'
  last -= 1 if @[last-1] is '"'
  @slice first, last

Array::last ?= ->
  @[@length - 1]

ENTER_KEY = 13

webruby = undefined
window.Module = {}
editor = undefined
history = undefined

problem = "Concatenate the strings 'cow' and 'boy'."
answer = "cowboy"

class AceEditor
  constructor: (@selector, options = {}) ->
    options.readOnly ?= false
    @editor = ace.edit @selector
    @editor.setTheme 'ace/theme/tomorrow_night'
    @editor.getSession().setMode 'ace/mode/ruby'
    @editor.getSession().setUseSoftTabs true
    @editor.getSession().setTabSize 2
    @editor.renderer.setShowGutter false
    @editor.setHighlightActiveLine false
    @editor.setShowPrintMargin false
    @editor.setReadOnly(true) if options.readOnly

  setValue: (value) ->
    @editor.setValue value
    @editor.clearSelection()

  getValue: ->
    @editor.getValue()

  focus: ->
    @editor.focus()

class History
  constructor: ->
    @store = []
    @cache = null

  stash: (obj) ->
    @cache ?= {}
    for key, value of obj
      @cache[key] = value

  flush: ->
    @store.push @cache

  printObj: (obj) ->
    for key, value of obj
      console.log "#{key}: #{value}"

  print: ->
    for obj in @store
      @printObj obj

  renderCache: ->
    $('.attempts').append '<div class="attempt"></div>'
    $('.attempt').last().append '<div class="input"></div><div class="output"></div>'

    input = $('.input').last()
    output = $('.output').last()

    input.append "<span class=\"prompt\">=&gt</span>"
    viewerID = "viewer-#{@store.length}"
    input.append "<div id=#{viewerID} class=\"viewer\"></div>"
    viewer = new AceEditor($("##{viewerID}")[0], readOnly: true)
    viewer.setValue @cache.input

    output.append "<span class=\"prompt\">-&gt;</span>"
    output.append "<span class=\"result #{@cache.outputClass}\">#{@cache.output}</span>"

evaluate = (input) ->
  history.stash input: input
  webruby.run_source input

checkAnswer = (output) ->
  history.stash
    output: output
    outputClass: if answer is output.stripQuotes() then 'correct-output' else 'wrong-output'

  history.flush()
  # history.print()
  history.renderCache()
  editor.focus()

window.Module['print'] = (output) ->
  checkAnswer output

root.run = ->
  webruby = new WEBRUBY(print_level: 2)

  history = new History()
  editor = new AceEditor $('#editor')[0]
  editor.setValue "\"Hello, let's start.\""

  $('#editor').keydown (e) ->
    if e.keyCode == ENTER_KEY
      e.preventDefault()
      input = editor.getValue().trim()
      editor.setValue ''
      evaluate input if input

  window.onbeforeunload = ->
    webruby.close()
