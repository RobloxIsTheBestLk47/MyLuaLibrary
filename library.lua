local MyLibrary = {}

function MyLibrary:MakeWindow(options)
    local self = {}
    self.Name = options.Name or "My Custom GUI"
    
    print("Created Window: " .. self.Name)

    function self:MakeTab(tabOptions)
        local tab = {}
        tab.Name = tabOptions.Name or "Tab"
        print("Created Tab: " .. tab.Name)

        function tab:AddButton(buttonOptions)
            print("Added Button: " .. buttonOptions.Name)
            buttonOptions.Callback()
        end

        return tab
    end

    return self
end

function MyLibrary:Init()
    print("Library Initialized!")
end

return MyLibrary
