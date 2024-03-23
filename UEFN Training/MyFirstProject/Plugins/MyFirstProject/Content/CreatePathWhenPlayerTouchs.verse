using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

CreatePathWhenPlayerTouchs := class(creative_device):

    @editable
    StartHidden : logic = false

    @editable             
    Path: color_changing_tiles_device = color_changing_tiles_device{}
    
    @editable
    NextPath: color_changing_tiles_device = color_changing_tiles_device{}

    var Subscriptions: []cancelable = array{}


    OnBegin<override>()<suspends>:void=
        StartCondition(StartHidden)
        PathSubscription := Path.ActivatedEvent.Subscribe(OnPlayerTouch)

        if:
            set Subscriptions[0] = PathSubscription
        

    OnPlayerTouch(InPlayer : agent) : void =
        ActivateNextPath()
        Path.Reset()
        
        if:
            Subscription := Subscriptions[0]
            Subscription.Cancel()


    StartCondition(Hidden : logic) : void =
        if(Hidden?):
            Path.Hide()

        else:
            Path.Show()


    ActivateNextPath() : void = 
        NextPath.Show()