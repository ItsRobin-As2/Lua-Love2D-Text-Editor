screenWidth = 1000  -- Resizable
screenHeight = 620  -- Resizable
local logged, blink = false, false
local file, username = "", ""
local newCanvas = love.graphics.newCanvas();
local currentFile
local currentBox, currLine, buttonClicked, timer = 0, 1, 0, 0
local userBoxX, userBoxY, userBoxW, userBoxH
local fileBoxX, fileBoxY, fileBoxW, fileBoxH
local submitButtonX, submitButtonY, submitButtonW, submitButtonH
local usernameBoxIsClicked, fileBoxIsClicked, submitButtonClicked, mainMenuClicked = false, false, false, false
local exitWindowBool, saveToFileBool = false, false
local colors = {
    white = {0.9, 0.9, 0.9},
    textWhite = {1, 1, 1},
    yellow = {252/255, 232/255, 3/255},
    red = {186/255, 23/255, 11/255},
    greyishBlack = {18/255, 18/255, 18/255, 80/255},
    lightBlack = {14/255, 14/255, 14/255},
    lightBlack2 = {12/255, 12/255, 12/255},
    darkBlack = {6/255, 6/255, 6/255},
    lightGreen = {16/255, 196/255, 42/255},
    green = {11/255, 133/255, 29/255}
} -- All colors used in the application
local lines = {
    -- Editor Text
} -- Stores the lines visible in the screen

-- Love2d load function
function love.load()
    love.keyboard.setKeyRepeat(true)
    -- Set Background Color to Black
    love.graphics.setBackgroundColor(colors.lightBlack)
    -- Loads all text fonts and objects
    loadAllText()
    -- Checks if user is already logged in
    local infoFile = io.open("Lua Editor\\editorInfo.md", "r")
    if infoFile then
        username = infoFile:read()
        if username then
            username = username:match("^[^;]*;(.*)")
            if username ~= "" then
                file = infoFile:read()
                if file then
                    file = file:match("^[^;]*;(.*)")
                    logged = true
                end
            end
        end
        infoFile:close()
    end
    if file ~= "" and file ~= nil then
        currentFile = io.open("files/" .. file, "r")
        if currentFile then
            for currentLine in currentFile:read("*l") do
                table.insert(lines, currentLine)
            end
            currentFile:close()
        end
    end
end

-- Love2d update function
function love.update(dt)
    timer = timer + dt
    if timer >= 0.75 then
        blink = not blink
        timer = timer - 0.75
    end
end

-- Love2d draw function
function love.draw()
    -- Get Windows Height & Width
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    -- If user is not logged in then ask user for login
    if not logged then
        loginScreen(screenWidth, screenHeight)
        welcomeScreen(screenWidth, screenHeight)
    elseif logged == true then
        -- Editor starts here
        startEditor(screenWidth, screenHeight)
        if mainMenuClicked then
            mainMenu(screenWidth, screenHeight)
        else
            drawFileData(screenWidth, screenHeight)
        end
    end
end

-- Takes text as input
function love.textinput(t)
    if logged == true then
        if lines[currLine] then
            lines[currLine] = lines[currLine] .. t
            blink = true
            if timer >= 0 then
                timer = timer - 0.5
            end
        else
            lines[currLine] = t
        end
    else
        -- Takes input in username field & file field
        if currentBox == 1 then
            -- Defines max input size as 16
            if string.sub(username, 1, 1) == " " then
                username = ""
                return
            end
            if #username == 18 then
                return
            end
            username = username .. t
        elseif currentBox == 2 then
            -- Defines max input size as 16
            if string.sub(file, 1, 1) == " " then
                file = ""
                return
            end
            if #file == 20 then
                return
            end
            file = file .. t
        end
    end
end

