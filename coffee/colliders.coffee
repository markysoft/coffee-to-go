FIELD_WIDTH = 800
FIELD_HEIGHT = 500

allReady = ->

  Crafty.init FIELD_WIDTH, FIELD_HEIGHT
  Crafty.canvas.init

  Crafty.background("#000")
  Crafty.scene "loading", setTheScene

  Crafty.scene "main", () ->

  Crafty.scene("loading")

setTheScene = () ->

  createComponents()

  createBackgroundTitle "Collider"

  trav = Crafty.e "2D, Canvas, Color, Collision, Trav, solidH"
  trav.attr  x: 50, y: 200, w: 20, h: 20
  trav.color 'rgb(0,0,255)'
  trav.Trav 2
  trav.collision()

  prot = Crafty.e "2D, DOM, Color, Collision, Trav, solidH"
  prot.color 'rgb(255,0,0)'
  prot.attr  x: 300, y: 150, w: 30, h: 30
  prot.collision()

  wall1 = Crafty.e "2D, DOM, Color, Collision, solidH"
  wall1.color 'rgb(255,255,255)'
  wall1.attr  x: 400, y: 90, w: 10, h: 400
  wall1.collision()

  wallh = Crafty.e "2D, DOM, Color, Collision, solidW"
  wallh.color 'rgb(255,255,255)'
  wallh.attr  x: 20, y: 30, w: 800, h: 10
  wallh.collision()

  wall2 = Crafty.e "2D, DOM, Color, Collision, solidH"
  wall2.color 'rgb(255,255,255)'
  wall2.attr  x: 200, y: 25, w: 10, h: 200
  wall2.collision()

  wall3 = Crafty.e "2D, DOM, Color, Collision, solidH"
  wall3.color 'rgb(255,255,255)'
  wall3.attr  x: 500, y: 30, w: 10, h: 300
  #wall3.Trav 1
  wall3.collision()


createBackgroundTitle = (message) ->
  title_text = Crafty.e "2D, DOM, Text, Tween, Persist, Title"
  title_text.text message
  title_text.css "text-align": "center", "color": "#555", "font-family": "Medula One", "font-size": 128, "text-trasform": "uppercase"

createComponents = () ->
  Crafty.c("Trav",
    speed: 2

    Trav: (speed, direction) ->
      if speed
        @speed = speed
        @dX = speed
      else
        @dX = 0
      @dY = 0


    travel: () ->
      @x += @dX
      @y += @dY

      @loopAtBoundary()

    loopAtBoundary: () ->

      if @x > FIELD_WIDTH
        @x = @x % FIELD_WIDTH
      if @x < 0
        @x = @x + FIELD_WIDTH

      if @y > FIELD_HEIGHT
        @y = @y % FIELD_HEIGHT
      if @y < 0
        @y = @y + FIELD_HEIGHT

    changeDirection: () ->
      #@reverse()
      @goLeft()

    reverse: () ->
      @dX = (@dX * -1)
      @dY = (@dY * -1)

    goUp: (hit) ->

        target = hit[0]
        @x += target.normal.x
        @y += target.normal.y

        if @dX != 0
          @dY = -@dX
          @dX = 0

    goLeft: (hit) ->

        target = hit[0]
        @x += target.normal.x
        @y += target.normal.y

        if @dY != 0
          @dX = @dY
          @dY = 0


    init: () ->
      @dX = @speed
      @dY = 0
      @bind 'EnterFrame',  @travel
      @onHit "solidW", (hit) -> @goLeft hit
      @onHit "solidH", (hit) -> @goUp hit

  )



window.onload = allReady