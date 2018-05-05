Player = Base:extend()

function Player:constructor(params)
  self.x = params.x
  self.y = params.y
  self.width = params.width or 50
  self.height = params.height or 50
  self.velocity = params.velocity or 250

  -- Initial
  self.isOverheated = false

  self.beams = {}
end

function Player._move(self, dt)
  if love.keyboard.isDown('right') then
    self.x = self.x <= SCREEN_WIDTH - self.width and self.x + self.velocity * dt or self.x
  elseif love.keyboard.isDown('left') then
    self.x = self.x >=0 and self.x - self.velocity * dt or self.x
  end
end

function Player._shoot(self)
  if love.keyboard.isPressed('space') and not self.isOverheated then
    table.insert(self.beams, Beam({x=self.x + self.width / 2, y=self.y - self.height}))
    self.isOverheated = true -- TODO: Pass from outside.
  end
end

function Player._updateBeams(self, dt)
  for i=#self.beams, 1, -1  do
    local beam = self.beams[i]
    beam:update(dt)

    if beam.y <= 0 or beam.hasHit then
      table.remove(self.beams, i)
      self.isOverheated = false
    end
  end
end

function Player:update(dt)
  Player._move(self, dt)
  Player._shoot(self)
  Player._updateBeams(self, dt)
end

function Player:draw()
  -- TODO: Replace with sprite.
  love.graphics.rectangle('fill', self.x, self.y, 50, 50)
  for _, v in pairs(self.beams) do
    v:draw()
  end
end
