--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

palleteColor = {
    ['r'] = 251,
    ['g'] = 242,
    ['b'] = 54,
    ['a'] = 64
}

function Tile:init(x, y, color, variety)

    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    self.shiny = math.random(16) == 1 and true or false

    if self.shiny then
        self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 32)
        self.psystem:setEmissionRate(30)
        self.psystem:setParticleLifetime(0.5, 1)
        self.psystem:setEmitterLifetime(-1)
        self.psystem:setEmissionArea('normal', 4, 4)
        self.psystem:setColors(
            palleteColor.r / 255,
            palleteColor.g / 255,
            palleteColor.b / 255,
            palleteColor.a / 255
        )
        self.psystem:emit(32)
    end
end

function Tile:update(dt)
    if self.shiny then
        self.psystem:update(dt)
    end
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 255/255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)

    if self.shiny then
        love.graphics.draw(self.psystem, self.x + 16 + x, self.y + 16 + y)
    end
end