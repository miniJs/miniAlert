// Generated by CoffeeScript 1.3.3
(function() {

  describe("miniAlert", function() {
    beforeEach(function() {
      loadFixtures('fragment.html');
      return this.$element = $('.minialert');
    });
    it("should be available on the jQuery object", function() {
      return expect($.fn.miniAlert).toBeDefined();
    });
    it("should be chainable", function() {
      return expect(this.$element.miniAlert()).toBe(this.$element);
    });
    it("should offers default values", function() {
      var plugin;
      plugin = new $.miniAlert(this.$element[0]);
      return expect(plugin.defaults).toBeDefined();
    });
    it("should overwrites the settings", function() {
      var options, plugin;
      options = {
        text: 'y',
        position: 'after'
      };
      plugin = new $.miniAlert(this.$element[0], options);
      expect(plugin.settings.text).toBe(options.text);
      return expect(plugin.settings.position).toBe(options.position);
    });
    describe("button", function() {
      describe("defaults options", function() {
        beforeEach(function() {
          this.$element.miniAlert();
          return this.$button = this.$element.find('button');
        });
        it("should add a button to the alert", function() {
          return expect(this.$button).toExist();
        });
        it("should prepend the button to the alert if position is default", function() {
          expect(this.$button.next('p')).toExist();
          return expect(this.$button.prev('p')).not.toExist();
        });
        it("should add a button with 'x' as content", function() {
          return expect(this.$button).toHaveText('x');
        });
        it("should add a button with 'close' class", function() {
          return expect(this.$button).toHaveClass('close');
        });
        return it("should fade out the element for 100 milliseconds when button clicked", function() {});
      });
      return describe("custom options", function() {
        beforeEach(function() {
          this.options = {
            text: 'close',
            cssClass: 'hide',
            position: 'after',
            effect: 'slide',
            duration: 200
          };
          this.$element.miniAlert(this.options);
          return this.$button = this.$element.find('button');
        });
        it("should add a button to the alert", function() {
          return expect(this.$button).toExist();
        });
        it("should append the button to the alert if position is 'after", function() {
          expect(this.$button.prev('p')).toExist();
          return expect(this.$button.next('p')).not.toExist();
        });
        it("should add a button with 'close' as content", function() {
          return expect(this.$button).toHaveText(this.options.text);
        });
        it("should add a button with 'after' class", function() {
          return expect(this.$button).toHaveClass(this.options.cssClass);
        });
        return it("should slide up the element for 200 milliseconds when button clicked", function() {});
      });
    });
    return describe("callbacks", function() {
      beforeEach(function() {
        return this.$element.miniAlert();
      });
      it("call onLoad callback function when the close button is ready", function() {});
      it("call onClose callback function when close button is clicked", function() {});
      return it("call onClosed callback function when alert message has been closed", function() {});
    });
  });

}).call(this);
