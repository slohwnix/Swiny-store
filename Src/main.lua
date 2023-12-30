local p = require('paxolib')

function run()
    local window = p.window("App Store")
    window:setWidth(300)
    window:setHeight(400)

    local HttpClient = p.HttpClient

    local function downloadApp(appName)
        local appURL = "https://github.com/slohwnix/Swiny-store/tree/main/Paxo/" .. appName
        HttpClient.get(appURL, function(response)
            if response.status == 200 then
                -- Traiter la rÃ©ponse (peut-Ãªtre sauvegarder le contenu tÃ©lÃ©chargÃ©, etc.)
                print("TÃ©lÃ©chargement de l'application " .. appName)
            else
                print("Erreur lors du tÃ©lÃ©chargement de l'application " .. appName)
            end
        end)
    end

    local function handleResponse(response)
        if response.status == 200 then
            local appsList = response.body

            -- SÃ©paration des applications individuelles
            local apps = {}
            for app in appsList:gmatch("[^\r\n]+") do
                table.insert(apps, app)
            end

            -- CrÃ©er des boutons pour chaque application
            local y = 50
            for i, appName in ipairs(apps) do
                local button = p.button(window, 50, y, 200, 30)
                button:setText(appName)

                -- Associer une action au clic du bouton pour tÃ©lÃ©charger l'application
                button:onClick(function()
                    downloadApp(appName)
                end)

                y = y + 40 -- Espacement vertical entre les boutons
            end
        else
            print("Erreur lors de la rÃ©cupÃ©ration de la liste des applications")
        end
    end

    -- RÃ©cupÃ©rer le contenu du fichier AppsList.txt depuis son URL
    HttpClient.get("https://raw.githubusercontent.com/slohwnix/Swiny-store/main/Paxo/AppsList.txt", handleResponse)
end