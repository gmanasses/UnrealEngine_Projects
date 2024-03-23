using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


ClimbingChallenge := class(creative_device):

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
            Platform.Hide()
            Sleep(DelayToHide)


    ShowAllPlatformsWithDelay(DelayToShow : float)<suspends>  : void =
        for (PlatformNumber -> Platform : Platforms):
            Platform.Show()
            Sleep(DelayToShow)