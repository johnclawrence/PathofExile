CurrFirstX:=150
CurrFirstY:=604
currWidth:=70
CurrX:=7
CurrY:=2

iAltX := 100
iAltY := 260
iAugX := 230
iAugY := 335

AltX := iAltX
AltY := iAltY
AugX := iAugX
AugY := iAugY
misscur :=0

useCooldownSleep(){
	;This is somewhere around your ping.
	;If you start to see "Item Unuseable" you need to increase this.
	Sleep 0
	}
checkRegexSleep(){
	;This number + useCooldownSleep needs to be about double your ping.
	Sleep 75
	}
wiggleSleep(){
	;This is the cooldown to wait the stuff on your cursor to stop moving
	Sleep 5
	}


initFunction(){
	global AltX
	global iAltX
	global AltY
	global iAltY
	global AugX
	global iAugX
	global AugY
	global iAugY
	AltX := iAltX
	AltY := iAltY
	AugX := iAugX
	AugY := iAugY
	global misscur
	misscur:=0
	Send {Ctrl Up}
	Send {Alt Up}
	Send {Shift Up}
	}
	
Trans() {
	TransX = 50
	TransY = 260
	MouseMove TransX,TransY,0
	return 0x325180
	}
	
Alteration() {
	global AltX
	global AltY
	MouseMove AltX,AltY,0
	return 0x439694
	}

Augmentation() {
    global AugX
    global AugY
    MouseMove AugX,AugY,0
    return 0x2F2F38
    }
	
Regal() {
	RegalX = 440
	RegalY = 270
	MouseMove RegalX,RegalY,0
	return 0x2A3447
	}

Alch() {
	AlchX = 490
	AlchY = 260
	MouseMove AlchX,AlchY,0
	return 0x7C6C50
	}

Scour() {
	ScourX = 435
	ScourY = 500
	MouseMove ScourX,ScourY,0
	return 0x646568
	}

Exalt() {
    ExaltX = 300
    ExaltY = 275
    MouseMove ExaltX,ExaltY,0
    return 0x463625
    }

Annul() {
    AnnulX = 164
    AnnulY = 260
    MouseMove AnnulX,AnnulY,0
    return 0x071547
    }

moveToCraft(){
	CraftX = 350
	CraftY = 450
	MouseMove CraftX,CraftY,0
	return
	}

harvestCraft(){
    harvestCraftX := 960
    harvestCraftY := 450
    MouseMove harvestCraftX,harvestCraftY,0
    }

RegexBar(){
	RegexX = 480
	RegexY = 895
	MouseMove RegexX,RegexY,0
	}
	
harvestRegex(){
    harvestRegexX := 500
    harvestRegexY := 815
    MouseMove harvestRegexX,harvestRegexY,0
    }
	
harvestButton(){
    harvestButtonX := 970
    harvestButtonY := 600
    MouseMove harvestButtonX,harvestButtonY,0
    }
    
harvestTop(){
    harvestTopX := 533
    harvestTopY := 300
    MouseMove harvestTopX,harvestTopY,0
    }

setRegex(regexVal,regexType){
	;RegexBar() RegexBar for normal harvestRegex for harvest
    %regexType%()
	MouseClick Left
	SendInput, ^a
	SendInput, %regexVal%
	}

Compare(c1, c2, vary=20) {
    rdiff := Abs( c1.r - c2.r )
    gdiff := Abs( c1.g - c2.g )
    bdiff := Abs( c1.b - c2.b )

    return rdiff > vary || gdiff > vary || bdiff > vary
    }

ToRGB(color) {
    return { "r": (color >> 16) & 0xFF, "g": (color >> 8) & 0xFF, "b": color & 0xFF }
    }

getItemClipboard(){
    checkRegexSleep()
    Clipboard=
	Send, ^c
    ClipWait , .1
    if ErrorLevel
        {
        Send, ^c
        ClipWait , .1
        }
	}

