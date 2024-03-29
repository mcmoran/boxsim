

function love.load()

    -- translator for 255  color base -- probalby won't use for this project.
    --[[
    local _setColor = love.graphics.setColor
    function love.graphics.setColor(r, g, b, a)
        return _setColor(r/255, g/255, b/255, a and a/255)
    end
    ]]--

    -- fonts
    mainFont = love.graphics.newFont("Muli-SemiBold.ttf", 14)
    boldFont = love.graphics.newFont("Muli-Black.ttf", 20)
    timeFont = love.graphics.newFont("Muli-Black.ttf", 50)
    bigTimer = love.graphics.newFont("Muli-Black.ttf", 200)
    gameOverFont = love.graphics.newFont("Muli-Black.ttf", 80)

    -- loading the music and audio files
    blip = love.audio.newSource('Blip_Select4.wav', 'static')
    timerBlip = love.audio.newSource('hit.wav', 'static')
    countdownMusic = love.audio.newSource('countdown.ogg', 'static')
    bgMusic = love.audio.newSource('bby.ogg', 'stream')
        bgMusic:setLooping(true)
        bgMusic:setVolume(0.1)
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

    tilemap = { {1, 2, 3},
                {4, 5, 6} }

    currentSpeed = 600

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
    timer = 30
    countdown = 10
    gamestart = true
    gameover = false
    i = 0 -- this is the level loop

  --the player stored as a table. you can set these to taste.
  -- player = {x = 4, y = 4, size = TILE_SIZE, speed = 0.2, timer = 0}

-- level 1 = full colors
  colorLevel1 = { {1, 1, 0},
                  {0, 1, 0},
                  {0, 1, 1},
                  {1, 0, 1},
                  {1, 0, 0},
                  {1, 0.5, 0} }

-- level 2 = bright rainbow
  colorLevel2 = { {.96, .90, .23},
                  {.28, .95, .2},
                  {.21, .69, 1},
                  {.67, .26, .8},
                  {1, .23, .16},
                  {.98, .54, .09} }

-- level 3 = pastelle rainbow
  colorLevel3 = { {.96, .91, .47},
                  {.51, .96, .55},
                  {.48, .65, .87},
                  {.71, .47, .8},
                  {1, .51, .43},
                  {1, .71, .53} }
-- level 4 = greyscale
  colorLevel4 = { {1, 1, 1},
                  {.8, .8, .8},
                  {.6, .6, .6},
                  {.4, .4, .4},
                  {.2, .2, .2},
                  {0, 0, 0} }

 -- level 5 = yellows
  colorLevel5 = { {.96, .94, .8},
                  {.94, .86, .54},
                  {.86, .76, .32},
                  {.82, .7, .47},
                  {.72, .6, .02},
                  {.50, .4, 0} }

 -- level 6 = greens
  colorLevel6 = { {.86, .96, .81},
                  {.67, .94, .61},
                  {.46, .86, .37},
                  {.25, .82, .5},
                  {.15, .74, .4},
                  {.1, .6, .2} }

 -- level 7 = blues
  colorLevel7 = { {.81, .9, .96},
                  {.59, .8, .94},
                  {.37, .69, .86},
                  {.17, .61, .82},
                  {0, .49, .74},
                  {0, .3, .6} }

 -- level 8 = purples
  colorLevel8 = { {.88, .83, .96},
                  {.76, .61, .94},
                  {.57, .36, .86},
                  {.43, .17, .82},
                  {.3, 0, .74},
                  {.2, 0, .5} }

 -- level 9 = reds
  colorLevel9 = { {.93, .95, .85},
                  {.94, .61, .63},
                  {.85, .36, .38},
                  {.82, .18, .22},
                  {.6, 0, .05},
                  {.5, 0, 0} }

 -- level 10 = oranges
  colorLevel10 = { {.95, .86, .81},
                  {.92, .73, .58},
                  {.87, .58, .34},
                  {.78, .43, .15},
                  {.74, .32, 0},
                  {.65, .22, 0} }

-- level 11 = light rainbow
  colorLevel11 = { {.96, .92, .72},
                  {.73, .96, .78},
                  {.69, .77, .87},
                  {.75, .65, .82},
                  {.99, .82, .79},
                  {.98, .85, .73} }


    levelMap = { colorLevel1, colorLevel2, colorLevel3, colorLevel4,
                colorLevel5, colorLevel6, colorLevel7, colorLevel8,
                colorLevel9, colorLevel10, colorLevel11 }

--[[ older colors (discontinued)

    color1 = {.5, .5, .5} -- sleep (grey)
    color2 = {1, .4, .4} -- eat (red)
    color3 = {.22, .67, 1} -- drink (blue)
    color4 = {.70, .43, 85} -- learn (purple)
    color5 = {1, 1, 0} -- play (yellow)
    color6 = {.25, .9, .29} -- move (green)
    --]]

end

function love.update(dt) -- dt = delta time

