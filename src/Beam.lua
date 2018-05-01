Beam = Base:extend()

function Beam:constructor(params)
  self.x = params.x
  self.y = params.y
  self.velocity = 500 or params.velocity
end

function Beam:collides(entity)
  local result = self.x + self.width < entity.x and self.x > entity.x + entity.width
  print('collides', result)

  return result
end

function Beam:update(dt)
  self.y = self.y - self.velocity * dt
end

function Beam:draw()
  love.graphics.rectangle('fill', self.x, self.y, 10, 20)
end