findCurrency(currency){
	;For Each slot
	Global CurrFirstX
	Global CurrFirstY
	Global currWidth
	
	curX := CurrFirstX
	curY := CurrFirstY
	countX=0
	countY=0
	Loop {
		if GetKeyState("Esc", "P")
			{
			break
			}
		if (countX = 7)
			break
		if (countY = 3)
			break
		MouseMove curX,curY,0
		;if there is something there...
		PixelGetColor Color,%curX%,%curY%,
		biColor := ToRGB(0x020202)
		miColor := ToRGB(Color)
		dColor := Compare(biColor,miColor)
		if (dColor){
			;What is it that's there?
			getItemClipboard()
			;Is it what I'm looking for?
			if (RegExMatch(Clipboard, currency)){
				if (currency = "Alteration"){
					;Set the glglobal if it is
					global AltX
					global AltY
					AltX := curX
					AltY := curY
					break
					}
				if (currency = "Augmentation"){
					;Set the glglobal if it is
					global AugX
					global AugY
					AugX := curX
					AugY := curY
					break
					}
				else {
					;if it's not alts or augs, you don't have more than 5k of it and are thus out.
					break
					}
                }
			}
        wiggleSleep()
		countY := countY + 1
		curY := curY + currWidth
		if (countY = 2)
			{
			countX := countX + 1
			countY := 0
			curY := CurrFirstY
			curX := curX + currWidth
			}
		}
		
	}


useCurrency(functionName) {
	global misscur
	curColor := %functionName%()
	fcLoop := 0
	Loop{
		fcLoop := fcLoop + 1
		if GetKeyState("Esc", "P")
			{
			break
			}
		%functionName%()
		MouseClick Right
		wiggleSleep()
		MouseGetPos, X,Y
		PixelGetColor Color,%X%,%Y%,RGB
        if (Color = curColor)
			{
			break
			}
        if (functionName = "Annul"){
            break
            }
		if (fcLoop = 25){
			findCurrency(functionName)
			}
		if (fcLoop > 30){
			misscur := functionName
			break
			}
		}
	moveToCraft()
	MouseClick Left
	useCooldownSleep()
    moveToCraft()
    return
	}


magicCheck(){
    if (RegExMatch(Clipboard,"Rarity: Normal")){
        useCurrency("Trans")
        }
    }
    if (RegExMatch(Clipboard,"Rarity: Rare")){
        global misscur
        if (misscur = 0){
            useCurrency("Scour")
            }
    }

getItemRegex(re1,re2){
    getItemClipboard()
    if (RegExMatch(Clipboard,re1)){
        if (re2=""){
            return 1
            }
        if(RegExMatch(Clipboard,re2)){
            return 1
            }
        }
    return 0
    }

altToRegex(Mode,blueRegex1,blueRegex2) 
	{
	;Mode 0 is Alt Check
	;Mode 1 is Alt Check Aug Check
	global misscur
    moveToCraft()
    getItemClipboard()
    magicCheck()
	Loop{
		if GetKeyState("Esc", "P"){
			break
			}
		if (misscur != 0){
			break
			}
            moveToCraft()
		;Loop Code
		if (getItemRegex(blueRegex1,blueRegex2)){
			if (Mode = 1){
				useCurrency("Augmentation")
				if (getItemRegex(blueRegex1,blueRegex2)){
					break
					}
				}
			if (Mode = 0){
				break
				}
			}
		else{
            useCurrency("Alteration")
            magicCheck()
			}
		}
	}

