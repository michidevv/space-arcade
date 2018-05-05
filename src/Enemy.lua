Enemy = Base:extend()

function Enemy:constructor(params)
  self.x = params.x
  self.y = params.y
  self.width = params.width or 25
  self.height = params.height or 25
  self.velocity = params.velocity or 35

  self.pattern = 'left'

  self.alive = true

  self.unsubscribe = Event.subscribe('beamupdate', function(entity)
    if self:collides(entity) then
      self.alive = false
      entity.hasHit = true
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

end

function Enemy:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
