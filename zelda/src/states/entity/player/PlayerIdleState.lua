--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.entity.offsetX = 0
    self.entity.offsetY = 5
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            -- temporarily adjust position
            object.x = object.x - 3
            object.y = object.y - 3
            object.width = object.width + 6
            object.height = object.height + 6
            if object.collidable and self.entity:collides(object) then
                object.carried = true
                self.entity:changeState('pot-idle')
            end
            -- readjust
            object.x = object.x + 3
            object.y = object.y + 3
            object.width = object.width - 6
            object.height = object.height - 6
        end
    end
end