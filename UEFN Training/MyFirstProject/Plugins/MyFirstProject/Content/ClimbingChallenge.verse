using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

log_platform_series := class(log_channel){}

ClimbingChallenge := class(creative_device):
    Logger : log = log{Channel := log_platform_series}

    @editable
    DelayBeforeStartDesappearing : float = 2.45

    @editable
    DelayToShowNextPlat : float = 0.98

    @editable
    DelayToDisappearPreviousPlat : float = 1.11

    @editable             
    Platforms : []color_changing_tiles_device = array{}


    OnBegin<override>()<suspends> : void =
        StartAllHidden()

        loop:
            sync:
                ShowAllPlatformsWithDelay(DelayToShowNextPlat)
                block:
                    Sleep(DelayBeforeStartDesappearing)
                    HideAllPlatformsWithDelay(DelayToDisappearPreviousPlat)


    StartAllHidden() : void =
        for (PlatformNumber -> Platform : Platforms):
            Platform.Hide()

    HideAllPlatformsWithDelay(DelayToHide : float)<suspends>  : void =
        for (PlatformNumber -> Platform : Platforms):
            Logger.Print("Platform{PlatformNumber} is now hidden.") 
            Platform.Hide()
            Sleep(DelayToHide)


    ShowAllPlatformsWithDelay(DelayToShow : float)<suspends>  : void =
        for (PlatformNumber -> Platform : Platforms):
            Logger.Print("Platform{PlatformNumber} is now shown.")
            Platform.Show()
            Sleep(DelayToShow)