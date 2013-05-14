class System
  constructor: ->
    @html =
      url:  "http://httpbin.org/html"
      heading:
        selector: "H1"
        expectedText: "Herman Melville - Moby-Dick"
    @search =
      url: "http://www.google.com"
      data: 
        q: "core bvba"
    @searchResults =
      titles:
        selector: "h3"
        expectedText: "Tom's ramblings | Random opinionated blurbs"
        
module.exports = new System()
        
