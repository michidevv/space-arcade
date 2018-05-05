require('src/dependencies')

-- TODO: Move out.
local makeEntities = function ()
  local w, h = love.graphics.getDimensions()
  local player = Player({x = w / 2 - 25, y = h - 50})
  local enemies = {}
  for i = 1, 5 do
    table.insert(enemies, Enemy({x = i * 120, y = 100,}))
  end

  return unpack({player, enemies}) -- Pretty cool
end

function love.load()
  love.window.setTitle('Space Invaders')
  love.keyboard.keys = {}

  player, enemies = makeEntities()
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
  for _, v in pairs(enemies) do
    v:update(dt)
  end

  love.keyboard.keys = {}
end

function love.draw()
  player:draw()
  for _, v in pairs(enemies) do
    if v.alive then
      v:draw()
    end
  end
end
