(->

  ENTER_KEY = 13

  window.Module = {}

  webruby = undefined
  editor = undefined
  history = []

  problem = "Concatenate the strings 'cow' and 'boy'."
  answer = "cowboy"

  String::stripQuotes ?= ->
    [first, last] = [0, @length]
    first += 1 if @[0] is '"'
    last -= 1 if @[last-1] is '"'
    return @slice(first, last)

  Array::last ?= ->
    @[@length - 1]

  setValue = (input) ->
    editor.session.setValue(input)

  updateHistory = () ->

  checkAnswer = (output) ->
    if output is answer
      console.log 'correct'
    else
      console.log 'wrong'

  window.Module["print"] = (output) ->
    output = output.stripQuotes()
    history.last().output = output
    checkAnswer output
    updateHistory()
    console.log output
    console.log history

  createEditor = (id) ->
    editor = ace.edit id
    editor.setTheme "ace/theme/tomorrow_night"
    editor.getSession().setMode('ace/mode/ruby')
    # editor.getSession().setUseSoftTabs true
    editor.getSession().setTabSize 2
    editor.renderer.setShowGutter false
    editor.setHighlightActiveLine false
    editor.setShowPrintMargin false
    editor

  evaluate = (input) ->
    console.log "input: #{input}"
    history.push { input: input.stripQuotes(), output: null }
    webruby.run_source input

  $(document).ready ->
    webruby = new WEBRUBY(print_level: 2)

    editor = createEditor 'editor'
    editor.setValue "puts 'string'"

    $('#editor').keydown (e) ->
      if e.keyCode == ENTER_KEY
        e.preventDefault()
        input = editor.getValue()
        evaluate input if input

    window.onbeforeunload = ->
      webruby.close()

)()
