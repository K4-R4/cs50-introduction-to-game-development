KeyPowerup = Class{}

function KeyPowerup:init(x, y)
    self.type = 'KeyPowerup'

    self.width = 16
    self.height = 16

    self.x = x
    self.y = y

    self.dx = 0
    self.dy = 30

    self.skin = 10

    self.remove = false
end

function KeyPowerup:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function KeyPowerup:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function KeyPowerup:render()
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin], self.x, self.y)
end