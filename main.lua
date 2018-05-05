require('src/dependencies')

isRunning = true
SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()

function makeEntities()
  player = Player({x = SCREEN_WIDTH / 2 - 25, y = SCREEN_HEIGHT - 50})
  group = EnemyGroup()
end

function love.load()
  love.window.setTitle('Space Arcade')
  love.keyboard.keys = {}

  Event.subscribe('gameover', function() isRunning = false end)
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
  if isRunning then
    player:update(dt)
    group:update(dt)
  end

  love.keyboard.keys = {}
end

function love.draw()
  player:draw()
  group:draw()

  if not isRunning then
    love.graphics.setNewFont('res/font.ttf', 48)
    love.graphics.printf("Game over!", 0, 150, SCREEN_WIDTH, 'center')
  end
end
