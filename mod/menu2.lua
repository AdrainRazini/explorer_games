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

-- 🔔 Alerta no canto inferior direito do Mod_Explorer - Empilhamento
local activeAlerts = {}

local function showAlertInMenu(menuGui, text, duration)
	if not menuGui then return end

	-- Cria o frame do alerta
	local alertFrame = Instance.new("Frame")
	alertFrame.Size = UDim2.new(0, 280, 0, 50)
	alertFrame.Position = UDim2.new(1, -300, 1, -60 - (#activeAlerts * 60)) -- canto inferior direito
	alertFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	alertFrame.BackgroundTransparency = 0.15
	alertFrame.BorderSizePixel = 0
	alertFrame.AnchorPoint = Vector2.new(0, 1) -- âncora no canto inferior esquerdo do alerta
	alertFrame.Name = "LocalAlert"
	alertFrame.ZIndex = 999
	alertFrame.Parent = menuGui

	table.insert(activeAlerts, alertFrame)

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

		-- Remove da lista e atualiza posições restantes
		for i, alert in ipairs(activeAlerts) do
			if alert == alertFrame then
				table.remove(activeAlerts, i)
				break
			end
		end

		for i, alert in ipairs(activeAlerts) do
			alert:TweenPosition(
				UDim2.new(1, -300, 1, -60 - ((i - 1) * 60)),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quad,
				0.25,
				true
			)
		end
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
	local menuGui = createModExplorerGui()

	showAlertInMenu(menuGui, "Menu ativado com sucesso!", 3)

	-- 🎛️ Criação do menu visual
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainMenu"
	mainFrame.Size = UDim2.new(0, 400, 0, 300)
	mainFrame.Position = UDim2.new(0.5, -200, 0.4, -150)
	mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	mainFrame.BorderSizePixel = 0
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.Parent = menuGui

	local corner = Instance.new("UICorner", mainFrame)
	corner.CornerRadius = UDim.new(0, 8)

	-- 🔻 Botão de Minimizar
	local minimizeBtn = Instance.new("TextButton")
	minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
	minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
	minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	minimizeBtn.Text = "-"
	minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeBtn.Font = Enum.Font.GothamBold
	minimizeBtn.TextSize = 18
	minimizeBtn.Parent = mainFrame

	local corner2 = Instance.new("UICorner", minimizeBtn)
	corner2.CornerRadius = UDim.new(0, 6)

	-- 🧾 Título
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -40, 0, 30)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "Explorer Games Menu"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = mainFrame

	-- 🌀 ScrollFrame para conteúdo interno
	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -20, 1, -40)
	scroll.Position = UDim2.new(0, 10, 0, 35)
	scroll.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 6
	scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.Parent = mainFrame

	local scrollCorner = Instance.new("UICorner", scroll)
	scrollCorner.CornerRadius = UDim.new(0, 6)

	-- 🌐 Minimizar / Restaurar
	local minimized = false
	minimizeBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		scroll.Visible = not minimized
		title.Visible = not minimized
		mainFrame.Size = minimized and UDim2.new(0, 400, 0, 40) or UDim2.new(0, 400, 0, 300)
	end)

	-- (🔽) Carregar menu externo opcional
	-- loadstring(game:HttpGet(scripts.urls.modRaw))()
	local player = game.Players.LocalPlayer
	showAlertInMenu(menuGui, "Bem Vindo " ..player.Name  , 10)
	
end

-- 🟢 Iniciar
initializeModMenu()

