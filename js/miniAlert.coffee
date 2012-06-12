#
# CoffeeScript jQuery Plugin Boilerplace
# Author:    Matthieu Aussaguel, http://www.mynameismatthieu.com, @mattaussaguel
# Version:   1.2 Stable
# Updated:   June 11, 2012
# More info: http://minijs.com/
#

jQuery ->
  $.miniAlert = (element, options) ->
    # default plugin settings
    @defaults = 
      text:     'x'       # close button text content
      cssClass: 'close'   # close button css class
      position: 'before'  # close button position: 'before' | 'after'
      effect:   'basic'    # closing effect: 'basic' | fade' | 'slide'
      duration: 100       # hide animation duration in milliseconds
      onLoad:   ->        # callback called when the close button has been added
      onHide:   ->        # callback called when close button is clicked
      onHidden: ->        # callback called when alert message is hidden

    # current state
    @state = ''

    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    # set current state
    setState = (@state) ->

    #get current state
    @getState = -> state

    # get particular plugin setting
    @getSetting = (settingKey) -> @settings[settingKey]

    # call one of the plugin setting functions
    @callSettingFunction = (functionName, args = [@$element, @$button]) ->
      @settings[functionName].apply(this, args)

    removeElement = =>
      @$element.remove()
      @callSettingFunction 'onHidden', []

    init = =>
      @settings = $.extend({}, @defaults, options)
      @$button   = $('<button />', {class: @settings.cssClass, text: @settings.text})

      if @settings.position is 'after'
        @$button.appendTo @$element
      else
        @$button.prependTo @$element 

      @$button.bind('click', (e) =>
        @callSettingFunction 'onHide'
        e.preventDefault()
        if @settings.effect is 'fade'
          @$element.fadeOut @settings.duration, removeElement
        else if @settings.effect is 'slide'
          @$element.slideUp @settings.duration, removeElement
        else
          removeElement()
      )

      @callSettingFunction 'onLoad'

    init()

    this

  $.fn.miniAlert = (options) ->
    this.each ->
      if undefined == ($ this).data('miniAlert')
        plugin = new $.miniAlert this, options
        ($ this).data 'miniAlert', plugin