-- This function checks if user left clicked on one of input fields
function love.mousepressed( x, y, button)
    if button == 1 then
        if not logged then
            -- Checks if left click is inside username box
            if (x > userBoxX and x < userBoxX + userBoxW) and (y > userBoxY and y < userBoxY + userBoxH) then
                usernameBoxIsClicked = true
                fileBoxIsClicked = false
                currentBox = 1
            end
            -- Checks if left click is inside file box
            if (x > fileBoxX and x < fileBoxX + fileBoxW) and (y > fileBoxY and y < fileBoxY + fileBoxH) then
                fileBoxIsClicked = true
                usernameBoxIsClicked = false
                currentBox = 2
            end
            -- Checks if left click is inside submit button
            if (x > submitButtonX and x < submitButtonX + submitButtonW) and (y > submitButtonY and y < submitButtonY + submitButtonH) then
                fileBoxIsClicked = false
                usernameBoxIsClicked = false
                submitButtonClicked = true
            end
        else
            -- Checks if left click is inside main menu button
            if (x > 15 and x < 45) and (y > 17 and y < 45) then
                mainMenuClicked = not mainMenuClicked
            end

            if mainMenuClicked then
                -- Check if button1 of main menu is clicked
                if (x > 14 and x < 14 + (screenWidth - 6 * 7 - 72) / 7.2)
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 1
                end
                -- Check if button2 of main menu is clicked
                if (x > 22 + (screenWidth - 6 * 7 - 72) / 7.2 and x < 22 + 2 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 2
                end
                -- Check if button3 of main menu is clicked
                if (x > 30 + 2 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 30 + 3 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 3
                end
                -- Check if button4 of main menu is clicked
                if (x > 38 + 3 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 38 + 4 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 4
                end
                -- Check if button5 of main menu is clicked
                if (x > 46 + 4 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 46 + 5 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 5
                end
                -- Check if button6 of main menu is clicked
                if (x > 54 + 5 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 54 + 6 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 6
                end
                -- Check if button7 of main menu is clicked
                if (x > 54 + 6 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < screenWidth - 15)
                        and (y > 72 and y < 72 + screenHeight / 17.5) then
                    buttonClicked = 7
                end
                -- Check if button8 of main menu is clicked
                if (x > 14 and x < 14 + (screenWidth - 6 * 7 - 72) / 7.2)
                        and (y > 82 + screenHeight / 17.5 and y < 82 + 2 * (screenHeight / 17.5)) then
                    buttonClicked = 8
                end
                -- Check if button9 of main menu is clicked
                if (x > 22 + (screenWidth - 6 * 7 - 72) / 7.2 and x < 22 + 2 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 82 + screenHeight / 17.5 and y < 82 + 2 * (screenHeight / 17.5)) then
                    buttonClicked = 9
                end
                -- Check if button10 of main menu is clicked
                if (x > 30 + 2 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 30 + 3 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 82 + screenHeight / 17.5 and y < 82 + 2 * (screenHeight / 17.5)) then
                    buttonClicked = 10
                end
                -- Check if button11 of main menu is clicked
                if (x > 38 + 3 * ((screenWidth - 6 * 7 - 72) / 7.2) and x < 38 + 4 * ((screenWidth - 6 * 7 - 72) / 7.2))
                        and (y > 82 + screenHeight / 17.5 and y < 82 + 2 * (screenHeight / 17.5)) then
                    buttonClicked = 11
                end
                -- Something is going on here
                if buttonClicked == 8 then
                    -- If yes is clicked in sub window
                    if (x > screenWidth / 2 - 359 / 2 + 280 and x < screenWidth / 2 - 359 / 2 + 180)
                            and (y > screenHeight / 2 - 45 and y < screenHeight / 2 + 125) then
                        saveToFileBool = true
                    end
                    -- If no is clicked in sub window
                    if (x > screenWidth / 2 - 359 / 2 + 80 and x < screenWidth / 2 + 112)
                            and (y > screenHeight / 2 - 45 and y < screenHeight / 2 + 125) then
                        saveToFileBool = false
                        buttonClicked = 0
                    end
                end
                if buttonClicked == 11 then
                    -- If yes is clicked in exit window prompt
                    if (x > screenWidth / 2 - 113 and x < screenWidth / 2 - 13)
                            and (y > screenHeight / 2 - 45 and y < screenHeight / 2 + 125) then
                        exitWindowBool = true
                    end
                    -- If no is clicked in exit window prompt
                    if (x > screenWidth / 2 + 12 and x < screenWidth / 2 + 112)
                            and (y > screenHeight / 2 - 45 and y < screenHeight / 2 + 125) then
                        exitWindowBool = false
                        buttonClicked = 0
                    end
                end
            end
        end
    end
end

-- If backspace is pressed then remove last character from username or file name
function love.keypressed(key)
    -- Press escape to show main menu
    if key == "escape" and logged == true then
        mainMenuClicked = not mainMenuClicked
        buttonClicked = 0
    end
    -- Press backspace to remove last character
    if key == "backspace" then
        if logged == true then
            if lines[currLine] == "" and currLine > 1 then
                lines[currLine] = nil
                currLine = currLine - 1
            end
            if lines[currLine] then
                lines[currLine] = string.sub(lines[currLine], 1, #lines[currLine] - 1)
                blink = false
                if timer >= 0 then
                    timer = timer - 0.5
                end
            end
        else
            if currentBox == 1 then
                username = string.sub(username, 1, #username - 1)
            elseif currentBox == 2 then
                file = string.sub(file, 1, #file - 1)
            end
        end
    end
    -- Press enter to submit username or file name
    if key == "return" then
        if logged == true then
            if lines[currLine] then
                lines[currLine] = lines[currLine] .. "\n"
            else
                lines[currLine] = "\n"
            end
            currLine = currLine + 1
            lines[currLine] = ""
        end
        if currentBox == 0 then
            usernameBoxIsClicked = true
            currentBox = 1
        elseif currentBox == 1 then
            fileBoxIsClicked = true
            usernameBoxIsClicked = false
            currentBox = 2
        elseif currentBox == 2 then
            fileBoxIsClicked = false
            currentBox = 0
        end
    end
end

-- All text fonts and objects are inside this function
function loadAllText()
    -- Welcome Text
    fontW = love.graphics.newFont(50)
    love.graphics.setFont(fontW)
    textW = love.graphics.newText(fontW, {{1, 1, 1}, "Welcome to Lua IDE!"})
    textWidth = textW:getWidth()
    -- Login Font1
    font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    text = love.graphics.newText(font, "Username: ")
    text2 = love.graphics.newText(font, "File Name: ")
    -- Login Font2
    font1 = love.graphics.newFont(25)
    love.graphics.setFont(font1)
    boldText = love.graphics.newText(font1, "Username: ")
    boldText2 = love.graphics.newText(font1, "File Name: ")
    -- Login Username Input Font
    userInputFont = love.graphics.newFont(20)
    love.graphics.setFont(userInputFont)
    userInputFontBig = love.graphics.newFont(25)
    love.graphics.setFont(userInputFontBig)
    -- Login File Name Input Font
    fileInputFont = love.graphics.newFont(20)
    love.graphics.setFont(fileInputFont)
    fileInputFontBig = love.graphics.newFont(25)
    love.graphics.setFont(fileInputFontBig)
    -- Submit Text
    submitInputFont = love.graphics.newFont(35)
    love.graphics.setFont(submitInputFont)
    submitText = love.graphics.newText(submitInputFont, "SUBMIT")
    -- User Name
    userNameFont = love.graphics.newFont(30)
    love.graphics.setFont(userNameFont)
    userNameText = love.graphics.newText(userNameFont, {{1, 1, 1}, username})
    -- File Name
    fileNameFont = love.graphics.newFont(30)
    love.graphics.setFont(fileNameFont)
    fileNameText = love.graphics.newText(fileNameFont, {{1, 1, 1}, file})
    -- Bricolage Font
    bricolageFont = love.graphics.newFont("assets/BricolageGrotesque_48pt_Condensed-Light.ttf", 32)
    love.graphics.setFont(bricolageFont)
    -- Bricolage Font Small
    bricolageFontSmall = love.graphics.newFont("assets/BricolageGrotesque_48pt_Condensed-Light.ttf", 24)
    love.graphics.setFont(bricolageFontSmall)
    -- Editor Numbers Font
    ABZNum = love.graphics.newFont("assets/ABeeZee-Regular.ttf", 26)
    love.graphics.setFont(ABZNum)
    -- Editor Text Font
    ABZText = love.graphics.newFont("assets/ABeeZee-Regular.ttf", 24)
    love.graphics.setFont(ABZText)
    -- Main menu buttons text
    button1Text = love.graphics.newText(bricolageFontSmall, "New File")
    button2Text = love.graphics.newText(bricolageFontSmall, "Rename")
    button3Text = love.graphics.newText(bricolageFontSmall, "Delete")
    button4Text = love.graphics.newText(bricolageFontSmall, "Empty2")
    button5Text = love.graphics.newText(bricolageFontSmall, "Empty3")
    button6Text = love.graphics.newText(bricolageFontSmall, "Clear")
    button7Text = love.graphics.newText(bricolageFontSmall, {{0.5, 0.3, 0.8}, "Change Editor Color"})
    button8Text = love.graphics.newText(bricolageFontSmall, "Save")
    button9Text = love.graphics.newText(bricolageFontSmall, "Save As")
    button10Text = love.graphics.newText(bricolageFontSmall, "Settings")
    button11Text = love.graphics.newText(bricolageFontSmall, "Exit")
end

-- Shows welcome text in login screen
function welcomeScreen()
    love.graphics.setColor(colors.textWhite)
    love.graphics.draw(textW, screenWidth / 2 - textWidth / 2, screenHeight / 7)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.draw(textW, screenWidth / 2 - textWidth / 2 + 2, screenHeight / 7 + 2)
end

-- Shows login screen with username & file name as input fields and a submit button
function loginScreen()
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", 10, 10, screenWidth - 20, screenHeight - 20, 10)

    local lsh = 220; local lsw = 500
    local lsx = screenWidth / 2 - lsw / 2; local lsy = screenHeight / 2 - lsh / 2
    love.graphics.setColor(colors.lightBlack)
    love.graphics.rectangle("fill", lsx, lsy, lsw, lsh, 10)

    local lsh1 = lsh - 20; local lsw1 = lsw - 20
    local lsx1 = (screenWidth / 2 - lsw / 2) + 10; local lsy1 = (screenHeight / 2 - lsh / 2) + 10
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", lsx1, lsy1, lsw1, lsh1, 10)

    -- This is main box inside which are username box & input box
    local lsh2 = lsh - 40; local lsw2 = lsw - 40
    local lsx2 = (screenWidth / 2 - lsw / 2) + 20; local lsy2 = (screenHeight / 2 - lsh / 2) + 20
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", lsx2, lsy2, lsw2, lsh2, 10)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.rectangle("fill", lsx2 + 1, lsy2 + 1, lsw2 - 2, lsh2 - 2, 10)

    -- If username box is clicked then highlight it
    if usernameBoxIsClicked then
        userInputBox(lsx2 - 5, lsy2 - 5, 10)
    else
        userInputBox(lsx2, lsy2)
    end

    -- If file box is clicked then highlight it
    if fileBoxIsClicked then
        fileInputBox(lsx2 - 5, lsy2 - 5, 10)
    else
        if usernameBoxIsClicked then
            fileInputBox(lsx2, lsy2 - 10)
        else
            fileInputBox(lsx2, lsy2)
        end
    end

    -- Show submit button
    submitButton(lsx + lsw / 4, lsy + lsh / 2)
end

-- This function creates the username box & text inside it, It also highlights the box if it is clicked
function userInputBox(lsx2, lsy2, diff)
    diff = diff or 0
    -- Username box dimensions and size
    userBoxH = 60 + diff; userBoxW = 420 + diff
    userBoxX = lsx2 + 20; userBoxY = lsy2 + 20

    -- If diff is not zero that means user have clicked on the box so highlight it
    if diff ~= 0 then
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", userBoxX - 1, userBoxY - 1, userBoxW + 2, userBoxH + 2, 10)
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", userBoxX, userBoxY, userBoxW, userBoxH, 10)
        love.graphics.setColor(colors.darkBlack)
        love.graphics.draw(boldText, userBoxX + 15, userBoxY + 17)

        -- Shows user input inside username box
        -- love.graphics.setColor(colors.darkBlack)
        love.graphics.print({colors.textWhite, username}, userInputFontBig, userBoxX + 160, userBoxY + 17)
    else
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", userBoxX, userBoxY, userBoxW, userBoxH, 10)
        love.graphics.setColor(colors.textWhite)
        love.graphics.draw(text, userBoxX + 15, userBoxY + 17)

        -- Shows user input inside username box
        -- love.graphics.setColor(colors.white)
        love.graphics.print({colors.textWhite, username}, userInputFont, userBoxX + 160, userBoxY + 17)
    end
end

-- This function creates the file box & text inside it, It also highlights the box if it is clicked
function fileInputBox(lsx2, lsy2, diff)
    diff = diff or 0
    -- File box dimensions and size
    fileBoxH = 60 + diff; fileBoxW = 420 + diff
    fileBoxX = lsx2 + 20; fileBoxY = userBoxH + lsy2 + 40

    -- If diff is not zero that means user have clicked on the box so highlight it
    if diff ~= 0 then
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", fileBoxX - 1, fileBoxY - 1, fileBoxW + 2, fileBoxH + 2, 10)
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", fileBoxX, fileBoxY, fileBoxW, fileBoxH, 10)
        love.graphics.setColor(colors.darkBlack)
        love.graphics.draw(boldText2, fileBoxX + 15, fileBoxY + 17)

        -- Shows user input inside file name box
        --  love.graphics.setColor(colors.darkBlack)
        love.graphics.print({colors.textWhite, file}, fileInputFontBig, fileBoxX + 160, fileBoxY + 17)
    else
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", fileBoxX, fileBoxY, fileBoxW, fileBoxH, 10)
        love.graphics.setColor(colors.textWhite)
        love.graphics.draw(text2, fileBoxX + 15, fileBoxY + 17)

        -- Shows user input inside file name box
        --love.graphics.setColor(colors.white)
        love.graphics.print({colors.textWhite, file}, fileInputFont, fileBoxX + 160, fileBoxY + 17)
    end
end

-- This function creates the submit button, It saves the user input if it is clicked
function submitButton(sx, sy)
    -- Submit button dimensions and size
    submitButtonH = 60; submitButtonW = 260
    submitButtonX = sx; submitButtonY = userBoxH + sy + 80

    -- Keeps submit button align
    if usernameBoxIsClicked then
        submitButtonY = userBoxH + sy + 70
    end

    -- Draws submit button highlights
    if not submitButtonClicked then
        love.graphics.setColor(colors.lightGreen)
        love.graphics.rectangle("fill", submitButtonX + 2, submitButtonY + 2, submitButtonW, submitButtonH, 10)
    end
    -- Draws submit button and text
    love.graphics.setColor(colors.green)
    love.graphics.rectangle("fill", submitButtonX , submitButtonY, submitButtonW, submitButtonH, 10)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.draw(submitText, submitButtonX + submitButtonW / 4, submitButtonY + 10)
    love.graphics.setColor(colors.textWhite)
    love.graphics.draw(submitText, submitButtonX + submitButtonW / 4 + 2, submitButtonY + 10 + 2)

    -- If user submits save username to file
    if submitButtonClicked then
        -- If user does not provide username and file name then use defaults
        if username == "" or username == nil then
            username = "Guest0123"
        end
        if file == "" or file == nil then
            file = "Example.txt"
        end
        -- Write username to file editorInfo.md
        local infoFile = io.open("Lua Editor\\editorInfo.md", "w")
        if infoFile then
            infoFile:write("Username;" .. username .. "\n")
            infoFile:write("Last File Used;" .. file .. "\n")
            infoFile:close()
            currentFile = io.open("Lua Editor/files/".. file, "w")
            if currentFile then
                currentFile:close()
            end
            logged = true
        end
    end
end

-- Starts the main editor
function startEditor()
    love.graphics.draw(newCanvas)
    -- Navbar
    local navBarH = 50; local navBarW = screenWidth - 10
    local navBarX = 5; local navBarY = 7
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", navBarX, navBarY, navBarW, navBarH, 5)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.rectangle("fill", navBarX + 1, navBarY + 1, navBarW - 2, navBarH - 2, 5)
    -- Main Menu
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", navBarX + 10, navBarY + 10, 30, 30, 5)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.rectangle("fill", navBarX + 10 + 2, navBarY + 10 + 2, 30 - 4, 30 - 4, 5)
    -- Display Username
    love.graphics.setColor(colors.textWhite)
    love.graphics.print("Hi " .. username .. "!", bricolageFont, 60, navBarY + navBarH / 7)
    -- Display Filename
    fileWidth = bricolageFont:getWidth(file)
    love.graphics.setColor(colors.textWhite)
    love.graphics.print(file, bricolageFont, navBarW - fileWidth - 10, navBarY + navBarH / 7)
    -- Editor
    local editorH = screenHeight - 70; local editorW = screenWidth - 10
    local editorX = navBarX; local editorY = navBarH + navBarY + 5
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", editorX, editorY, editorW, editorH, 5)
    love.graphics.setColor(colors.lightBlack)
    love.graphics.rectangle("fill", editorX + 1, editorY + 1, editorW - 2, editorH - 2, 5)
end

-- This function draws a button with given size & position
function drawButton(btnX, btnY, btnW, btnH)
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", btnX, btnY, btnW, btnH, 5)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", btnX + 1, btnY + 1, btnW - 2, btnH - 2, 5)
end

-- This function draws text at a given position
function drawText(button, X, Y)
    love.graphics.setColor(colors.textWhite)
    love.graphics.draw(button, X, Y)
end

-- Highlight the text of selected button
function drawHighlightedText(button, X, Y)
    love.graphics.setColor(colors.lightGreen)
    love.graphics.draw(button, X, Y)
end

-- Draws main menu
function mainMenu()
    -- Main Menu size & location
    local mainMenuW = screenWidth - 10; local mainMenuH = ((screenHeight / 17.5) * 2) + 34
    local mainMenuX = 5; local mainMenuY = 60
    -- Check if main menu button is clicked
    if mainMenuClicked then
        -- Main menu icon
        love.graphics.setColor(colors.darkBlack)
        love.graphics.rectangle("fill", 16, 18, 28, 28, 5)
        -- Main menu Layout
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", mainMenuX, mainMenuY, mainMenuW, mainMenuH, 5)
        love.graphics.setColor(colors.darkBlack)
        love.graphics.rectangle("fill", mainMenuX + 1, mainMenuY + 1, mainMenuW - 2, mainMenuH - 2, 5)
        -- Main menu buttons
        local btnW = (screenWidth - 6 * 7 - 72) / 7.2; local btnH = screenHeight / 17.5
        local btnX = mainMenuX + 9; local btnY = 72
        -- button 1
        width1Text = font:getWidth("New File")
        local textX = (btnW / 2 - width1Text / 4) + 3; local textY = 57 + btnH / 2
        if buttonClicked == 1 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button1Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button1Text, textX, textY)
        end
        -- button 2
        btnX = btnX + btnW + 8
        width2Text = font:getWidth("Rename")
        textX = (btnW / 2 - width2Text / 4) + 12 + btnW;
        if buttonClicked == 2 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button2Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button2Text, textX, textY)
        end
        -- button 3
        btnX = btnX + btnW + 8
        width3Text = font:getWidth("Delete")
        textX = (btnW / 2 - width3Text / 4) + btnX - 5;
        if buttonClicked == 3 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button3Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button3Text, textX, textY)
        end
        -- button 4
        btnX = btnX + btnW + 8
        width4Text = font:getWidth("Empty2")
        textX = btnX + (btnW / 2 - width4Text / 4) - 5;
        if buttonClicked == 4 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button4Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button4Text, textX, textY)
        end
        -- button 5
        btnX = btnX + btnW + 8
        width5Text = font:getWidth("Empty3")
        textX = btnX + (btnW / 2 - width5Text / 4) - 5;
        if buttonClicked == 5 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button5Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button5Text, textX, textY)
        end
        -- button 6
        btnX = btnX + btnW + 8
        width6Text = font:getWidth("Clear")
        textX = btnX + (btnW / 2 - width6Text / 4) - 5;
        if buttonClicked == 6 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button6Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button6Text, textX, textY)
        end
        -- button 7
        btnX = btnX + btnW + 8
        btnW = (screenWidth - 15) - btnX
        width7Text = font:getWidth("Change Editor Color")
        textX = btnX + (btnW / 2 - width7Text / 4) - 20;
        if buttonClicked == 7 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawText(button7Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button7Text, textX, textY)
        end
        -- button 8
        btnX = mainMenuX + 9; btnY = btnY + btnH + 10
        btnW = (screenWidth - 6 * 7 - 72) / 7.2
        width8Text = font:getWidth("Save")
        textX = btnX + (btnW / 2 - width8Text / 4) - 5; textY = textY + btnH + 10
        if buttonClicked == 8 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button8Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button8Text, textX, textY)
        end
        -- button 9
        btnX = btnX + btnW + 8
        width9Text = font:getWidth("Save As")
        textX = btnX + (btnW / 2 - width9Text / 4) - 7
        if buttonClicked == 9 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button9Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button9Text, textX, textY)
        end
        -- button 10
        btnX = btnX + btnW + 8
        width10Text = font:getWidth("Settings")
        textX = btnX + (btnW / 2 - width10Text / 4) - 8
        if buttonClicked == 10 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button10Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button10Text, textX, textY)
        end
        -- button 11
        btnX = btnX + btnW + 8
        width11Text = font:getWidth("Exit")
        textX = btnX + (btnW / 2 - width11Text / 4) - 4
        if buttonClicked == 11 then
            drawButton(btnX - 4, btnY - 4, btnW + 8, btnH + 8)
            drawHighlightedText(button11Text, textX, textY)
        else
            drawButton(btnX, btnY, btnW, btnH)
            drawText(button11Text, textX, textY)
        end
        if buttonClicked ~= 0 then
            performAction()
        end
    end