altAugRegalToRegex(Mode,blueRegex1,blueRegex2,rareRegex) 
	{
	;Mode 0: Alt Check Aug Regal Check 
	;Mode 1: Alt Check Aug Check Regal Check
	global misscur
	Loop
	{
		if GetKeyState("Esc", "P")
			{
            SplashTextOff
			break
			}
		if (misscur != 0){
            SplashTextOff
			break
			}
		;Loop Code
		if (Mode=0){
			altToRegex(0,blueRegex1,blueRegex2)
			useCurrency("Augmentation")
			}
		if (Mode=1){
			altToRegex(1,blueRegex1,blueRegex2)
			}
		useCurrency("Regal")
		getItemClipboard()
		result := %rareRegex%()
        if (result > 2){
            if (RegExMatch(Clipboard,"fractured")){
                ExaltAnnulToRegex(rareRegex)
                getItemClipboard()
                result := %rareRegex%()
                if (result > 3){
                    break
                    }
                }
            else
                {
                break
                }
            ;If the item is fractured, go for 4 mod. 
            }
        SplashTextOn, 400, 600, LastCluster, %Clipboard%`n Score: %result%
        WinMove, LastCluster,, 4800, 0
        useCurrency("Scour")
		}
    SplashTextOff
	}

ExaltAnnulToRegex(exRegex)
    {
    useCurrency("Exalt")
    getItemClipboard()
    result := %exRegex%()
    if (result < 4){
        useCurrency("Annul")
        }
    getItemClipboard()
    result := %exRegex%()
    if (result = 3){
        ExaltAnnulToRegex(exRegex)
        }
    }
craftHarvest(re1,score,harvRE){
    setRegex(harvRE,"harvestRegex")
    harvestTop()
    MouseClick Left
    loop{
        if GetKeyState("Esc", "P"){
            break
            }
        harvestButton()
        MouseClick Left
        harvestCraft()
        wiggleSleep()
        getItemClipboard()
        if (%re1%() = score){
            break
            }
        }
    }
MR384(){
    score = 0
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    MES := RegExMatch(itemModData,"(1[7-9]|20) to Maximum Energy Shield")
    ML := RegExMatch(itemModData,"1[3-6] to Maximum Life")
    Intro := RegExMatch(itemModData,"Introspection")
    Eff := RegExMatch(itemModData,"Effect")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")
    if (Eff>0){
        if (Intro>0){
            score = 3
            }
        if (MES + ML > 0){
            if (EffT1 > 0){
                score = 3
                }
            }
        }
    return score
    }

SD1284(){
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    MES := RegExMatch(itemModData,"([6-9]|1[0-2]) to Maximum Energy Shield")
    ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")
    AA := RegExMatch(itemModData,"[3-4] to All Attributes")
    StrT1 := RegExMatch(itemModData,"[6-8] to Strength")
    IntT1 := RegExMatch(itemModData,"[6-8] to Intelligence")
    Dam := RegExMatch(itemModData,"[3-4]% increased Damage")
    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    output = 0
    if (EffT1 >0){
        score:=score+1
        }
    if (AA > 0){
        score:=score+1
        }
    if  (MES+ML+Dam > 0){
        score:=score+1
        }
    if  (StrT1+IntT1 > 0){
        score:=score+1
        }
    if (StrT1 > 0) {
        if (MES > 0) {
            score:=score-1
            }
        }
    if (IntT1 > 0) {
        if (ML > 0) {
            score:=score-1
            }
        }
    return score
    }

MD1284(){
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    MES := RegExMatch(itemModData,"[6-9]|1[0-2]) to Maximum Energy Shield")
    ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")
    AERes := RegExMatch(itemModData,"[3-4]% to all Elemental Resistances")
    ChaosRes := RegExMatch(itemModData,"[4-5]% to Chaos Resistance")
    AtkSpedT1 :=  RegExMatch(itemModData,"Minions have 3% increased Attack and Cast Speed")
    vBite := RegExMatch(itemModData,"Vicious")

    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    output = 0
    if (EffT1 >0){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if  (MES+ML > 0){
        score:=score+1
        }
    if  (AERes+ChaosRes+vBite > 0){
        score:=score+1
        }
    return score
    }
    
BD1284(){
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    MES := RegExMatch(itemModData,"([6-9]|1[0-2]) to Maximum Energy Shield")
    ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")
    AERes := RegExMatch(itemModData,"[3-4]% to all Elemental Resistances")
    ChaosRes := RegExMatch(itemModData,"[4-5]% to Chaos Resistance")
    AtkSpedT1 :=  RegExMatch(itemModData,"3% increased Attack Speed")
    Dam := RegExMatch(itemModData,"[3-4]% increased Damage")
    StrT1 := RegExMatch(itemModData,"[6-8] to Strength")
    IntT1 := RegExMatch(itemModData,"[6-8] to Intelligence")
    DexT1 := RegExMatch(itemModData,"[6-8] to Dexterity")
    AA := RegExMatch(itemModData,"[3-4] to All Attributes")
    

    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    if (EffT1 >0){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if  (MES + ML + Dam > 0){
        score:=score+1
        }
    if  (AERes+ChaosRes+StrT1+IntT1+DexT1+AA > 0){
        score:=score+1
        }
    return score
    }
        
LD1284H(){
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    AtkSpedT1 :=  RegExMatch(itemModData,"3% increased Attack and Cast Speed with Lightning Skills")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")
    score=0
    output = 0
    if (EffT1 >0){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    return score
    }
        
LD1284(){
    itemArray := StrSplit(Clipboard,"--------")
    itemModData := itemArray[5]
    AtkSpedT1 :=  RegExMatch(itemModData,"3% increased Attack and Cast Speed with Lightning Skills")
    EffT1 := RegExMatch(itemModData,"35% increased Effect")

    MES := RegExMatch(itemModData,"([9]|1[0-2]) to Maximum Energy Shield")
    ML := RegExMatch(itemModData,"([8-9]|10) to Maximum Life")
    Dam := RegExMatch(itemModData,"[4]% increased Damage")

    AERes := RegExMatch(itemModData,"[3]% to all Elemental Resistances")
    ChaosRes := RegExMatch(itemModData,"[5]% to Chaos Resistance")
    StrT1 := RegExMatch(itemModData,"[6-8] to Strength")
    IntT1 := RegExMatch(itemModData,"[6-8] to Intelligence")
    AA := RegExMatch(itemModData,"[4] to All Attributes")
    
    score=0
    output = 0
    if (EffT1 >0){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if (MES+ML+Dam >0){
        score:=score+1
        }
    if (AERes+ChaosRes+StrT1+IntT1+AA >0){
        score:=score+1
        }
    return score
    }

Numpad1::
    initFunction()
    moveToCraft()
    getItemClipboard()
    if RegExMatch(Clipboard,"Item Level: [84-89]"){
        if RegExMatch(Clipboard,"Adds 12 Passive Skills"){
            if RegExMatch(Clipboard,"Minions deal 10% increased Damage"){
                altAugRegalToRegex(1,"m)Powerful|Glowing|Sanguine|^Lar","m)Eviction|zi|Kaleidoscope|jewel$","MD1284")
                }
            if RegExMatch(Clipboard,"10% increased Spell Damage"){
                altAugRegalToRegex(1,"m)Meteor|Bear|Prodigy|Jewel$","m)Powerful|Glowing|Sanguine|Dangerous|^Lar","SD1284")   
                }
            if RegExMatch(Clipboard,"12% increased Damage with Bows"){
                altAugRegalToRegex(1,"m)Powerful|Glowing|Sanguine|Dangerous|^Lar","m)Meteor|Bear|Prodigy|Eviction|Kaleidoscope|Fox|Mastery|Jewel$","BD1284")
                }
            }
        if RegExMatch(Clipboard,"Adds 3 Passive Skills"){
            if RegExMatch(Clipboard,"6% increased Mana Reservation Efficiency of Skills"){
                altAugRegalToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small","","MR384")
                }
            }
        }
    return

Numpad2::
    initFunction()
    harvestCraft()
    getItemClipboard()
    if RegExMatch(Clipboard,"Item Level: [84-89]"){
        if RegExMatch(Clipboard,"Adds 12 Passive Skills"){
            if RegExMatch(Clipboard,"12% increased Lightning Damage"){
                    harvRe:="reforge attack"
                if RegExMatch(Clipboard,"Fractured"){
                    craftHarvest("LD1284",3,harvRe)
                    }
                else{
                    craftHarvest("LD1284H",2,harvRe)
                    }
                }
            }
        }
    return

Numpad3::
    initFunction()
    ;altToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small")
    return

Numpad4::
    initFunction()
    ;altAugRegalToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small","MR384")
    return

Numpad6::
    ;altToRegex(1,"m)nge|ow|san|^Lar mete|ear|igy|jewel$")
    return
;"m)Many|e\sBow$"
Numpad7::
    MsgBox % getItemRegex("m)Meteor|Bear|Prodigy|Jewel$","m)Powerful|Glowing|Sanguine|Dangerous|^Lar")
    MsgBox % Clipboard
    return
;Powerful|Glowing|Sanguine|Dangerous|^Lar 

Numpad8::
    initFunction()
    ExaltAnnulToRegex("SD1284")
;altAugRegalToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small","","MR384")
;altToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small","")
;altToRegex(1,"m)Meteor|Bear|Prodigy|Jewel$","m)Powerful|Glowing|Sanguine|Dangerous|^Lar"
;altAugRegalToRegex(1,"m)Meteor|Bear|Prodigy|Jewel$","m)Powerful|Glowing|Sanguine|Dangerous|^Lar","SD1284")

Numpad9::
    ;result := SD1284()
    Annul() 
    return