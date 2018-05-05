require('src/dependencies')

function makeEntities()
  local w, h = love.graphics.getDimensions()
  player = Player({x = w / 2 - 25, y = h - 50})
  group = EnemyGroup()
end

function love.load()
  love.window.setTitle('Space Arcade')
  love.keyboard.keys = {}

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
  player:update(dt)
  group:update(dt)

  love.keyboard.keys = {}
end

function love.draw()
  player:draw()
  group:draw()
end
