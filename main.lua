function love.load()
  --ASH TESTTTTT
    -- set up the playing area
    playingAreaWidth = 660
    playingAreaHeight = 480

    -- setting color values
    colorWhite = {1, 1, 1}
    colorBlack = {0, 0, 0}
    color1 = {.5, .5, .5} -- sleep
    color2 = {1, .4, .4} -- eat
    color3 = {.22, .67, 1} -- drink
    color4 = {1, .65, 1} -- learn
    color5 = {1, .9, 1} -- play
    color6 = {.25, .9, .29} -- move

    -- create the box
    boxWidth = 50
    boxHeight = 50
    boxX = 85
    boxY = 85

    currentColor = color1Sleep
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

    -- set the current location and color of the box
    if (currentRow == 1 and currentCol == 1) then
        currentLocation = 1
        currentColor = color1
    elseif (currentRow == 1 and currentCol == 2) then
        currentLocation = 2
        currentColor = color2
    elseif (currentRow == 1 and currentCol == 3) then
        currentLocation = 3
        currentColor = color3
    elseif (currentRow == 2 and currentCol == 1) then
        currentLocation = 4
        currentColor = color4
    elseif (currentRow == 2 and currentCol == 2) then
        currentLocation = 5
        currentColor = color5
    elseif (currentRow == 2 and currentCol == 3) then
        currentLocation = 6
        currentColor = color6
    end

end

function love.draw()

    -- Setting the color first.  Top-down syntax
    -- love.graphics.setColor(math.random(1, 0.5, 0.5, 1)


    -- these are the background boxes

    -- sleep box (gray)
    love.graphics.setColor(.3, .3, .3, .9)
    love.graphics.rectangle('fill', 0, 80, 220, 200)

    -- eat box
    love.graphics.setColor(1, .2, .2, .9)
    love.graphics.rectangle('fill', 220, 80, 220, 200)

    -- drink box
    love.graphics.setColor(.11, .56, 1, 1)
    love.graphics.rectangle('fill', 440, 80, 220, 200)

    -- learn box (gray)
    love.graphics.setColor(1, .54, 0, 1)
    love.graphics.rectangle('fill', 0, 280, 220, 200)

    -- play box
    love.graphics.setColor(1, .84, 0, 1)
    love.graphics.rectangle('fill', 220, 280, 220, 200)

    -- move box
    love.graphics.setColor(.19, .8, .19, 1)
    love.graphics.rectangle('fill', 440, 280, 220, 200)


    -- this is the boxsim

    love.graphics.setColor(unpack(currentColor))
    love.graphics.rectangle('fill', boxX, boxY, boxHeight, boxWidth)

    -- loop to check the state
    function love.graphics.print(currentRow)
end
end
