function love.load()

    -- set up the playing area
    playingAreaWidth = 660
    playingAreaHeight = 480

    -- create the box
    boxWidth = 50
    boxHeight = 50
    boxX = 85
    boxY = 85
    boxColorRed = 1 -- initial red value
    boxColorGreen = 1 -- initial green value
    boxColorBlue = 1 -- initial blue value

    boxNeedState = 1 -- what the initial box needs (1-6)
    currentLocation = 1 -- where the box starts from
        currentRow = 1 -- 1 or 2
        currentCol = 1 -- 1, 2 or 3

end

function love.update(dt) -- dt = delta time

    -- setting a conditional loop for keystroke actions
    if love.keyboard.isDown('up') then
        boxY = boxY - 150 * dt -- use dt so it doesn't go too fast/slow
    elseif love.keyboard.isDown('down') then
        boxY = boxY + 150 * dt
    elseif love.keyboard.isDown('left') then
        boxX = boxX - 150 * dt
    elseif love.keyboard.isDown('right') then
        boxX = boxX + 150 * dt
    end

    -- this will determine if the box is completely in a location
    if boxY > 280 then currentRow = 2
        elseif boxY < 230 then currentRow = 1
    end
    if boxX > 440 then currentCol = 3
        elseif boxX > 220 and boxX < 390 then currentCol = 2
        elseif boxX < 170 then currentCol = 1
    end

    -- these two while statements determine currentLocation value (1-6)
    while currentRow[1] do
        if currentCol == 1 then
            currentLocation = 1
        elseif currentCol == 2 then
            currentLocation = 2
        elseif currentCol == 3 then
            currentLocation = 3
        end
    end
    while currentRow[2] do
        if currentCol == 1 then
            currentLocation = 4
        elseif currentCol == 2 then
            currentLocation = 5
        elseif currentCol == 3 then
            currentLocation = 6
        end
    end


    -- loop to check the state
    function love.graphics.print(currentRow)

end

function love.draw()

    -- Setting the color first.  Top-down syntax
    -- love.graphics.setColor(math.random(1, 0.5, 0.5, 1)


    -- sleep box (gray)
    love.graphics.setColor(.3, .3, .3, .9)
    love.graphics.rectangle('fill', 0, 0, 220, 220)

    -- eat box
    love.graphics.setColor(1, .2, .2, .9)
    love.graphics.rectangle('fill', 220, 0, 220, 220)

    -- drink box
    love.graphics.setColor(.11, .56, 1, 1)
    love.graphics.rectangle('fill', 440, 0, 220, 220)

    -- learn box (gray)
    love.graphics.setColor(1, .54, 0, 1)
    love.graphics.rectangle('fill', 0, 220, 220, 220)

    -- play box
    love.graphics.setColor(1, .84, 0, 1)
    love.graphics.rectangle('fill', 220, 220, 220, 220)

    -- move box
    love.graphics.setColor(.19, .8, .19, 1)
    love.graphics.rectangle('fill', 440, 220, 220, 220)


    love.graphics.setColor(boxColorRed, boxColorGreen, boxColorRed)
    love.graphics.rectangle('fill', boxX, boxY, boxHeight, boxWidth)
end
end
