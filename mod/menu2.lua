-- Função para verificar se o ScreenGui já existe
local function checkIfScreenGuiExists()
    local existingScreenGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Mod_Explorer")
    return existingScreenGui
end

-- Função para montar a URL base do GitHub
local function buildGitHubUrl(user, repo, filePath)
    return "https://api.github.com/repos/" .. user .. "/" .. repo .. "/contents/" .. filePath
end

-- Função para montar a URL raw do arquivo
local function buildRawGitHubUrl(user, repo, filePath)
    return "https://raw.githubusercontent.com/" .. user .. "/" .. repo .. "/main/" .. filePath
end

-- Função para carregar o menu de scripts do GitHub
local function loadScriptsFromGitHub()
    local GITHUB_USER = "AdrainRazini"
    local GITHUB_REPO = "explorer_games"

    -- Montando as URLs usando a função
    local SCRIPTS_FOLDER_URL = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "script")
    local SCRIPTS_LOAD_URL = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "functions/load.lua")
    local SCRIPTS_MOD_URL = buildGitHubUrl(GITHUB_USER, GITHUB_REPO, "mod/menu.lua")
    local RAW_MOD_URL = buildRawGitHubUrl(GITHUB_USER, GITHUB_REPO, "mod/menu.lua")
    
    -- Aqui você pode adicionar mais lógicas para processar ou carregar os scripts
    return {
        scriptsFolderUrl = SCRIPTS_FOLDER_URL,
        loadScriptUrl = SCRIPTS_LOAD_URL,
        modScriptUrl = SCRIPTS_MOD_URL,
        rawModScriptUrl = RAW_MOD_URL
    }
end

-- Função principal de inicialização do Mod Menu
local function initializeModMenu()
    -- Verificar se o ScreenGui já existe
    if checkIfScreenGuiExists() then
        print("Menu já carregado!")
        return
    end

    -- Carregar os URLs de scripts
    local scripts = loadScriptsFromGitHub()

    -- Aqui você pode fazer algo com os scripts, como carregar o menu
    print("Carregando Mod Menu...")
    -- Você pode usar as URLs de scripts aqui, como scripts.scriptsFolderUrl, scripts.loadScriptUrl, etc.
end

-- Chama a função para inicializar o Mod Menu
initializeModMenu()
