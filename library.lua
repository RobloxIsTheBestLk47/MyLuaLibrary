local MyLibrary = {}

function MyLibrary:MakeWindow(options)
    local self = {}
    self.Name = options.Name or "My Custom GUI"

    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MyGui"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    -- UI Corner (Rounded Edges)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Title Bar (Draggable)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.Text = self.Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = MainFrame

    -- Dragging Function
    local dragging, dragInput, dragStart, startPos
    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Scroll Frame for Content
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.Parent = MainFrame

    function self:MakeTab(tabOptions)
        local tab = {}
        tab.Name = tabOptions.Name or "Tab"

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = tab.Name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Parent = ScrollFrame

        function tab:AddButton(buttonOptions)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.Text = buttonOptions.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.SourceSansBold
            btn.Parent = ScrollFrame

            btn.MouseButton1Click:Connect(function()
                buttonOptions.Callback()
            end)

            -- Update Scroll Frame Size
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 40)
        end

        function tab:AddToggle(toggleOptions)
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1, -10, 0, 35)
            Toggle.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Toggle.Text = toggleOptions.Name .. " [OFF]"
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.Font = Enum.Font.SourceSansBold
            Toggle.Parent = ScrollFrame

            local state = false
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = toggleOptions.Name .. (state and " [ON]" or " [OFF]")
                toggleOptions.Callback(state)
            end)

            -- Update Scroll Frame Size
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 40)
        end

        return tab
    end

    return self
end

function MyLibrary:Init()
    print("Library Initialized!")
end

return MyLibrary
