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
      message: 'hellow word'  # option description
      callback: ->            # callback description

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
    @getSetting = (settingKey) ->
      @settings[settingKey]

    # call one of the plugin setting functions
    @callSettingFunction = (functionName, args = []) ->
      @settings[functionName].apply(this, args)

    init = =>
      @settings = $.extend({}, @defaults, options)
      @callSettingFunction('callback', [@$element, @getSetting('message')]) 

    # initialise the plugin
    init()

    this

  $.fn.miniAlert = (options) ->
    this.each ->
      if undefined == ($ this).data('pluginName')
        plugin = new $.miniAlert this, options
        ($ this).data 'miniAlert', plugin