#Include, config.ahk
#Include, AffixRegex.ahk
SetBatchLines, -1

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

getItemClipboard(){
    checkRegexSleep()
    Clipboard=
    Send, ^!c
    ClipWait , .1
    if ErrorLevel
        {
        Send, ^!c
        ClipWait , .1
        }
    }
Compare(c1, c2,vary) {
    rdiff := Abs( c1.r - c2.r )
    gdiff := Abs( c1.g - c2.g )
    bdiff := Abs( c1.b - c2.b )

    return rdiff > vary || gdiff > vary || bdiff > vary
    }

ToRGB(color) {
    return { "r": (color >> 16) & 0xFF, "g": (color >> 8) & 0xFF, "b": color & 0xFF }
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
        dColor := Compare(biColor,miColor,5)
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
    ;curColor := ToRGB(curColor)
    fcLoop := 0
    
    Loop{
        fcLoop := fcLoop + 1
        if GetKeyState("Esc", "P")
            {
            break
            }
        %functionName%()
        MouseClick Right
        sleep 25
        MouseGetPos, X,Y
        PixelGetColor Color,%X%,%Y%,RGB
        ;Color := ToRGB()
        if ((Color=curColor))
            {
            moveToCraft()
            MouseClick Left
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
    useCooldownSleep()
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
regexSuccess()
	{
    checkOCRSleep()
	PixelSearch, Px, Py, 361, 524, 388, 556, 0xe7b477, 0, Fast RGB
		if ErrorLevel
			{
				return (0)
			}
		else
			{
				return (1)
			}
	}


altToRegex(Mode,blueRegex1,blueRegex2,version) 
	{
	;Mode 0 is Alt Check
	;Mode 1 is Alt Check Aug Check
    ;Version 0 is copy and AHK RE
    ;Version 1 is OCR Regex
	global misscur
    moveToCraft()
    getItemClipboard()
    magicCheck()
    loopCount:=0
	Loop{
		if GetKeyState("Esc", "P"){
			break
			}
		if (misscur != 0){
			break
			}
        moveToCraft()
		;Loop Code
        if (version = 0){
            if (getItemRegex(blueRegex1,blueRegex2)){
                if (Mode = 1){
                    if (!RegExMatch(Clipboard,"Prefix") || !RegExMatch(Clipboard,"Suffix")){
                        useCurrency("Augmentation")
                        }
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
            if (version = 1){
                if (regexSuccess()){
                    if (Mode = 1){
                        useCurrency("Augmentation")
                        loopCount := 0
                        if (regexSuccess()){
                            break
                            }
                        }
                    if (Mode = 0){
                        break
                        }
                    }
                else{
                    useCurrency("Alteration")
                    if (loopCount := 20){
                        moveToCraft()
                        getItemClipboard()
                        magicCheck()
                    }
                }
            }
		}
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
altAugRegalToRegex(Mode,blueRegex1,blueRegex2,rareRegex) 
	{
	;Mode 0: Alt Check Aug Regal Check 
	;Mode 1: Alt Check Aug Check Regal Check
	global misscur
    global splashMove
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
			altToRegex(0,blueRegex1,blueRegex2,0)
			useCurrency("Augmentation")
			}
		if (Mode=1){
			altToRegex(1,blueRegex1,blueRegex2,0)
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
        SplashTextOn, 800, 1000, LastCluster, %Clipboard%`n Score: %result%
        WinMove, LastCluster,, %splashMove%, 0
        useCurrency("Scour")
		}
    SplashTextOff
	}
setRegex(regexVal,regexType){
    ;RegexBar() RegexBar for normal harvestRegex for harvest
    %regexType%()
    MouseClick Left
    SendInput, ^a
    SendInput, %regexVal%
    }



useEssence(functionName){
    %functionName%()
    MouseClick Right
    wiggleSleep()
    essenceCraft()
    MouseClick Left
    useCooldownSleep()
    return
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

craftEssence(re1,score,essence){
    global misscur
    loop{
        if GetKeyState("Esc", "P"){
            break
            }
        useEssence(essence)
        getItemClipboard()
        if (%re1%() > (score-1)){
            break
            }
        }
    }
    

Numpad6::
    ;altToRegex(1,"m)Many|e\sBow$","",0)
    ;altToRegex(1,"m)Training|e\sJewel$","m)Stalwart|Flaring|^Synthesised\sGhastly",0) ;T1
    altToRegex(1,"m)Training|e\sJewel$","m)Sanguine|Tempered|Vile|^Synthesised\sGhastly",0) ;T2
    ;altToRegex(1,"m)Training|e\sJewel$","m)Malignant|Healthy|Razor|^Synthesised\sGhastly",0) ;T3
    return

Numpad7::
    initFunction()
    getItemClipboard()
    MsgBox % MR384()
    return


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
                altAugRegalToRegex(1,"m)Powerful|Sanguine|Dangerous|^Lar","m)Meteor|Bear|Prodigy|Eviction|Kaleidoscope|Fox|Mastery|Jewel$","BD1284")
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


Numpad8::
    craftEssence("eleBowPrefix",2,"dHatred")
    return