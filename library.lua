local MyLibrary = {}

function MyLibrary:MakeWindow(options)
    local self = {}
    self.Name = options.Name or "My Custom GUI"

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MyGui"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- **Smaller GUI (250x350)**
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- **Draggable GUI (Mobile & PC)**
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
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

    MainFrame.InputChanged:Connect(function(input)
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

    -- **Scroll Frame**
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ScrollBarThickness = 4
    ScrollFrame.Parent = MainFrame

    -- **Tabs**
    function self:MakeTab(tabOptions)
        local tab = {}

        function tab:AddButton(options)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Text = options.Name
            Button.Parent = ScrollFrame

            Button.MouseButton1Click:Connect(options.Callback)

            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 35)
        end

        function tab:AddToggle(options)
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1, -10, 0, 30)
            Toggle.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Toggle.Text = options.Name
            Toggle.Parent = ScrollFrame

            local toggled = false
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                Toggle.Text = options.Name .. (toggled and " [ON]" or " [OFF]")
                options.Callback(toggled)
            end)

            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 35)
        end

        function tab:AddSlider(options)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -10, 0, 30)
            SliderFrame.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderFrame.Parent = ScrollFrame

            local Slider = Instance.new("TextButton")
            Slider.Size = UDim2.new(0, 100, 1, 0)
            Slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Slider.Text = options.Name .. ": " .. options.Default
            Slider.Parent = SliderFrame

            Slider.MouseButton1Click:Connect(function()
                local value = math.random(options.Min, options.Max)
                Slider.Text = options.Name .. ": " .. value
                options.Callback(value)
            end)

            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 35)
        end

        function tab:AddDropdown(options)
            local Dropdown = Instance.new("TextButton")
            Dropdown.Size = UDim2.new(1, -10, 0, 30)
            Dropdown.Position = UDim2.new(0, 5, 0, ScrollFrame.CanvasSize.Y.Offset)
            Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Dropdown.Text = options.Name
            Dropdown.Parent = ScrollFrame

            local selected = options.Options[1]
            Dropdown.MouseButton1Click:Connect(function()
                selected = options.Options[math.random(1, #options.Options)]
                Dropdown.Text = options.Name .. ": " .. selected
                options.Callback(selected)
            end)

            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollFrame.CanvasSize.Y.Offset + 35)
        end

        return tab
    end

    return self
end

function MyLibrary:Init()
    print("Library Loaded!")
end

return MyLibrary
