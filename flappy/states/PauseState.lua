PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.bird = nil
    self.pipePairs = nil
    self.score = nil
end

function PauseState:enter(params)
    self.bird = params['bird']
    self.pipePairs = params['pipePairs']
    self.score = params['score']
end

function PauseState:update()
    if love.keyboard.wasPressed('p') then
        sounds['pause']:play()
        sounds['music']:play()
        BirdAndPipePairsStats = {
            ['bird'] = self.bird,
            ['pipePairs'] = self.pipePairs,
            ['score'] = self.score
        }
        gStateMachine:change('play', BirdAndPipePairsStats)
    end
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.circle('line', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 50)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 + 15, VIRTUAL_HEIGHT / 2 - 25, 8, 50)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 23, VIRTUAL_HEIGHT / 2 - 25, 8, 50)
end