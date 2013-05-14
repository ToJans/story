story = require "./story"
system = require "./system"

story "Automate the browser in an easy way",
  
  "Get some text from a http request and assert it": (browser) ->
  
    browser.get system.html.url
    text = browser.elementByCss(system.html.heading.selector).text()
    text.should.include system.html.heading.expectedText
    
    
  "Searching on google for core bvba should redirect to my site": (browser) ->
  
    browser.get system.search.url
    browser.submit system.search.data
    browser.setWaitTimeout 3*1000
    text = browser.elementByCss(system.searchResults.titles.selector).text()
    text.should.equal system.searchResults.titles.expectedText
    
    
  
