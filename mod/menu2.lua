--[[ Explorer Games | menu2.lua
     Criado por Adrian75556435
     Objetivo: Substituir o Mastermods com qualidade superior
     Meta: ~2000 linhas organizadas e funcionais
--]]

-- 🧠 Função para verificar se o ScreenGui já existe
local function getExistingModMenu()
    return game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Mod_Explorer")
end

-- 🧱 Função para criar o Mod_Explorer se ele não existir
local function createModExplorerGui()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local existing = playerGui:FindFirstChild("Mod_Explorer")
    if existing then return existing end

    local modGui = Instance.new("ScreenGui")
    modGui.Name = "Mod_Explorer"
    modGui.ResetOnSpawn = false
    modGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    modGui.IgnoreGuiInset = false
    modGui.Parent = playerGui

    return modGui
end

-- 🔧 Função para montar a URL base da API do GitHub
local function buildGitHubUrl(user, repo, filePath)
    return "https://api.github.com/repos/" .. user .. "/" .. repo .. "/contents/" .. filePath
end

-- 📂 Função para montar a URL RAW (direta) do GitHub
local function buildRawGitHubUrl(user, repo, filePath)
    return "https://raw.githubusercontent.com/" .. user .. "/" .. repo .. "/main/" .. filePath
end

-- 📦 Função para carregar os caminhos dos scripts do GitHub
local function loadScriptsFromGitHub()
    local GITHUB_USER = "AdrainRazini"
    local GITHUB_REPO = "explorer_games"

    return {
        githubUser = GITHUB_USER,
        githubRepo = GITHUB_REPO,
        urls = {
            scriptsFolder = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "script"),
            loadScript = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "functions/load.lua"),
            modScript = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "mod/menu.lua"),
            modRaw = buildRawGitHubUrl(GITHUB_USER, GITHUB_REPO, "mod/menu.lua")
        }
    }
end

-- 🔔 Alerta dentro do GUI principal (Mod_Explorer)
local function showAlertInMenu(menuGui, text, duration)
    if not menuGui then return end

    local alertFrame = Instance.new("Frame")
    alertFrame.Size = UDim2.new(0, 280, 0, 50)
    alertFrame.Position = UDim2.new(0.5, -140, 1, -60)
    alertFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    alertFrame.BackgroundTransparency = 0.15
    alertFrame.BorderSizePixel = 0
    alertFrame.AnchorPoint = Vector2.new(0.5, 1)
    alertFrame.Name = "LocalAlert"
    alertFrame.ZIndex = 999
    alertFrame.Parent = menuGui

    local corner = Instance.new("UICorner", alertFrame)
    corner.CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", alertFrame)
    label.Size = UDim2.new(1, -20, 1, -10)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 17
    label.TextWrapped = true
    label.ZIndex = 1000

    -- Fade e destruição depois de um tempo
    task.delay(duration or 3, function()
        for i = 1, 10 do
            alertFrame.BackgroundTransparency += 0.05
            label.TextTransparency += 0.05
            task.wait(0.04)
        end
        alertFrame:Destroy()
    end)
end

-- 🚀 Função principal de inicialização do Mod Menu
local function initializeModMenu()
    local existingGui = getExistingModMenu()
    if existingGui then
        showAlertInMenu(existingGui, "Mod Menu já carregado!", 3)
        return
    end

    local scripts = loadScriptsFromGitHub()

    -- 🔧 Criar o Mod_Explorer se ainda não existir
    local menuGui = createModExplorerGui()

    -- ✅ Alerta de confirmação
    showAlertInMenu(menuGui, "Ghost ativado com sucesso!", 3)

    -- 🔽 Aqui você pode carregar o menu completo se quiser
    -- loadstring(game:HttpGet(scripts.urls.modRaw))()
end

-- 🟢 Iniciar
initializeModMenu()
