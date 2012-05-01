FIELD_WIDTH = 400
FIELD_HEIGHT = 300

allReady = ->

  Crafty.init FIELD_WIDTH, FIELD_HEIGHT
  Crafty.canvas.init

  Crafty.scene "loading", () ->

    loadSprites()
    createComponents()
    createBackgroundTitle " A GAME"
    createTitle "loading..."
    Crafty.load ["sprites.png"], () ->
      startedIt = true
      Crafty.scene("main")

  Crafty.scene "main", () ->
    #generateWorld()
    #showRoblaw()
    #showLobRaw()
    for bots in [1..50]
      showRndRaw()




  Crafty.scene("loading")

#$(allReady)

createBackgroundTitle = (message) ->
  title_text = Crafty.e "2D, DOM, Text, Tween, Persist, Title"
  title_text.text message
  title_text.css "text-align": "center", "color": "#555", "font-family": "Medula One", "font-size": 128, "text-trasform": "uppercase"

createTitle = (message) ->
  Crafty.background("#000")
  text = Crafty.e "2D, DOM, Text"
  text.attr w: 100, h:20, x:150, y:120
  text.text message
  text.css "text-align": "center"



showRndRaw = () ->
  robr = Crafty.e "2D, Canvas, Color, Collision, Walker"


  r = Crafty.math.randomInt(0, 255)
  g = Crafty.math.randomInt(0, 255)
  b = Crafty.math.randomInt(0, 255)
  robr.color "rgb(#{r},#{g},#{b})"

  size = Crafty.math.randomInt(5, 30)
  startX = Crafty.math.randomInt(0, FIELD_WIDTH)
  startY = Crafty.math.randomInt(0, FIELD_HEIGHT)
  robr.attr  x: startX, y: startY, w: size, h: size
  speed = Crafty.math.randomInt(-4, 4)
  while speed is 0
    speed = Crafty.math.randomInt(-4, 4)

  robr.Walker speed, "left"

showRoblaw = () ->
  robr = Crafty.e "2D, DOM, Color, Collision, Walker"
  robr.color 'rgb(0,0,255)'
  robr.attr  x: 300, y: 150, w: 10, h: 10 # Crafty.math.randomInt(1, 3)
  robr.Walker -2, "left"

showLobRaw = () ->
  robr = Crafty.e "2D, DOM, Color, Collision, Walker"
  robr.color 'rgb(255,0,0)'
  robr.attr  x: 300, y: 150, w: 30, h: 30
  robr.Walker 4, "right"


loadSprites = () ->
  spriteMap =
    "grass1": [0,0]
    #"grass2": [1,0]
    "grass2": [0,1]
    "grass3": [2,0]
    "grass4": [3,0]
    "flower": [0,1]
    "bush1": [0,2]
    "bush2": [1,2]
    "player": [0,3]

  Crafty.sprite 16, 16, "sprites.png", spriteMap

createComponents = () ->
  Crafty.c("Walker",
    speed: 2

    Walker: (speed, direction) ->
      if speed
        @speed = speed
        @dX = speed
      else
        @dX = 0
      @dY = 0
      if direction is "left"
        @directionModifier = -1
      else
        @directionModifier = 1

    travel: () ->

      if @x < 0
        @x = 0
        @dX = 0
        @dY = -@speed * @directionModifier

      if @x > FIELD_WIDTH - @w
        @x = FIELD_WIDTH - @w
        @dX = 0
        @dY = @speed * @directionModifier

      if @y < 0
        @y = 0
        @dX = @speed * @directionModifier
        @dY = 0

      if @y > FIELD_HEIGHT - @h
        @y = FIELD_HEIGHT - @h
        @dX = -@speed * @directionModifier
        @dY = 0

      @x += @dX
      @y += @dY

    init: () ->
      @dX = @speed
      @bind 'EnterFrame',  @travel

  )


generateWorld = () ->
  #loop through all tiles
  for i in [0..FIELD_WIDTH/16]
    for j in [0..FIELD_HEIGHT/16]
      #place grass on all tiles
      grassType = Crafty.math.randomInt(1, 4)
      Crafty.e("2D, DOM, grass" + grassType).attr( x: i * 16, y: j * 16, z:1 )

window.onload = allReady




