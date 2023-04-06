--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(object, dungeon, direction, speed, range)
    self.type = object.type

    self.texture = object.texture
    self.frame = object.frame

    self.solid = object.solid

    self.defaultState = object.defaultState
    self.state = object.defaultState
    self.states = object.states

    self.x = object.x
    self.y = object.y
    self.initialX = self.x
    self.initialY = self.y
    self.width = object.width
    self.height = object.height

    self.dungeon = dungeon
    self.direction = direction
    self.speed = speed
    self.range = range

    self.expired = false
end

function Projectile:update(dt)
    -- update position
    if self.direction == 'left' then
        self.x = self.x - self.speed * dt
        if math.abs(self.initialX - self.x) > self.range then
            self.expired = true
        end
    elseif self.direction == 'right' then
        self.x = self.x + self.speed * dt
        if math.abs(self.initialX - self.x) > self.range then
            self.expired = true
        end
    elseif self.direction == 'down' then
        self.y = self.y + self.speed * dt
        if math.abs(self.initialY - self.y) > self.range then
            self.expired = true
        end
    else
        self.y = self.y - self.speed * dt
        if math.abs(self.initialY - self.y) > self.range then
            self.expired = true
        end
    end

    -- update hitbox according to the current position
    self.projectileHitbox = Hitbox(self.x, self.y, self.width, self.height)

    for k, entity in pairs(self.dungeon.currentRoom.entities) do
        if entity:collides(self.projectileHitbox) then
            entity:damage(1)
            self.expired = true
            gSounds['hit-enemy']:play()
        end
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    if not self.expired then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    end
end