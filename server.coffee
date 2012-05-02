express = require 'express'
jqtpl = require 'jqtpl'

app = express.createServer()
 
# Setup configuration
coffeeDir = __dirname + '/coffee'
publicDir = __dirname + '/public'
app.use express.compiler(src: coffeeDir, dest: publicDir, enable: ['coffeescript'])
app.use express.static(publicDir)

app.set("view engine", "html")
app.register(".html", require("jqtpl").express)
 
# App Routes
app.get '/', (req, res) ->
  res.render 'index.html', { title: 'Express with Coffee' }

app.get '/:page', (req, res) ->
  pageName = req.params.page;
  res.render pageName + '.html', { title: pageName }

# Listen
app.listen 3000
console.log "Express server listening on port %d", app.address().port
