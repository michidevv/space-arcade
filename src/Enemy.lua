Enemy = Base:extend()

function Enemy:constructor(params)
  self.x = params.x
  self.y = params.y
  self.velocity = 50 or params.velocity
end

function Enemy:update(dt)

end

function Enemy:draw()
  love.graphics.circle('fill', self.x, self.y, 20, 100)
end
