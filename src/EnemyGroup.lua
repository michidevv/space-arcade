EnemyGroup = Base:extend()

function EnemyGroup:constructor()
    self.enemies = {}
    self.time = 0
    self.pattern = 'left'
    self:makeGroup()
end

function EnemyGroup:update(dt)
    if self.time < 1 then
        self.time = self.time + dt
        return
    end

    self.time = 0

    local w = love.graphics.getDimensions()

    local firstEnemy = self:findFarthestAliveEnemy(true)
    local lastEnemy = self:findFarthestAliveEnemy(false)

    if (self.pattern == 'left' and firstEnemy.x - firstEnemy.velocity < 0) or
        (self.pattern == 'right' and lastEnemy.x + lastEnemy.width + lastEnemy.velocity > w) then
        for _, v in pairs(self.enemies) do
            v.y = v.y + v.velocity * 1.5
        end

        self.pattern = self.pattern == 'left' and 'right' or 'left'

        return
    end

    for _, v in pairs(self.enemies) do
        v:update(dt)

        if self.pattern == 'left' then
            v.x = v.x - v.velocity
        else
            v.x = v.x + v.velocity
        end
    end
end

function EnemyGroup:draw()
    for _, v in pairs(self.enemies) do
        if v.alive then
            v:draw()
        end
    end
end

function EnemyGroup:makeGroup()
    if #self.enemies > 0 then
        return self.enemies
    end

    for y = 1, 3 do
        for x = 1, 10 do
        table.insert(self.enemies, Enemy({x =  x * 60 + 70 - 12.5, y = 70 * y,}))
        end
    end

    return self.enemies
end

function EnemyGroup:findFarthestAliveEnemy(isNegative)
    local enemy = nil
    for _, v in ipairs(self.enemies) do
        if v.alive and (not enemy or ((v.x - enemy.x < 0) == isNegative)) then
            enemy = v
        end
    end

    return enemy
end
