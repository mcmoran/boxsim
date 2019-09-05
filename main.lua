function love.load()


    playingAreaWidth = 660
    playingAreaHeight = 480

    -- creating box
    boxWidth = 50
    boxHeight = 50
    boxX = 85
    boxY = 85
    boxColorRed = 1
    boxColorGreen = 1
    boxColorBlue = 1

    boxNeedState = 0
    currentBigBox = 0
    -- i'm testing this with git. 
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

    -- set up detection

        function isBoxInSquare(BoxX, BoxY)
            return
            -- Left edge of bird is to the left of the right edge of pipe
            birdX < (pipeX + currentPipeWidth)
            and
             -- Right edge of bird is to the right of the left edge of pipe
            (birdX + birdWidth) > pipeX
            and (
                -- Top edge of bird is above the bottom edge of first pipe segment
                birdY < pipeSpaceY
                or
                -- Bottom edge of bird is below the top edge of second pipe segment
                (birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)
            )
        end

        if isBoxInSquare(pipe1X, pipe1SpaceY)
        or isBoxInSquare(pipe2X, pipe2SpaceY)
        or birdY > playingAreaHeight then
            reset()
        end


        -- loop to check the state


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
