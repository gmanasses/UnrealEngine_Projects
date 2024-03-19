using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
 
log_on_off_platform := class(log_channel){}

MissingPlatform := class(creative_device):
    Logger : log = log{Channel := log_on_off_platform}

    @editable
    TimeToSwitchVisibility : float = 2.0

    @editable
    MissPlat : color_changing_tiles_device = color_changing_tiles_device{}


    OnBegin<override>()<suspends>:void=
        loop:
            Sleep(TimeToSwitchVisibility)
            MissPlat.Hide()
            Sleep(TimeToSwitchVisibility)
            MissPlat.Show()