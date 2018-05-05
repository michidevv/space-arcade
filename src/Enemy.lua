Enemy = Base:extend()

function Enemy:constructor(params)
  self.x = params.x
  self.y = params.y
  self.width = params.width or 30
  self.height = params.height or 30
  self.velocity = 50 or params.velocity

  self.alive = true

  self.unsubscribe = Event.subscribe('beamupdate', function(...)
    if self:collides(...) then
      self.alive = false
      self.unsubscribe()
    end
  end)
end

function Enemy:collides(entity)
  local result = (self.y + self.height < entity.y or self.y > entity.y + entity.height) or
    (self.x + self.width < entity.x or self.x > entity.x + entity.width)

  return not result
end

function Enemy:update(dt)
  -- TODO: Add move logic
end

function Enemy:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
