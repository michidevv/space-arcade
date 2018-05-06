require('src/dependencies')

RUN_STATE = { isRunning = true, type = '', }
SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()

function makeEntities()
  player = Player({x = SCREEN_WIDTH / 2 - 25, y = SCREEN_HEIGHT - 50})
  group = EnemyGroup()
end

function love.load()
  love.window.setTitle('Space Arcade')
  love.keyboard.keys = {}

  SPRITE_SHEET = love.graphics.newImage('res/spritesheet.png')
  QUADS = Utils.generateQuads(SPRITE_SHEET, { w = 16, h = 16, }, 5)
  SOUNDS = {
    shoot = love.audio.newSource('res/shoot.wav', 'static'),
    explosion = love.audio.newSource('res/explosion.wav', 'static'),
  }

  Event.subscribe('gameover', function(params)
    RUN_STATE = { isRunning = false, type = params.reason }
  end)

  makeEntities()
end

function love.resize(w, h)
  print(w, h)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  love.keyboard.keys[key] = true
end

function love.keyboard.isPressed(key)
  return love.keyboard.keys[key]
end

function love.update(dt)
  if RUN_STATE.isRunning then
    player:update(dt)
    group:update(dt)
  end

  love.keyboard.keys = {}
end

function love.draw()
  player:draw()
  group:draw()

  if not RUN_STATE.isRunning then
    love.graphics.setNewFont('res/font.ttf', 48)
    local message = RUN_STATE.type == 'lose' and 'Game over!' or 'You win!'
    love.graphics.printf(message, 0, 150, SCREEN_WIDTH, 'center')
  end
end
