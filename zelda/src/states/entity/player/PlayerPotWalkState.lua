PlayerPotWalkState = Class{__includes = EntityWalkState}

function PlayerPotWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.entity.offsetX = 0
    self.entity.offsetY = 5
    self.entity:changeAnimation('pot-walk-' .. self.entity.direction)
end

function PlayerPotWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('pot-walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('pot-walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('pot-walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('pot-walk-down')
    else
        self.entity:changeState('pot-idle')
    end

    EntityWalkState.update(self, dt)

    for k, object in pairs(self.dungeon.currentRoom.objects) do
        -- set pot position to player's up
        if object.carried then
            object.x = self.entity.x
            object.y = self.entity.y - object.height + 3
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if object.carried then
                table.insert(self.entity.projectile, Projectile(object, self.dungeon, self.entity.direction, 80, TILE_SIZE * 4))
                table.remove(self.dungeon.currentRoom.objects, k)
            end
        end
        self.entity:changeState('idle')
    end
end

function PlayerPotWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end