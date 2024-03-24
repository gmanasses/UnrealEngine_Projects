using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


ArenaController := class(creative_device):

    @editable GunSpawner : item_spawner_device = item_spawner_device{}
    @editable GunButton : button_device = button_device{}
    @editable ArenasDoor : barrier_device = barrier_device{}
    @editable StartButton : button_device = button_device{}
    

    OnBegin<override>()<suspends> : void =
        GunButton.InteractedWithEvent.Subscribe(SpawnRandomGun)
        StartButton.InteractedWithEvent.Subscribe(StartMiniGame)


    SpawnRandomGun(Agent : agent) : void = 
        GunSpawner.SpawnItem()


    StartMiniGame(Agent : agent) : void = 
        ArenasDoor.Disable()