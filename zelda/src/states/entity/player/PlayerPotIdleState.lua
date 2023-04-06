PlayerPotIdleState = Class{__includes = EntityIdleState}

function PlayerPotIdleState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.entity.offsetX = 0
    self.entity.offsetY = 5
    self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk')
    end

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