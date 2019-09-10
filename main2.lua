

function love.load()

    color1 = {1, 1, 1}
    color2 = {1, 1, 1}

    colors = {color1, color2}

    love.grahics.setColor(colors[1][1], colors[1][2], colors[1][3])

    squares = {1, 2, 3, 4, 5, 6}

    colorLevel = {  {1, 1, 1},
                    {.8, .8, .8},
                    {.6, .6, .6},
                    {.4, .4, .4},
                    {.2, .2, .2},
                    {0, 0, 0} }


    levelMap = { 1colorLevel1, colorLevel2, colorLevel3 }

    level = 1

end

function love.update(dt) -- dt = delta time

end

function love.draw()


    --love.graphics.setColor(colorLevel1[1])
        love.graphics.setColor(levelMap[1][1])
        love.graphics.rectangle('fill', 0, 80, 220, 200)


end
