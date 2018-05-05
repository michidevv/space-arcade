Beam = Base:extend()

function Beam:constructor(params)
  self.x = params.x
  self.y = params.y
  self.width = params.width or 5
  self.height = params.height or 10
  self.velocity = params.velocity or 500

  self.hasHit = false
end

function Beam:update(dt)
  self.y = self.y - self.velocity * dt

  Event.dispatch('beamupdate', self) -- TODO: Will mutate original item, update implementation.
end

function Beam:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
