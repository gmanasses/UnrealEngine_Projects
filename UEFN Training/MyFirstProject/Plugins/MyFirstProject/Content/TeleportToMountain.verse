using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


TeleportToMountain := class(creative_device):

    @editable
    Teleporter1 : teleporter_device = teleporter_device{}

    @editable
    Teleporter2 : teleporter_device = teleporter_device{}


    OnBegin<override>()<suspends>:void=
        Print("sdas")