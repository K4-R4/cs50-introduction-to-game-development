--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    -- downloaded from https://www.flaticon.com/
    self.bronzeMedal = love.graphics.newImage('bronze-medal.png')
    self.bronzeMedalWidth = self.bronzeMedal:getWidth()
    self.silverMedal = love.graphics.newImage('silver-medal.png')
    self.silverMedalWidth = self.silverMedal:getWidth()
    self.goldMedal = love.graphics.newImage('gold-medal.png')
    self.goldMedalWidth = self.goldMedal:getWidth()
end

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score < 4 then
        love.graphics.printf('You aren\'t deserve any medals!', 0, 140, VIRTUAL_WIDTH, 'center')
    elseif self.score < 8 then
        love.graphics.draw(self.bronzeMedal, VIRTUAL_WIDTH / 2 - self.bronzeMedalWidth / 2, 122)
    elseif self.score < 12 then
        love.graphics.draw(self.silverMedal, VIRTUAL_WIDTH / 2 - self.silverMedalWidth / 2, 122)
    else
        love.graphics.draw(self.goldMedal, VIRTUAL_WIDTH / 2 - self.goldMedalWidth / 2, 122)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end