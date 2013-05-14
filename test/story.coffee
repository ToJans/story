module.exports = (title,scenarios) ->
  browser = null
  wdSync = require 'wd-sync'
  wrap = wdSync.wrap
    with: -> browser
    pre: ->
      @timeout 60*1000*5

  describe title,->
    before (done) ->       
      {browser} = wdSync.remote()
      done()
    it 'should open the browser', wrap ->
      browser.init browserName:'chrome'   
      browser.submit = (formdata) ->
        fld = null
        for k,v of formdata
          fld = browser.elementByName k
          browser.type fld,v
        browser.type fld,'\n'

    before (done) ->
      for nm,fnc of scenarios when nm == 'before'
        do(nm, fnc) ->
          it nm, wrap ->
            fnc browser
      done()
    for nm,fnc of scenarios when nm not in ['before','after','beforeEach','afterEach']
      do(nm, fnc) ->
        it nm, wrap  ->
          before (done) ->
            for nm,fnc of scenarios when nm == 'beforeEach'
              do(nm, fnc) ->
                 fnc browser
            done()
          fnc browser
          after (done) ->
            for nm,fnc of scenarios when nm == 'afterEach'
              do(nm, fnc) ->
                fnc browser
            done()
          
    for nm,fnc of scenarios when nm == 'after'
      after (done) ->
        do(nm, fnc) ->
          it nm, wrap ->
            fnc browser
        done()
    it 'should close the browser', wrap ->
      browser.quit()
      
    
