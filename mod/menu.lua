-- Verificar se já existe um ScreenGui com o nome "ModMenu"
local existingScreenGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Mod_Explorer")
if existingScreenGui then return end

-- URL da API do GitHub para listar os scripts
local GITHUB_USER = "AdrainRazini"
local GITHUB_REPO = "explorer_games"

local GITHUB_MOD_MENU = "mod/menu.lua"
local GITHUB_LOAD_MENU = "functions/load.lua"

-- Montagem das URLs da API do GitHub
local SCRIPTS_FOLDER_URL = "https://api.github.com/repos/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/contents/script"
local SCRIPTS_LOAD_URL = "https://api.github.com/repos/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/contents/" .. GITHUB_LOAD_MENU
local SCRIPTS_MOD_URL = "https://api.github.com/repos/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/contents/" .. GITHUB_MOD_MENU
