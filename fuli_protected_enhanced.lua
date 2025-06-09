-- Fuli Hub - Modo Protegido Mejorado
-- Protección Anti-Kick, Anti-Ban, Notificación de inicio

-- 🛡️ Protecciones Básicas
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then
        return warn("[FULI HUB PROTECTED] Intento de Kick bloqueado.")
    end
    return old(self, ...)
end)

game:GetService("Players").LocalPlayer.Kick = function()
    warn("[FULI HUB PROTECTED] Se bloqueó un intento de Kick manual.")
end

for _, func in pairs(getgc(true)) do
    if typeof(func) == "function" and islclosure(func) and not isexecutorclosure(func) then
        local info = debug.getinfo(func)
        if info.name == "FireServer" or info.name == "InvokeServer" then
            hookfunction(func, function(...)
                warn("[FULI HUB PROTECTED] Remote sospechoso bloqueado.")
                return nil
            end)
        end
    end
end

-- 📢 Notificación de Modo Activado
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "FULI HUB 🛡️",
    Text = "Modo PROTEGIDO activado correctamente.",
    Duration = 6
})

-- Cargar script GUI completo
loadstring(game:HttpGet("https://raw.githubusercontent.com/fuliscripts/UPD-The-Rake-REMASTERADO/refs/heads/main/fuliscripts_rake_gui_exploit.lua"))()