if gamestart == true then

    -- setting a conditional loop for keystroke actions
    if love.keyboard.isDown('up') then
        boxY = boxY - currentSpeed * dt -- use dt so it doesn't go too fast/slow
    elseif love.keyboard.isDown('down') then
        boxY = boxY + currentSpeed * dt
    elseif love.keyboard.isDown('left') then
        boxX = boxX - currentSpeed * dt
    elseif love.keyboard.isDown('right') then
        boxX = boxX + currentSpeed * dt
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
        --currentColor = color1
        currentColor = levelMap[level][1]
    elseif (currentRow == 1 and currentCol == 2) then
        currentLocation = 2
        --currentColor = color2
        currentColor = levelMap[level][2]
    elseif (currentRow == 1 and currentCol == 3) then
        currentLocation = 3
        --currentColor = color3
        currentColor = levelMap[level][3]
    elseif (currentRow == 2 and currentCol == 1) then
        currentLocation = 4
        --currentColor = color4
        currentColor = levelMap[level][4]
    elseif (currentRow == 2 and currentCol == 2) then
        currentLocation = 5
        --currentColor = color5
        currentColor = levelMap[level][5]
    elseif (currentRow == 2 and currentCol == 3) then
        currentLocation = 6
        --currentColor = color6
        currentColor = levelMap[level][6]
    end -- hi

    -- if the box is in the right area, then change the color to random
    -- and reset the timer
    if needLocation == currentLocation then
        needLocation = love.math.random(1,6)
        if needLocation ~= currentLocation then

            timerBlip:setVolume(0.2)
            timerBlip:play()
            score = score + 1
            i = i + 1
        end
    end

    -- this makes the counter count in 1 second increments
    dtCounter = dtCounter + dt

    -- plays the timer blip sound each second.
    if (timer > 10 and dtCounter >= 1) then
        dtCounter = 0
    end

    -- increase stats every 10 points
    if i == 10 then
        level = level + 1
        blip:play()
        timer = timer * 1.3 + 5
        currentSpeed = currentSpeed - 50
        if currentSpeed < 100 then
            currentSpeed = 100
        end
        i = 0
    end

    -- changes the current color to the need color
    if needLocation == 1 then currentColor = levelMap[level][1]
    elseif needLocation == 2 then currentColor = levelMap[level][2]
    elseif needLocation == 3 then currentColor = levelMap[level][3]
    elseif needLocation == 4 then currentColor = levelMap[level][4]
    elseif needLocation == 5 then currentColor = levelMap[level][5]
    elseif needLocation == 6 then currentColor = levelMap[level][6]
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
    -- love.graphics.setColor(unpack(color1))

    --love.graphics.setColor(colorLevel1[1])
    love.graphics.setColor(levelMap[level][1])
    love.graphics.rectangle('fill', 0, 80, 220, 200)

    -- eat box
    --love.graphics.setColor(unpack(color2))
    love.graphics.setColor(levelMap[level][2])
    love.graphics.rectangle('fill', 220, 80, 220, 200)

    -- drink box
    --love.graphics.setColor(unpack(color3))
    love.graphics.setColor(levelMap[level][3])
    love.graphics.rectangle('fill', 440, 80, 220, 200)

    -- learn box
    --love.graphics.setColor(unpack(color4))
    love.graphics.setColor(levelMap[level][4])
    love.graphics.rectangle('fill', 0, 280, 220, 200)

    -- play box
    --love.graphics.setColor(unpack(color5))
    love.graphics.setColor(levelMap[level][5])
    love.graphics.rectangle('fill', 220, 280, 220, 200)

    -- move box
    --love.graphics.setColor(unpack(color6))

    love.graphics.setColor(levelMap[level][6])
    love.graphics.rectangle('fill', 440, 280, 220, 200)

-- this is the score and timer

-- Setting the font so that it is used when drawning the string.



    -- the score prints
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(mainFont)
    love.graphics.print("SCORE: ", 20, 20)

    love.graphics.setColor(0, .5, 1)
    love.graphics.setFont(boldFont)
    love.graphics.print(tostring(score), 80, 15)

    -- the level score
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(mainFont)
    love.graphics.print("LEVEL: ", 20, 50)

    love.graphics.setColor(levelMap[level][1])
    love.graphics.setFont(boldFont)
    love.graphics.print(tostring(level), 80, 45)

    -- the timer remaining
    if timer > 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(mainFont)
        love.graphics.print("TIME: ", 400, 45)

        love.graphics.setColor(levelMap[level][1])
        love.graphics.setFont(timeFont)
        love.graphics.print(tostring(math.ceil(timer)), 450, 10)
    end

    if timer <= 3 then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.setFont(bigTimer)
        love.graphics.print(tostring(math.ceil(timer)), 270, 150)
    elseif timer == 0 then
    end
    --[[if timer > 0 then
        love.graphics.print("Time Remaining" ..tostring(math.ceil(timer)) .. " seconds", 350, 20)
    end--]]


    -- adds a message on the timer text if game is over.
    if timer <= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(mainFont)
        love.graphics.print("TIME: ", 400, 45)

        love.graphics.setColor(levelMap[level][1])
        love.graphics.setFont(timeFont)
        love.graphics.print("NONE!", 450, 10)
    end


-- this is the boxsim outline
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', (boxX+5), (boxY+5), boxHeight, boxWidth)

-- this is the boxsim
    love.graphics.setColor(unpack(currentColor))
    love.graphics.rectangle('fill', boxX, boxY, boxHeight, boxWidth)

--[[ print out the countdown from 3 to "game over" here
    if finalCountDown == true then
        if gameover == true then finalCountDownNumber = "GAME OVER!"
        end
        love.graphics.setColor(1, 0, 0)
        love.graphics.print(tostring(math.ceil(finalCountDownNumber)), 300, 200)
        finalCountDownNumber = finalCountDownNumber - 1
    end
    --]]

-- prints the "game over" text at the end of the game.
    if gameover == true then
        love.graphics.setFont(gameOverFont)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("GAME OVER!", 85, 235)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("GAME OVER!", 80, 230)
    end

end
