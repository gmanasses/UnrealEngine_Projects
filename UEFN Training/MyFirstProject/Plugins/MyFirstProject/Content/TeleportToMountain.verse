using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }

TeleportToMountain := class(creative_device):

    @editable
    Teleporter1 : teleporter_device = teleporter_device{}
    
    @editable
    Billboard_TP1 : billboard_device = billboard_device{}
    Billboard_Message<localizes>:message = "Welcome to Floating Mountains!"

    @editable
    Teleporter2 : teleporter_device = teleporter_device{}

    @editable
    WildlifeSpawner_TP2 : wildlife_spawner_device = wildlife_spawner_device{}


    OnBegin<override>()<suspends>:void=
        Teleporter1.EnterEvent.Subscribe(EnteredTeleport1)
        Teleporter2.TeleportedEvent.Subscribe(TeleportedToTP2)
        WildlifeSpawner_TP2.SpawnedEvent.Subscribe(WhenWildlifeSpawns)


    EnteredTeleport1(Agent : agent) : void = 
        Print("Player entered on TP1")
        Billboard_TP1.SetText(Billboard_Message)


    TeleportedToTP2(Agent : agent) : void = 
        Print("Player teleported to TP2")
        WildlifeSpawner_TP2.Spawn()
        
    WhenWildlifeSpawns(Agent : agent) : void = 
        Print("WildLife was spawned")