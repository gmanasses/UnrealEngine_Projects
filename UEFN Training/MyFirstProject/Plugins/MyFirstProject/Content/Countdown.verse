using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }


Countdown := class(creative_device):

    # Vars
    @editable
    AddTimeToCounter : button_device = button_device{}

    @editable
    EndGame : end_game_device = end_game_device{}

    var CountdownTimer : Timer = Timer{}
    InitialCountdownTime : float = 20.0

    
    # Core Functions
    OnBegin<override>()<suspends> : void =
        Print("CountDown was Activated.")

        if:
            FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
            PlayerUI := GetPlayerUI[player[FirstPlayer]]
        then:
            set CountdownTimer = Timer{TimerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}
            CountdownTimer.StartCountdown()
        else:
            Print("Can't find player")



Timer := class:
    TimerUI : ?player_ui = false
    var Canvas : canvas = canvas{}
    var RemainingTime : float = 0.0
    RemainingTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White}
    RemainingTimeText<localizes>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"

    block:
        set Canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.5, Y := 0.05}
                        Maximum := vector2{X := 0.5, Y := 0.05}
                    Alignment := vector2{X := 0.5, Y := 0.0}
                    Offsets := margin{Top := 0.0, Left := 0.0, Bottom := 0.0, Right := 0.0}
                    SizeToContent := true
                    Widget := RemainingTimeWidget


    StartCountdown() : void =
        Print("Starting countdown")
    
        if (PlayerUI := TimerUI?):
            PlayerUI.AddWidget(Canvas)
            UpdateUI()

            
    UpdateUI() : void =
        if (IntTime := Int[RemainingTime]):
            RemainingTimeWidget.SetText(RemainingTimeText(IntTime))