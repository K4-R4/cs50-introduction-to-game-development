--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(def)
    self.menu = Menu {
        x = VIRTUAL_WIDTH / 2 - 160 / 2,
        y = VIRTUAL_HEIGHT / 2 - 128 / 2,
        width = 160,
        height = 128,
        items = {
            {
                text = "HP:  "..def.baseHP.." + "..def.HPIncrease.." = "..def.baseHP + def.HPIncrease,
                onSelect = function()
                    gStateStack:pop()
                    def.onSelect()
                end
            },
            {
                text = "ATK: "..def.baseAttack.." + "..def.attackIncrease.." = "..def.baseAttack + def.attackIncrease,
                onSelect = function()
                    gStateStack:pop()
                    def.onSelect()
                end
            },
            {
                text = "DEF: "..def.baseDefense.." + "..def.defenseIncrease.." = "..def.baseDefense + def.defenseIncrease,
                onSelect = function()
                    gStateStack:pop()
                    def.onSelect()
                end
            },
            {
                text = "SPD: "..def.baseSpeed.." + "..def.speedIncrease.." = "..def.baseSpeed + def.speedIncrease,
                onSelect = function()
                    gStateStack:pop()
                    def.onSelect()
                end
            }
        },
        isCursorAvailable = false
    }
end

function MenuState:update(dt)
    self.menu:update()
end

function MenuState:render()
    self.menu:render()
end