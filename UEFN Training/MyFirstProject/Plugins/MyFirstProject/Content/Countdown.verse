using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }


Countdown := class(creative_device):

    # Vars
    @editable
    AddTimeButton : button_device = button_device{}
    StartTimerText<localizes>:message = "Start Countdown Timer"
    AddTimeText<localizes>:message = "Add More Time"
    
    @editable
    InitialCountdownTime : int = 20
    
    @editable
    TimeToAddOnClick : int = 10
    
    @editable
    TimeShowingAddedTime : float = 1.0
    
    var CountdownTimer : Timer = Timer{}
    var PlayerAlreadyStartedCountdown : logic = false

    
    # Core Functions
    OnBegin<override>()<suspends> : void =
        AddTimeButton.SetInteractionText(StartTimerText)
        ButtonSubscription := AddTimeButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)


    OnButtonInteractedWith(InAgent:agent) : void =
        if (PlayerAlreadyStartedCountdown?):
            CountdownTimer.AddTime(TimeToAddOnClick, TimeShowingAddedTime)

        else:
            set PlayerAlreadyStartedCountdown = true
            AddTimeButton.SetInteractionText(AddTimeText)
            
            if:
                FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
                PlayerUI := GetPlayerUI[player[FirstPlayer]]

            then:
                set CountdownTimer = Timer{TimerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}
                CountdownTimer.StartCountdown(AddTimeButton, StartTimerText)
                CountdownTimer.SetInitialTime(InitialCountdownTime)

            else:
                Print("Can't find player")



Timer := class<concrete>:
    TimerUI : ?player_ui = false
    var Canvas : canvas = canvas{}
    var RemainingTime : int = 0
    var InitialTime : int = 0
    TimerTickPeriod : float = 1.0 
    RemainingTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White}
    RemainingTimeText<localizes>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"
    AddTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White} 
    AddTimeText<localizes>(AddedTime : int) : message = "+ {AddedTime}!"

    block:
        set Canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.5, Y := 0.05}
                        Maximum := vector2{X := 0.5, Y := 0.05}
                    Alignment := vector2{X := 0.5, Y := 0.0}
                    Offsets := margin{Top := 25.0, Left := 0.0, Bottom := 0.0, Right := 0.0}
                    SizeToContent := true
                    Widget := RemainingTimeWidget
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.5, Y := 0.05}
                        Maximum := vector2{X := 0.5, Y := 0.05}
                    Alignment := vector2{X := 0.5, Y := 0.0}
                    Offsets := margin{Top := 0.0, Left := 50.0, Bottom := 0.0, Right := 0.0}
                    SizeToContent := true
                    Widget := AddTimeWidget


    SetInitialTime(Initial : int) : void = 
        set InitialTime = Initial


    ResetTimer(Button : button_device, ButtonText : message) : void = 
        set RemainingTime = InitialTime
        Button.SetInteractionText(ButtonText)


    StartCountdown(Button : button_device, ButtonText : message) : void =    
        if (PlayerUI := TimerUI?):
            PlayerUI.AddWidget(Canvas)
            UpdateUI()
            spawn:
                RunCountdown(Button, ButtonText)


    RunCountdown(Button : button_device, ButtonText : message)<suspends> : void =
        loop:
            Sleep(TimerTickPeriod)
            if: 
                var ConversionNum : int = Floor[TimerTickPeriod]
                set RemainingTime -= ConversionNum
    
            UpdateUI()
    
            if (RemainingTime <= 0):
                if (PlayerUI := TimerUI?):
                    RemainingTimeWidget.SetVisibility(widget_visibility.Hidden)
                    ResetTimer(Button, ButtonText)
                break


    AddTime(TimeToAdd : int, TimeShowingUI: float) : void =
        set RemainingTime += TimeToAdd
        UpdateUI()

        spawn:
            ShowAddTimeUI(TimeShowingUI, TimeToAdd)


    ShowAddTimeUI(TimeShowingText : float, TextTimeAdded : int)<suspends> : void =
        if:
            PlayerUI := TimerUI?
        then:
            AddTimeWidget.SetVisibility(widget_visibility.Visible)
            AddTimeWidget.SetText(AddTimeText(TextTimeAdded))
            Sleep(TimeShowingText)
            AddTimeWidget.SetVisibility(widget_visibility.Hidden)


    UpdateUI() : void =
        RemainingTimeWidget.SetText(RemainingTimeText(RemainingTime))