end

-- Draw text on screen
function drawFileData()
    local posX = 25; local posY = 75
    love.graphics.setColor(colors.white)
    love.graphics.printf(1 .. ". ", ABZNum, posX - 5, posY, 40, "right")
    for i, str in ipairs(lines) do
        love.graphics.setColor(colors.white)
        love.graphics.printf(i .. ". ", ABZNum, posX - 5, posY, 40, "right")
        love.graphics.setColor(colors.white)
        love.graphics.printf(str, ABZText, posX * 3, posY, screenWidth - 120, "left")
        local _, wrappedLines = ABZNum:getWrap(str, screenWidth - 120)
        local totalHeight = #wrappedLines * 24 - 9
        if posY + totalHeight >= screenHeight - 60 then
            break
        end
        posY = posY + totalHeight
    end
    drawBlinkingCaret(screenWidth, screenHeight)
end

-- Draw blinking caret
function drawBlinkingCaret()
    local blinkY = 75; local blinkX = 75
    if lines[currLine] then
        local _, wrappedLines = ABZText:getWrap(lines[currLine], screenWidth - 120)
        blinkX = blinkX + ABZText:getWidth(wrappedLines[#wrappedLines])
        for i = 1, currLine - 1 do
            if lines[i] then
                local _, previousWrappedLines = ABZText:getWrap(lines[i], screenWidth - 120)
                blinkY = blinkY + (#previousWrappedLines * 24) - 9
            end
        end
        if #wrappedLines > 1 then
            local totalHeight = #wrappedLines * ABZText:getHeight() * ABZText:getLineHeight()
            blinkY = blinkY + totalHeight - 27
        end
        if blinkY >= screenHeight - 60 then
            return
        end
        caretBlinking(blinkX, blinkY)
    else
        caretBlinking(75, blinkY)
    end
end

-- Draw caret
function caretBlinking(X, Y)
    if blink then
        love.graphics.setColor(colors.textWhite)
        love.graphics.print("|", ABZText, X, Y)
    end
end

-- Performs different operations in main menu
function performAction()
    if buttonClicked == 1 then
        creatingNewFile()
    elseif buttonClicked == 2 then
        renameFile()
    elseif buttonClicked == 3 then
        deleteCurrFile()
    elseif buttonClicked == 4 then
        -- Empty2
    elseif buttonClicked == 5 then
        -- Empty3
    elseif buttonClicked == 6 then
        clearAllData()
    elseif buttonClicked == 7 then
        changeEditorColor()
    elseif buttonClicked == 8 then
        saveDataToFile()
    elseif buttonClicked == 9 then
        saveFileAs()
    elseif buttonClicked == 10 then
        openSettings()
    elseif buttonClicked == 11 then
        exitWindow()
    end
end

-- Creating a new file
function creatingNewFile()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- Rename an existing file
function renameFile()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- Delete currently opened file
function deleteCurrFile()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- Clear Entire Screen (Work In Progress)
function clearAllData()
    -- Doesn't work properly right now
    lines = {}
    currLine = 1
    buttonClicked = 0
    mainMenuClicked = false
end

-- change editor window color
function changeEditorColor()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- save file (Work In Progress)
function saveDataToFile()
    local txt = "Write data to file?"
    local txtW = ABZText:getWidth(txt)
    local saveWinH = 170;
    local saveWinW = txtW + 150 -- 209
    local saveWinX = screenWidth / 2 - saveWinW / 2 + 10
    local saveWinY = screenHeight / 2 - saveWinH / 2 - 40
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", saveWinX, saveWinY, saveWinW, saveWinH, 10)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", saveWinX + 1, saveWinY + 1, saveWinW - 2, saveWinH - 2, 10)
    love.graphics.setColor(colors.white)
    love.graphics.print(txt, ABZText, screenWidth / 2 - txtW / 2 + 10, saveWinY + 30)
    -- Yes
    local Yes_BtnX = saveWinX + 70; local Yes_BtnY = saveWinY + saveWinH - 90
    local Yes_BtnW = 100; local Yes_BtnH = 50
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", Yes_BtnX, Yes_BtnY, Yes_BtnW, Yes_BtnH, 5)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", Yes_BtnX + 1, Yes_BtnY + 1, Yes_BtnW - 2, Yes_BtnH - 2, 5)
    love.graphics.setColor(colors.white)
    love.graphics.print("Yes", ABZText, Yes_BtnX + Yes_BtnW / 3.5, Yes_BtnY + Yes_BtnH / 5)
    -- No
    local No_BtnX = saveWinX + Yes_BtnW + 100; local No_BtnY = saveWinY + saveWinH - 90
    local No_BtnW = 100; local No_BtnH = 50
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", No_BtnX, No_BtnY, No_BtnW, No_BtnH, 5)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", No_BtnX + 1, No_BtnY + 1, No_BtnW - 2, No_BtnH - 2, 5)
    love.graphics.setColor(colors.white)
    love.graphics.print("No", ABZText, No_BtnX + No_BtnW / 3, No_BtnY + No_BtnH / 5)
    -- Save data to file if user clicked yes
    if saveToFileBool then
        -- local saveToFile, error = io.open("files/" .. file, "w")
        print(file)
        for _, line in pairs(lines) do
            love.filesystem.write("files/" .. file, line)
        end
        -- saveToFile:close()
    end
