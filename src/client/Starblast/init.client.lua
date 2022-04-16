----DEBUGGER----
----CONFIGURATION----


----====----====----====----====----====----====----====----====----====----====


----SERVICES----
local REPLICATED_STORAGE = game:GetService("ReplicatedStorage")
-- local RUN_SERVICE = game:GetService("RunService")

----DIRECTORIES----
-- local RunService = game:GetService("RunService")
local LOCAL_PLAYER = game:GetService("Players").LocalPlayer
-- local PLAYER_GUI = LOCAL_PLAYER:WaitForChild("PlayerGui")
local PLAYER_SCRIPTS = LOCAL_PLAYER:WaitForChild("PlayerScripts")
local TACTICAL_LIQUID = REPLICATED_STORAGE:WaitForChild("TacticalLiquid")

----INTERNAL CLASSES----

----EXTERNAL CLASSES----
-- local CLASSES = REPLICATED_STORAGE.Classes

----INTERNAL MODULES----
local weaponsPanel = require(script.WeaponsPanel)
local viewmodelPanel = require(script.ViewmodelPanel)

----EXTERNAL MODULES----
local inputPanel = require(PLAYER_SCRIPTS.TacticalLiquidClient.InputPanel)

local spring = require(TACTICAL_LIQUID.Modules.Spring)

----LIBRARIES----
local UTILITY = require(REPLICATED_STORAGE.Libraries.Utility)



----====----====----====----====----====----====----====----====----====----====


----VARIABLES----
spring.new("cameraRecoil", 5, 50, 4, 4)
local character = LOCAL_PLAYER.Character
LOCAL_PLAYER.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
end)
local camera = workspace.CurrentCamera

local equipped = false
local viewmodels = {}
local firing = false
-- local reloading = false

local mouseButton1 = inputPanel.newInputListener(Enum.UserInputType.MouseButton1, true)
local num1 = inputPanel.newInputListener(Enum.KeyCode.One, false)

----FUNCTIONS----
local function fire(_, keyDown)
    if not character then
        firing = false
        return
    end
    firing = keyDown
    if firing then
        -- local cycle = 0
        -- local yep
        -- yep = RunService.RenderStepped:Connect(function(deltaTime)
        --     cycle = cycle + deltaTime
        --     if not firing then
        --         yep:Disconnect()
        --     end
        --     if cycle > 0.1 then
        --         cycle -= 0.1
                
        --         local endPosition = camera.CFrame.Position
        --         if equipped then
        --             endPosition = viewmodels["crappy viewmodel 2"].Viewmodel.Handle.GunFirePoint.WorldPosition
        --         end
        --         weaponsPanel.fire(endPosition, camera.CFrame.LookVector, 512)
        --         UTILITY.clonePlay(workspace:FindFirstChild("FireSound"), workspace)
        --     end
        -- end)
        repeat
            local endPosition = camera.CFrame.Position
            if equipped then
                endPosition = viewmodels["crappy viewmodel 2"].Viewmodel.Handle.GunFirePoint.WorldPosition
            end
            weaponsPanel.fire(endPosition, camera.CFrame.LookVector, 512)
            UTILITY.clonePlay(workspace:FindFirstChild("FireSound"), workspace)
            task.wait(0.1)
        until not firing
    end
end

local function equip(_, keyDown)
    if not character then return end
    if not keyDown then return end
    if equipped then
        equipped = false
        viewmodelPanel.clearActiveViewmodel()
        return
    end
    equipped = true
    if not viewmodels["crappy viewmodel 2"] then
        local something = viewmodelPanel.createViewmodel(TACTICAL_LIQUID:FindFirstChild("crappy viewmodel 2"), "crappy viewmodel 2")
        viewmodels["crappy viewmodel 2"] = something
        print(something)
        print(viewmodels["crappy viewmodel 2"])
    end
    viewmodelPanel.setViewmodel(viewmodels["crappy viewmodel 2"])
end

----CONNECTED FUNCTIONS----
mouseButton1.inputChanged:Connect(fire)
num1.inputChanged:Connect(equip)
