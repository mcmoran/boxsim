

function love.load()

    -- loading the music and audio files
    blip = love.audio.newSource('Blip_Select4.wav', 'static')
    timerBlip = love.audio.newSource('timer.wav', 'static')
    countdownMusic = love.audio.newSource('countdown.ogg', 'static')
    bgMusic = love.audio.newSource('music1.ogg', 'stream')
        bgMusic:setLooping(true)
        bgMusic:play()

    -- a counter variable for the detla time change in second increments
    dtCounter = 0

    -- set up the playing area
    playingAreaWidth = 660
    playingAreaHeight = 480

    finalCountDown = false
    finalCountDownNumber = 3

    -- setting color values for box
    colorWhite = {1, 1, 1}
    colorBlack = {0, 0, 0}

    colorLevel11 = {1, 1, 1}
    colorLevel12 = {.8, .8, .8}
    colorLevel13 = {.6, .6, .6}
    colorLevel14 = {.4, .4, .4}
    colorLevel15 = {.2, .2, .2}
    colorLevel16 = {0, 0, 0}

    colorLevel21 = {1, .9, .2}
    colorLevel22 = {.9, .7, .1}
    colorLevel23 = {.8, .6, .1}
    colorLevel24 = {.7, .5, 0}
    colorLevel25 = {.6, .4, 0}
    colorLevel26 = {.5, .3, 0}

    color1 = {.5, .5, .5} -- sleep (grey)
    color2 = {1, .4, .4} -- eat (red)
    color3 = {.22, .67, 1} -- drink (blue)
    color4 = {.70, .43, 85} -- learn (purple)
    color5 = {1, 1, 0} -- play (yellow)
    color6 = {.25, .9, .29} -- move (green)

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
    needLocation = 1

    -- play conditions
    score = 0
    level = 1
    timer = 20
    countdown = 10
    gamestart = true
    gameover = false
    i = 0 -- this is the level loop

end

function love.update(dt) -- dt = delta time

if gamestart == true then

    -- setting a conditional loop for keystroke actions
    if love.keyboard.isDown('up') then
        boxY = boxY - 600 * dt -- use dt so it doesn't go too fast/slow
    elseif love.keyboard.isDown('down') then
        boxY = boxY + 600 * dt
    elseif love.keyboard.isDown('left') then
        boxX = boxX - 600 * dt
    elseif love.keyboard.isDown('right') then
        boxX = boxX + 600 * dt
    end

    -- make it so the box doesn't go outside the playing area
    if boxX < 0 then
        boxX = 0
    elseif boxX > 610 then
        boxX = 610
    end

    if boxY < 80 then
        boxY = 80
    elseif boxY > 430 then
        boxY = 430
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
        --currentColor = colorLevel .. level .. 1 .. 1  -- why doesn't this work?
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
    end -- hi

    -- if the box is in the right area, then change the color to random
    -- and reset the timer
    if needLocation == currentLocation then
        needLocation = love.math.random(1,6)
        if needLocation ~= currentLocation then
            score = score + 1
            i = i + 1
        end
    end

    -- this makes the counter count in 1 second increments
    dtCounter = dtCounter + dt

    -- plays the timer blip sound each second.
    if (timer > 10 and dtCounter >= 1) then
        timerBlip:play()
        dtCounter = 0
    end

    -- increase stats every 10 points
    if i == 10 then
        level = level + 1
        blip:play()
        timer = (20 - level)
        i = 0
    end

    -- changes the current color to the need color
    if needLocation == 1 then currentColor = color1
        elseif needLocation == 2 then currentColor = color2
        elseif needLocation == 3 then currentColor = color3
        elseif needLocation == 4 then currentColor = color4
        elseif needLocation == 5 then currentColor = color5
        elseif needLocation == 6 then currentColor = color6
    end

    -- timer count down
    timer = timer - dt

    -- plays the countdown audio if there are just 10 seconds left
    if timer <= 10 then
        countdownMusic:play()
    end

    -- do the last 3 countdown printing loop here
    if timer <= 3 then
        finalCountDown = true
    end

    if timer > 3 then
        finalCountDown = false
    end

    -- stops the countdown if more than 10 seconds
    if timer > 10 then
        countdownMusic:stop()
    end

    -- game over yo.
    if timer <= 0 then
        gameover = true
        bgMusic:stop()
    end

end

    -- turns off the game if it is over
    if gameover == true then
        gamestart = false
    end

end

-- this allows you to exit the game with the escape key
function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
end

function love.draw()

-- these are the background boxes

    -- top bar for score and info
    love.graphics.setColor(.2, .2, .2, 1)
    love.graphics.rectangle('fill', 0, 0, 660, 80)

    -- sleep box (gray)
    love.graphics.setColor(unpack(color1))
    love.graphics.rectangle('fill', 0, 80, 220, 200)

    -- eat box
    love.graphics.setColor(unpack(color2))
    love.graphics.rectangle('fill', 220, 80, 220, 200)

    -- drink box
    love.graphics.setColor(unpack(color3))
    love.graphics.rectangle('fill', 440, 80, 220, 200)

    -- learn box
    love.graphics.setColor(unpack(color4))
    love.graphics.rectangle('fill', 0, 280, 220, 200)

    -- play box
    love.graphics.setColor(unpack(color5))
    love.graphics.rectangle('fill', 220, 280, 220, 200)

    -- move box
    love.graphics.setColor(unpack(color6))
    love.graphics.rectangle('fill', 440, 280, 220, 200)

-- this is the score and timer

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " ..tostring(score), 20, 20)
    love.graphics.print("Level: " ..tostring(level), 20, 40)
    if timer > 0 then
        love.graphics.print("Time Remaining: " ..tostring(math.ceil(timer)) .. " seconds", 400, 20)
    end


    -- adds a message on the timer text if game is over.
    if timer <= 0 then
        love.graphics.print("Time Remaining: NONE!", 400, 20)
    end


-- this is the boxsim outline
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', (boxX+5), (boxY+5), boxHeight, boxWidth)

-- this is the boxsim
    love.graphics.setColor(unpack(currentColor))
    love.graphics.rectangle('fill', boxX, boxY, boxHeight, boxWidth)

-- print out the countdown from 3 to "game over" here
    if finalCountDown == true then
        if gameover == true then finalCountDownNumber = "GAME OVER!"
        end
        love.graphics.setColor(1, 0, 0)
        love.graphics.print(tostring(math.ceil(finalCountDownNumber)), 300, 200)
        finalCountDownNumber = finalCountDownNumber - 1
    end
-- prints the "game over" text at the end of the game.
    if gameover == true then
        love.graphics.setColor(1,1,1)
        love.graphics.print("GAME OVER!", 100, 50)
    end

end
