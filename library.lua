local MyLibrary = {}

-- Create the main GUI
function MyLibrary:MakeWindow(options)
    local self = {}
    self.Name = options.Name or "My Custom GUI"

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MyGui"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Create Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    -- Create Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.Text = self.Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = MainFrame

    self.MainFrame = MainFrame

    -- Function to create Tabs
    function self:MakeTab(tabOptions)
        local tab = {}
        tab.Name = tabOptions.Name or "Tab"

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.Text = tab.Name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Parent = MainFrame

        function tab:AddButton(buttonOptions)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, #MainFrame:GetChildren() * 30)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.Text = buttonOptions.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Parent = MainFrame

            btn.MouseButton1Click:Connect(function()
                buttonOptions.Callback()
            end)
        end

        return tab
    end

    return self
end

function MyLibrary:Init()
    print("Library Initialized!")
end

return MyLibrary
