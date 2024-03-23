using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


AcornSpawner := class(creative_device):
    
    # VARS
    @editable
    DeskButton:button_device = button_device{}

    @editable
    ItemSpawner:item_spawner_device = item_spawner_device{}

    var Subscriptions: []cancelable = array{}


    # Core Functions
    OnBegin<override>()<suspends> : void =
        ButtonSubscription := DeskButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)
        
        if:
            set Subscriptions[0] = ButtonSubscription


    OnButtonInteractedWith(InAgent:agent) : void =
        ItemSpawner.SpawnItem()

        if:
            ButtonSubscription := Subscriptions[0]
            ButtonSubscription.Cancel()