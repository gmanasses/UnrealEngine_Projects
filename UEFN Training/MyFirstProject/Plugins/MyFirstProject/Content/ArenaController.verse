using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


ArenaController := class(creative_device):

    @editable 
    GunSpawner : item_spawner_device = item_spawner_device{}

    @editable 
    GunButton : button_device = button_device{}

    @editable 
    ArenasDoor : barrier_device = barrier_device{}

    @editable 
    StartButton : button_device = button_device{}

    @editable 
    PlayerIdentifier : perception_trigger_device = perception_trigger_device{}

    @editable
    EnemySpawner : guard_spawner_device = guard_spawner_device{}


    OnBegin<override>()<suspends> : void =
        GunButton.InteractedWithEvent.Subscribe(SpawnRandomGun)
        StartButton.InteractedWithEvent.Subscribe(IdentifyStartMiniGame)


    SpawnRandomGun(Agent : agent) : void =
        GunSpawner.SpawnItem()


    IdentifyStartMiniGame(Agent : agent) : void =
        PlayerIdentifier.DeviceSeesAgentEvent.Subscribe(StartMiniGame)
        ArenasDoor.Disable()
        EnemySpawner.Enable()
        EnemySpawner.ForceAttackTarget(Agent)
        EnemySpawner.SpawnedEvent.Subscribe(teste)

    
    StartMiniGame(Agent : agent) : void =
        PlayerIdentifier.Disable()
        ArenasDoor.Enable()
        EnemySpawner.Spawn()
        
    teste(Agent : agent) : void =
        Print("asdasdas")