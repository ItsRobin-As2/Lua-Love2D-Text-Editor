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

-- Performs different operations in main menu
function performAction()
    if buttonClicked == 1 then
        createNewFileWindow()
    elseif buttonClicked == 2 then
        renameFileWindow()
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
function createNewFileWindow()
    local W = 360; local H = 145
    local X = math.floor(screenWidth / 2 - W / 2 + 10)
    local Y = math.floor(screenHeight / 2 - H / 2 - 40)
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", X, Y, W, H, 10)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", X + 1, Y + 1, W - 2, H - 2, 10)
    -- Input Box
    drawButton(X + 25, Y + 20, 310, 50)
    love.graphics.setColor(colors.textWhite)
    love.graphics.print(tempText, ABZText, X + 50, Y + 30)
    local tW = ABZText:getWidth(tempText) + 3;
    local cX = X + 45 + tW;
    caretBlinking(cX, Y + 30)
    -- Create Button
    drawButton(X + 130, Y + 85, 100, 40)
    if errors.error1 or tempText == "" then
        love.graphics.setColor(colors.red)
        love.graphics.print("Create", ABZText, X + 143, Y + 88)
    else
        love.graphics.setColor(colors.white)
        love.graphics.print("Create", ABZText, X + 143, Y + 88)
    end
end

function createFile()
    if errors.error1 or tempText == "" then
        return
    end
    local filePath = "Lua Editor\\files\\" .. tempText
    local newFile = io.open(filePath, "w")
    if newFile then
        file = tempText
        newFile:close()
    end
    tempText = ""
    buttonClicked = 0
    mainMenuClicked = false
end

-- Rename an existing file
function renameFileWindow()
    local W = 360; local H = 145
    local X = math.floor(screenWidth / 2 - W / 2 + 10)
    local Y = math.floor(screenHeight / 2 - H / 2 - 40)
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", X, Y, W, H, 10)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", X + 1, Y + 1, W - 2, H - 2, 10)
    -- Input Box
    drawButton(X + 25, Y + 20, 310, 50)
    love.graphics.setColor(colors.textWhite)
    love.graphics.print(tempText, ABZText, X + 50, Y + 30)
    local tW = ABZText:getWidth(tempText) + 3;
    local cX = X + 45 + tW;
    caretBlinking(cX, Y + 30)
    -- Rename button
    drawButton(X + 125, Y + 85, 110, 40)
    if errors.error2 or tempText == "" then
        love.graphics.setColor(colors.red)
        love.graphics.print("Rename", ABZText, X + 135, Y + 88)
    else
        love.graphics.setColor(colors.white)
        love.graphics.print("Rename", ABZText, X + 135, Y + 88)
    end
    -- Rename file
    -- Check if rename button is clicked in mouse function, if it is then rename there
end

function renameFile()
    if errors.error2 or tempText == "" then
        return
    end
    local old_file = "Lua Editor\\files\\" .. file
    local new_file = "Lua Editor\\files\\" .. tempText
    local success = os.rename(old_file, new_file)
    if success then
        file = tempText
    end
    tempText = ""
    buttonClicked = 0
    mainMenuClicked = false
end

-- Delete currently opened file
function deleteCurrFile()
    love.graphics.setColor(colors.red)
    love.graphics.print("Currently In Development", screenWidth / 2 - 150, screenHeight / 2)
end

-- Clear Entire Screen
function clearAllData()
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

-- save file
function saveDataToFile()
    local txt = "Write data to file?"
    local txtW = ABZText:getWidth(txt) -- 209
    local saveWinH = 170;
    local saveWinW = txtW + 150
    local saveWinX = math.floor(screenWidth / 2 - saveWinW / 2 + 10)
    local saveWinY = math.floor(screenHeight / 2 - saveWinH / 2 - 40)
    -- Draw save window
    if not saveToFileBool then
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
        local No_BtnX = saveWinX + 200; local No_BtnY = saveWinY + saveWinH - 90
        local No_BtnW = 100; local No_BtnH = 50
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", No_BtnX, No_BtnY, No_BtnW, No_BtnH, 5)
        love.graphics.setColor(colors.lightBlack2)
        love.graphics.rectangle("fill", No_BtnX + 1, No_BtnY + 1, No_BtnW - 2, No_BtnH - 2, 5)
        love.graphics.setColor(colors.white)
        love.graphics.print("No", ABZText, No_BtnX + No_BtnW / 3, No_BtnY + No_BtnH / 5)
    end
    -- Save data to file if user clicked yes
    if saveToFileBool then
        local path = "Lua Editor\\files\\" .. file
        currentFile = io.open(path, "w")
        if currentFile then
            local data = table.concat(lines)
            currentFile:write(data)
            currentFile:close()
            buttonClicked = 0
            saveToFileBool = false
            mainMenuClicked = false
        end
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

-- Love2D file get Info does not checks for case sensitivity so when renaming a file use different name