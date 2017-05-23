require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "utilisateur", "mdp")


---------------------------------- FUNCTIONS ----------------------------------

-- Fonction : Récupère le nom du travail
-- Paramètre(s) : id = ID du travail
function nameJob(id)
  local executed_query = MySQL:executeQuery("SELECT job_name FROM jobs WHERE job_id = '@namejob'", {['@namejob'] = id})
  local result = MySQL:getResults(executed_query, {'job_name'}, "job_id")
  return result[1].job_name
end

-- Fonction : Récupère le travail du joueur
-- Paramètre(s) : player = Identifiant du joueur
function whereIsJob(player)
  local executed_query = MySQL:executeQuery("SELECT job FROM users WHERE identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job'}, "job")
  return result[1].job
end

-- Fonction : Mets à jour le travail du joueur
-- Paramètre(s) : player = Identifiant du joueur, id = ID du travail
function updatejob(player, id)
  local job = id
  MySQL:executeQuery("UPDATE users SET `job`='@value' WHERE identifier = '@identifier'", {['@value'] = job, ['@identifier'] = player})
end

---------------------------------- EVENEMENT ----------------------------------

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.identifier
        local nameJob = nameJob(id)
        updatejob(player, id)
        TriggerClientEvent("jobssystem:updateJob", source, nameJob)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Votre métier est maintenant : ".. nameJob)
        -- ENGLISH VERSION : TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_STRIPCLUB_PR", 1, "Job", false, "Your Job is now : ".. nameJob)
  end)
end)

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local WIJ = whereIsJob(player)
      local nameJob = nameJob(WIJ)
      TriggerClientEvent("jobssystem:updateJob", source, nameJob)
    end)
end)