end

-- save file as
function saveFileAs()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- open settings window
function openSettings()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- Prompt for closing the window
function exitWindow()
    local text = "Do you want to exit?"
    local textW = ABZText:getWidth(text) -- 236
    local exitWindowH = 170; local exitWindowW = textW + 150
    local exitWindowPosX = screenWidth / 2 - exitWindowW / 2
    local exitWindowPosY = screenHeight / 2 - exitWindowH / 2 - 40
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", exitWindowPosX, exitWindowPosY, exitWindowW, exitWindowH, 10)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", exitWindowPosX + 1, exitWindowPosY + 1, exitWindowW - 2, exitWindowH - 2, 10)
    love.graphics.setColor(colors.white)
    love.graphics.print(text, ABZText, screenWidth / 2 - textW / 2, exitWindowPosY + 30)
    -- Yes
    local Yes_BtnX = exitWindowPosX + 80; local Yes_BtnY = exitWindowPosY + exitWindowH - 90
    local Yes_BtnW = 100; local Yes_BtnH = 50
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", Yes_BtnX, Yes_BtnY, Yes_BtnW, Yes_BtnH, 5)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", Yes_BtnX + 1, Yes_BtnY + 1, Yes_BtnW - 2, Yes_BtnH - 2, 5)
    love.graphics.setColor(colors.white)
    love.graphics.print("Yes", ABZText, Yes_BtnX + Yes_BtnW / 3.5, Yes_BtnY + Yes_BtnH / 5)
    -- No
    local No_BtnX = exitWindowPosX + Yes_BtnW + 105; local No_BtnY = exitWindowPosY + exitWindowH - 90
    local No_BtnW = 100; local No_BtnH = 50
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", No_BtnX, No_BtnY, No_BtnW, No_BtnH, 5)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", No_BtnX + 1, No_BtnY + 1, No_BtnW - 2, No_BtnH - 2, 5)
    love.graphics.setColor(colors.white)
    love.graphics.print("No", ABZText, No_BtnX + No_BtnW / 3, No_BtnY + No_BtnH / 5)
    -- Close window if yes is clicked
    if exitWindowBool then
        love.graphics.setColor(colors.lightBlack2)
        love.graphics.rectangle("fill", Yes_BtnX, Yes_BtnY, Yes_BtnW, Yes_BtnH, 5)
        love.graphics.setColor(colors.red)
        love.graphics.print("Yes", ABZText, Yes_BtnX + Yes_BtnW / 3.5, Yes_BtnY + Yes_BtnH / 5)
        love.event.quit(0)
    end
end
