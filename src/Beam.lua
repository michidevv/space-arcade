Beam = Base:extend()

function Beam:constructor(params)
  self.x = params.x
  self.y = params.y
  self.width = params.width or 10
  self.height = params.height or 20
  self.velocity = 500 or params.velocity
end

function Beam:update(dt)
  self.y = self.y - self.velocity * dt

  Event.dispatch('beamupdate', {x = self.x, y = self.y, width = self.width, height = self.height})
end

function Beam:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
