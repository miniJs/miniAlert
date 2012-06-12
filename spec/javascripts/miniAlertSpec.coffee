describe "miniAlert", ->

  beforeEach ->
    loadFixtures 'fragment.html'
    @$element = $ '.mini-alert'

  it "should be available on the jQuery object", ->
    expect($.fn.miniAlert).toBeDefined()

  it "should be chainable", ->
    expect(@$element.miniAlert()).toBe(@$element)

  it "should offers default values", ->
    plugin = new $.miniAlert(@$element[0])
    expect(plugin.defaults).toBeDefined()

  it "should overwrites the settings", ->
    options = {text: 'y',  position: 'after'}
    plugin = new $.miniAlert(@$element[0], options)
    expect(plugin.settings.text).toBe(options.text)
    expect(plugin.settings.position).toBe(options.position)

  describe "button", ->

    describe "defaults options", ->
      beforeEach ->
        @plugin = new $.miniAlert(@$element, @options)
        @$button = @$element.find 'button'

      it "should add a button to the alert", ->
        expect(@$button).toExist()

      it "should prepend the button to the alert if position is default", ->
        expect(@$button.next('h1')).toExist()
        expect(@$button.prev('p')).not.toExist()

      it "should add a button with 'x' as content", ->
        expect(@$button).toHaveText 'x'

      it "should add a button with 'close' class", ->
        expect(@$button).toHaveClass 'close'

      it "should prevent default on click event", ->
        spyOnEvent(@$button, 'click')
        @$button.click()
        expect('click').toHaveBeenPreventedOn(@$button)

      it "should fade out the element for 100 milliseconds when button clicked", ->
        spyOn(@plugin.$element, 'remove')
        @$button.click()
        expect(@plugin.$element.remove).toHaveBeenCalled()


    describe "custom options", ->
      it "should append the button to the alert if position is 'after", ->
        @$element.miniAlert(position: 'after')
        $button = @$element.find 'button'

        expect($button.prev('p')).toExist()
        expect($button.next()).not.toExist()

      it "should add a button with 'close' as content", ->
        @$element.miniAlert(text: 'close')

        expect(@$element.find('button')).toHaveText 'close'

      it "should add a button with 'hide' class", ->
        @$element.miniAlert(cssClass: 'hide')

        expect(@$element.find('button')).toHaveClass 'hide'

      it "should slide up the element for 200 milliseconds when button clicked", ->
        plugin = new $.miniAlert(@$element, {effect: 'slide', duration: 200})
        spyOn(plugin.$element, 'slideUp')
        @$element.find('button').click()

        expect(plugin.$element.slideUp).toHaveBeenCalledWith(200, jasmine.any(Function))

      it "should fade out the element for 100 milliseconds when button clicked", ->
        plugin = new $.miniAlert(@$element, {effect: 'fade'})
        spyOn(plugin.$element, 'fadeOut')
        @$element.find('button').click()

        expect(plugin.$element.fadeOut).toHaveBeenCalledWith(100, jasmine.any(Function))

  describe "callbacks", ->
    beforeEach ->
      @foo = jasmine.createSpy('foo')

    it "should call onLoad callback function when the close button is ready", ->
      plugin = new $.miniAlert(@$element, {onLoad: @foo})
      expect(@foo).toHaveBeenCalled()
      expect(@foo.mostRecentCall.args[0]).toBe @$element
      expect(@foo.mostRecentCall.args[1]).toBe @$element.find('button')


    it "should call onHide callback function when close button is clicked", ->
      plugin = new $.miniAlert(@$element, {onHide: @foo})
      expect(@foo).not.toHaveBeenCalled()

      @$element.find('button').click()
      expect(@foo).toHaveBeenCalled()
      expect(@foo.mostRecentCall.args[0]).toBe @$element
      expect(@foo.mostRecentCall.args[1]).toBe @$element.find('button')

    it "should call onHidden callback function when alert message is hidden", ->
      plugin = new $.miniAlert(@$element, {onHidden: @foo})

      @$element.find('button').click()
      expect(@foo).toHaveBeenCalled()
      expect(@foo.mostRecentCall.args.length).toEqual(0)

