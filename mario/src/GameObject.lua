--[[
    GD50
    -- Super Mario Bros. Remake --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def)
    self.x = def.x
    self.y = def.y
    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.frame = def.frame
    self.solid = def.solid
    self.collidable = def.collidable
    self.consumable = def.consumable
    self.onCollide = def.onCollide
    self.onConsume = def.onConsume
    self.hit = def.hit
    self.remove = false
    self.components = def.components
end

function GameObject:collides(target)
    if self.components then
        local collided = false
        for i = 1, #self.components do
            if not (target.x > self.components[i].x + self.components[i].width or self.components[i].x > target.x + target.width or
                target.y > self.components[i].y + self.components[i].height or self.components[i].y > target.y + target.height) then
                    collided = true
            end
        end
        return collided
    else
        return not (target.x > self.x + self.width or self.x > target.x + target.width or
                target.y > self.y + self.height or self.y > target.y + target.height)
    end
end

function GameObject:update(dt)

end

function GameObject:render()
    if self.components then
        for i = 1, #self.components do
            love.graphics.draw(gTextures[self.components[i].texture], gFrames[self.components[i].texture][self.components[i].frame], self.components[i].x, self.components[i].y)
        end
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
    end
end