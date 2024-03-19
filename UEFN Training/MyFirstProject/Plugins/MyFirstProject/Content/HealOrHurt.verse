using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }


HealOrHurt := class(creative_device):

    @editable
    TriggerPlatform : trigger_device = trigger_device{}

    @editable
    HealAmount : float = 20.0

    @editable
    HurtAmount : float = 30.0


    OnBegin<override>()<suspends>:void=
        Print("HealOrHurt was Activated.")
        TriggerPlatform.TriggeredEvent.Subscribe(OnTriggered)


    OnTriggered(Agent : ?agent) : void =
        if:
            CharacterWhoTriggered := Agent?.GetFortCharacter[]

        then:
            maxNumberRandom : int = 40
            sortToAction : int = GetRandomInt(1, maxNumberRandom)

            if(sortToAction <= Int[maxNumberRandom * 0.5]):
                HealPlayer(HealAmount, CharacterWhoTriggered)

            else:
                HurtPlayer(HealAmount, CharacterWhoTriggered)


    HealPlayer(Amount : float, Character : fort_character ) : void =
        if (Character.GetHealth() < 100.0):
            Character.Heal(Amount)
        
        else:
            Print("Player dont need heal")
            

    HurtPlayer(Amount : float, Character : fort_character ) : void =
        if (Character.GetHealth() > 0.0):
            Character.Damage(Amount)