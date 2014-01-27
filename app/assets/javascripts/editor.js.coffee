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
UP_KEY    = 38
DOWN_KEY  = 40

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

  bindKey: (name, key) ->
    @editor.commands.addCommand
      name: name
      bindKey: key
      exec: (e) -> false

class History
  constructor: ->
    @store = []
    @cache = {}
    @cursor = 0

  stash: (obj) ->
    for key, value of obj
      @cache[key] = value

  flush: ->
    @store.push @cache
    @cache = {}
    @cursor = @store.length

  forward: ->
    @cursor += 1 unless @cursor is @store.length
    @store[@cursor] ? {}

  rewind: ->
    @cursor -= 1 unless @cursor is 0
    @store[@cursor]

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

  history.renderCache()
  history.flush()
  # history.print()
  editor.focus()

window.Module['print'] = (output) ->
  checkAnswer output

root.run = ->
  webruby = new WEBRUBY(print_level: 2)

  history = new History()
  editor = new AceEditor $('#editor')[0]
  editor.bindKey 'up', 'Up'
  editor.bindKey 'down', 'Down'
  editor.setValue "\"Hello, let's start.\""

  $('#editor').keydown (e) ->
    key = e.keyCode
    switch key
      when ENTER_KEY, UP_KEY, DOWN_KEY
        e.preventDefault()
        if key is ENTER_KEY
          input = editor.getValue().trim()
          editor.setValue ''
          evaluate input if input
        else if key is UP_KEY
          editor.setValue history.rewind().input ? ''
        else
          editor.setValue history.forward().output ? ''

  window.onbeforeunload = ->
    webruby.close()
