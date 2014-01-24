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
    @editor.setTheme "ace/theme/tomorrow_night"
    @editor.getSession().setMode('ace/mode/ruby')
    @editor.getSession().setUseSoftTabs true
    @editor.getSession().setTabSize 2
    @editor.renderer.setShowGutter false
    @editor.setHighlightActiveLine false
    @editor.setShowPrintMargin false
    @editor.setReadOnly(true) if options.readOnly

  setValue: (value) ->
    @editor.setValue value

  getValue: ->
    @editor.getValue()

  focus: ->
    @editor.focus()

class History
  constructor: ->
    @buffer = []
    @cache = null

  setInput: (input) ->
    @cache ?= {}
    @cache.input = input

  setOutput: (output) ->
    @cache ?= {}
    @cache.output = output

  flush: ->
    @buffer.push @cache

  printObj: (obj) ->
    for k, v of obj
      console.log "#{k}: #{v}"

  print: ->
    for obj in @buffer
      @printObj obj

  renderCache: ->
    attempts = $('.attempts')
    prompt = '<span class="prompt">' + $('.answer .prompt').text() + '</span>'

    attempts.append '<div class="attempt"></div>'
    $('.attempt').last().append '<div class="input"></div><div class="output"></div>'

    input = $('.input').last()
    output = $('.output').last()

    input.append prompt
    viewerID = "viewer-#{@buffer.length}"
    input.append "<div id=#{viewerID} class=\"viewer\"></div>"
    # $('.attempt').last().find('.input .viewer').text(@cache.input)
    viewer = new AceEditor($("##{viewerID}")[0], readOnly: true)
    viewer.setValue @cache.input

    output.append prompt
    output.append "<span class=\"result\">#{@cache.output}</span>"

evaluate = (input) ->
  console.log "ev-input: #{input}"
  history.setInput input.stripQuotes()
  webruby.run_source input

checkAnswer = (output) ->
  output = output.stripQuotes()
  history.setOutput output
  if answer is output
    console.log 'correct'
  else
    console.log 'wrong'
  history.flush()
  history.print()
  history.renderCache()
  editor.focus()

window.Module["print"] = (output) ->
  checkAnswer output

$ ->
  webruby = new WEBRUBY(print_level: 2)

  history = new History()
  editor = new AceEditor $('#editor')[0]
  editor.setValue "Hello, let's start."

  $('#editor').keydown (e) ->
    if e.keyCode == ENTER_KEY
      e.preventDefault()
      console.log editor
      input = editor.getValue().trim()
      editor.setValue ''
      evaluate input if input

  window.onbeforeunload = ->
    webruby.close()
