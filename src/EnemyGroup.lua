EnemyGroup = Base:extend()

function EnemyGroup:constructor()
    self.enemies = {}
    self.time = 0
    self.pattern = 'left'
    self:makeGroup()
end

function EnemyGroup:update(dt)
    if self.time < 1 then -- Move out
        self.time = self.time + dt
        return
    end

    self.time = 0

    local firstEnemy = self:findFarthestAliveEnemy(true)
    local lastEnemy = self:findFarthestAliveEnemy(false)

    if (self.pattern == 'left' and firstEnemy.x - firstEnemy.velocity < 0) or
        (self.pattern == 'right' and lastEnemy.x + lastEnemy.width + lastEnemy.velocity > SCREEN_WIDTH) then
        for _, v in ipairs(self.enemies) do
            v.y = v.y + v.velocity * 0.7
            if (v.y >= SCREEN_HEIGHT - 80) then
                Event.dispatch('gameover', {reason = 'lose'})
            end
        end

        self.pattern = self.pattern == 'left' and 'right' or 'left'

        return
    end

    for i = #self.enemies, 1, -1 do
        local enemy = self.enemies[i]
        if enemy.alive then
            enemy:update(dt)
            enemy.x = self.pattern == 'left' and enemy.x - enemy.velocity or enemy.x + enemy.velocity
        else
            table.remove(self.enemies, i)
            if #self.enemies == 0 then
                Event.dispatch('gameover', {reason = 'win'})
            end
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
        if not enemy or ((v.x - enemy.x < 0) == isNegative) then
            enemy = v
        end
    end

    return enemy
end
