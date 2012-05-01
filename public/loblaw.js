(function() {
  var FIELD_HEIGHT, FIELD_WIDTH, allReady, createBackgroundTitle, createComponents, createTitle, generateWorld, loadSprites, showLobRaw, showRndRaw, showRoblaw;

  FIELD_WIDTH = 400;

  FIELD_HEIGHT = 300;

  allReady = function() {
    Crafty.init(FIELD_WIDTH, FIELD_HEIGHT);
    Crafty.canvas.init;
    Crafty.scene("loading", function() {
      loadSprites();
      createComponents();
      createBackgroundTitle(" A GAME");
      createTitle("loading...");
      return Crafty.load(["sprites.png"], function() {
        var startedIt;
        startedIt = true;
        return Crafty.scene("main");
      });
    });
    Crafty.scene("main", function() {
      var bots, _i, _results;
      _results = [];
      for (bots = _i = 1; _i <= 50; bots = ++_i) {
        _results.push(showRndRaw());
      }
      return _results;
    });
    return Crafty.scene("loading");
  };

  createBackgroundTitle = function(message) {
    var title_text;
    title_text = Crafty.e("2D, DOM, Text, Tween, Persist, Title");
    title_text.text(message);
    return title_text.css({
      "text-align": "center",
      "color": "#555",
      "font-family": "Medula One",
      "font-size": 128,
      "text-trasform": "uppercase"
    });
  };

  createTitle = function(message) {
    var text;
    Crafty.background("#000");
    text = Crafty.e("2D, DOM, Text");
    text.attr({
      w: 100,
      h: 20,
      x: 150,
      y: 120
    });
    text.text(message);
    return text.css({
      "text-align": "center"
    });
  };

  showRndRaw = function() {
    var b, g, r, robr, size, speed, startX, startY;
    robr = Crafty.e("2D, Canvas, Color, Collision, Walker");
    r = Crafty.math.randomInt(0, 255);
    g = Crafty.math.randomInt(0, 255);
    b = Crafty.math.randomInt(0, 255);
    robr.color("rgb(" + r + "," + g + "," + b + ")");
    size = Crafty.math.randomInt(5, 30);
    startX = Crafty.math.randomInt(0, FIELD_WIDTH);
    startY = Crafty.math.randomInt(0, FIELD_HEIGHT);
    robr.attr({
      x: startX,
      y: startY,
      w: size,
      h: size
    });
    speed = Crafty.math.randomInt(-4, 4);
    while (speed === 0) {
      speed = Crafty.math.randomInt(-4, 4);
    }
    return robr.Walker(speed, "left");
  };

  showRoblaw = function() {
    var robr;
    robr = Crafty.e("2D, DOM, Color, Collision, Walker");
    robr.color('rgb(0,0,255)');
    robr.attr({
      x: 300,
      y: 150,
      w: 10,
      h: 10
    });
    return robr.Walker(-2, "left");
  };

  showLobRaw = function() {
    var robr;
    robr = Crafty.e("2D, DOM, Color, Collision, Walker");
    robr.color('rgb(255,0,0)');
    robr.attr({
      x: 300,
      y: 150,
      w: 30,
      h: 30
    });
    return robr.Walker(4, "right");
  };

  loadSprites = function() {
    var spriteMap;
    spriteMap = {
      "grass1": [0, 0],
      "grass2": [0, 1],
      "grass3": [2, 0],
      "grass4": [3, 0],
      "flower": [0, 1],
      "bush1": [0, 2],
      "bush2": [1, 2],
      "player": [0, 3]
    };
    return Crafty.sprite(16, 16, "sprites.png", spriteMap);
  };

  createComponents = function() {
    return Crafty.c("Walker", {
      speed: 2,
      Walker: function(speed, direction) {
        if (speed) {
          this.speed = speed;
          this.dX = speed;
        } else {
          this.dX = 0;
        }
        this.dY = 0;
        if (direction === "left") {
          return this.directionModifier = -1;
        } else {
          return this.directionModifier = 1;
        }
      },
      travel: function() {
        if (this.x < 0) {
          this.x = 0;
          this.dX = 0;
          this.dY = -this.speed * this.directionModifier;
        }
        if (this.x > FIELD_WIDTH - this.w) {
          this.x = FIELD_WIDTH - this.w;
          this.dX = 0;
          this.dY = this.speed * this.directionModifier;
        }
        if (this.y < 0) {
          this.y = 0;
          this.dX = this.speed * this.directionModifier;
          this.dY = 0;
        }
        if (this.y > FIELD_HEIGHT - this.h) {
          this.y = FIELD_HEIGHT - this.h;
          this.dX = -this.speed * this.directionModifier;
          this.dY = 0;
        }
        this.x += this.dX;
        return this.y += this.dY;
      },
      init: function() {
        this.dX = this.speed;
        return this.bind('EnterFrame', this.travel);
      }
    });
  };

  generateWorld = function() {
    var grassType, i, j, _i, _ref, _results;
    _results = [];
    for (i = _i = 0, _ref = FIELD_WIDTH / 16; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      _results.push((function() {
        var _j, _ref1, _results1;
        _results1 = [];
        for (j = _j = 0, _ref1 = FIELD_HEIGHT / 16; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
          grassType = Crafty.math.randomInt(1, 4);
          _results1.push(Crafty.e("2D, DOM, grass" + grassType).attr({
            x: i * 16,
            y: j * 16,
            z: 1
          }));
        }
        return _results1;
      })());
    }
    return _results;
  };

  window.onload = allReady;

}).call(this);
