local p = require('paxolib')

function run()
    local window = p.window("App Store")
    window:setWidth(300)
    window:setHeight(400)

    local HttpClient = p.HttpClient

    local function handleResponse(response)
        if response.status == 200 then
            local appsList = response.body

            -- Séparation des applications individuelles
            local apps = {}
            for app in appsList:gmatch("[^\r\n]+") do
                table.insert(apps, app)
            end

            -- Créer des boutons pour chaque application
            local y = 50
            for i, appName in ipairs(apps) do
                local button = p.button(window, 50, y, 200, 30)
                button:setText(appName)

                -- Associer une action au clic du bouton
                button:onClick(function()
                    -- Télécharger l'application correspondante
                    -- Utiliser HttpClient pour effectuer la requête de téléchargement
                    -- (Code de téléchargement ici)
                    print("Téléchargement de l'application " .. appName)
                end)

                y = y + 40 -- Espacement vertical entre les boutons
            end
        else
            print("Erreur lors de la récupération de la liste des applications")
        end
    end

    -- Récupérer le contenu du fichier AppsList.txt depuis son URL
    HttpClient.get("https://raw.githubusercontent.com/slohwnix/Swiny-store/main/Paxo/AppsList.txt", handleResponse)
end
