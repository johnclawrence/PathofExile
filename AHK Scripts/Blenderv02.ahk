#Include, configUltraWide.ahk
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
        wiggleSleep()
        MouseClick Right
        wiggleSleep()
        MouseGetPos, X,Y
        PixelGetColor Color,%X%,%Y%,RGB
        ;Color := ToRGB()
        if ((Color=curColor)){
            moveToCraft()
            wiggleSleep()
            MouseGetPos, X,Y
            PixelGetColor Color,%X%,%Y%,RGB
            if ((Color=curColor)){    
                MouseClick Left
                break
                }
            }
		if (functionName = "Annul"){
            moveToCraft()
            wiggleSleep()
            MouseClick Left
            break
            }
		if (fcLoop = 25){
            break
			findCurrency(functionName)
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

AugAnnulToRegex(exRegex)
    {
    SplashTextOn, 800, 1000, LastCluster, %Clipboard%`n Score: %result%
    WinMove, LastCluster,, %splashMove%, 400
    useCurrency("Annul")
    getItemClipboard()
    result := %exRegex%()
    if (result > 0){
        useCurrency("Augmentation")
        }
    getItemClipboard()
    result := %exRegex%()
    if (result = 1){
        AugAnnulToRegex(exRegex)
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
            sleep 20
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
        WinMove, LastCluster,, %splashMove%, 200
        useCurrency("Scour")
		}
    SplashTextOff
	}

alchToRegex(rareRegex) 
	{
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
		useCurrency("Alch")
		getItemClipboard()
		result := %rareRegex%()
        if (result > 1){
            break                
            }
            ;If the item is fractured, go for 4 mod. 
        SplashTextOn, 800, 1000, LastCluster, %Clipboard%`n Score: %result%
        WinMove, LastCluster,, %splashMove%, 200
        useCurrency("Scour")
		}
    SplashTextOff
	}


altAnnulToRegex(blueRegex1,blueRegex2,blueregex)
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
		altToRegex(1,blueRegex1,blueRegex2,0)
		getItemClipboard()
		result := %blueregex%()
        if (result = 2){
            break
            }
        if (result = 1){
            AugAnnulToRegex(blueregex)
            getItemClipboard()
            result := %blueregex%()
            if (result = 2){
                break
                }
            } 
        
        useCurrency("Scour")
		}
    SplashTextOff
    altToRegex(1,blueRegex1,blueRegex2,0) 


    }
setRegex(regexVal,regexType){
    ;RegexBar() RegexBar for normal harvestRegex for harvest
    %regexType%()
    MouseClick Left
    SendInput, ^a
    SendInput, %regexVal%
    }



useEssence(essence){
    Y1 := 230
	Y2 := 300
	Y3 := 360
	Y4 := 420
	Y5 := 500
	Y6 := 560
	Y7 := 630
	Y8 := 690
	Y9 := 750
	Y10 := 820
	Y11 := 880
	Y12 := 940
	X1 := 90
	X2 := 150
	X10 := 725
	X11 := 790
	X3 := 220
	X9 := 664
    if (essence = "deafTorment"){
        MouseMove X1,Y7,0
        }
    if (essence = "deafFear"){
        MouseMove X1,Y5,0
        }
    if (essence = "deafScorn"){
        MouseMove X11,Y5,0
        }
    if (essence = "deafMisery"){
        MouseMove X11,Y7,0
        }
    MouseClick Right
    wiggleSleep()
    essenceCraft()
    MouseClick Left
    useCooldownSleep()
    return
    }

useFossil(reso,fossil){
    if (reso=1){
        MouseMove 251,870,0
        wiggleSleep()
        MouseClick Left
        wiggleSleep()
        MouseMove 525,646,1
        wiggleSleep()
        Send {Shift Down}
        Send {Control Down}
        MouseClick Left
        Send {Shift Up}
        Send {Control Up}
        wiggleSleep()
        MouseMove 251,870,0
        MouseClick Left
        wiggleSleep()
        }

    if (fossil="Dense"){
        MouseMove 259,276,0
        wiggleSleep()
        MouseClick Left
        wiggleSleep()
        MouseMove 525,646,1
        wiggleSleep()
        MouseClick Left
        wiggleSleep()
        MouseMove 259,276,0
        wiggleSleep()
        MouseClick Left
        wiggleSleep()
        }
    MouseMove 525,646,0
    wiggleSleep()
    MouseClick Right
    wiggleSleep()
    MouseMove 314,608,1
    wiggleSleep()
    MouseClick Left
    }

craftHarvest(re1,score,harvRE){
    ;setRegex(harvRE,"harvestRegex")
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
        if (%re1%() >= score){
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
    initFunction()
    ;altToRegex(1,"m)Many|e\sBow$","",0)
    altAnnulToRegex("m)Training|Stalwart|Flaring|e\sJewel$","m)Training|Stalwart|Flaring|^Synthesised\sGhastly","MinionGhastlyAdorned") ;T1 save either. 
    ;altToRegex(1,"m)Training|e\sJewel$","m)Sanguine|Tempered|Vile|^Synthesised\sGhastly",0) ;T2
    ;altToRegex(1,"m)Training|e\sJewel$","m)Malignant|Healthy|Razor|^Synthesised\sGhastly",0) ;T3
    ;altToRegex(1,"m)Deathless|r\sShield$","",0)
    return

Numpad7::
    initFunction()
    ;getItemClipboard()
    ;MsgBox % MR384()
    ;useEssence("Stuff")
    ;Alteration()
    ;sleep 20
    ;MouseClick Right
    ;altToRegex(1,"m)Powerful|Glowing|Sanguine|^Lar","m)Eviction|zi|Kaleidoscope|Jewel$",0)
    ;altToRegex(1,"m)Powerful|^Lar","m)Overflowing|Jewel$",0)
    ;alchToRegex("FD684ToFracture")
    ;MsgBox % clusterLife(Clipboard)
    ;MsgBox % allskillsneck()
    ;altToRegex(1,"m)Impala|Flask$","",0)
    ;useEssence("deafTorment")
    ;altToRegex(1,"m)Meteor|Prodigy|Jewel$","m)Powerful|Glowing|^Synthesised\sLar",0) 
    alchToRegex("allskillsneck")
    return


Numpad1::
    initFunction()
    moveToCraft()
    getItemClipboard()
    if RegExMatch(Clipboard,"Item Level: [84-89]"){
        if RegExMatch(Clipboard,"Adds 12 Passive Skills"){
            if RegExMatch(Clipboard,"Minions deal 10% increased Damage"){
                altAugRegalToRegex(1,"m)Powerful|Glowing|Sanguine|^Lar","m)Eviction|zi|Kaleidoscope|Jewel$","MD1284")
                }
            if RegExMatch(Clipboard,"10% increased Spell Damage"){
                if RegExMatch(Clipboard,"Fractured"){
                    altAugRegalToRegex(1,"m)Meteor|Bear|Prodigy|Kaleidoscope|Jewel$","m)Powerful|Glowing|Sanguine|Dangerous|^Lar","SD1284")   
                    ;altAugRegalToRegex(1,"m)Meteor|Prodigy|Jewel$","m)Powerful|Glowing|^Lar","SD1284")   
                    ;altAugRegalToRegex(1,"m)Meteor|Bear|Jewel$","m)Powerful|Sanguine|Dangerous|^Lar","SD1284")  
                    }
                else{
                    alchToRegex("SD1284toFracture")   
                    }
                }
            if RegExMatch(Clipboard,"12% increased Damage with Bows"){
                altAugRegalToRegex(1,"m)Powerful|Sanguine|Dangerous|^Lar","m)Meteor|Bear|Prodigy|Eviction|Kaleidoscope|Fox|Mastery|Jewel$","BD1284")
                }
            if RegExMatch(Clipboard,"12% increased Damage with Hits and Ailments"){
                if RegExMatch(Clipboard,"Fractured"){
                    altAugRegalToRegex(1,"m)Powerful|Glowing|Sanguine|Dangerous|^Lar","m)Mastery|Prodigy|Eviction|Kaleidoscope|Jewel$","WD1284")
                    }
                else{
                    alchToRegex("ADS1284toFracture")
                    }
                }
            if RegExMatch(Clipboard,"12% increased Attack Damage while holding a Shield"){
                alchToRegex("ADS1284toFracture")   
                }
            }
        if RegExMatch(Clipboard,"Adds 3 Passive Skills"){
            if RegExMatch(Clipboard,"6% increased Mana Reservation Efficiency of Skills"){
                altAugRegalToRegex(1,"m)Introspection|Powerful|Stout|Pulsing|^Small","","MR384")
                }
            }
        }
    if RegExMatch(Clipboard,"Adds 8 Passive Skills"){
            if RegExMatch(Clipboard,"Dagger Attacks deal 12% increased Damage with Hits and Ailments"){
                altAugRegalToRegex(1,"m)^Notable|^Lar","m)Significance|Fan|Jewel$","CD875")
            }
        }
    if RegExMatch(Clipboard,"Adds 6 Passive Skills"){
        altAugRegalToRegex(1,"m)Powerful|Sanguine|^Medium\sC","m)Meteor|Eviction|Kaleidoscope|Overflowing|Jewel$","FD684")
        
    }

    
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
            if RegExMatch(Clipboard,"Minions deal 10% increased Damage"){
                    harvRe:="reforge caster"
                if RegExMatch(Clipboard,"Fractured"){
                    craftHarvest("MD1284",3,harvRe)
                    }
                else{
                    craftHarvest("MD1284",2,harvRe)
                    }
                }
            }
        }
    return

Numpad8::
    initFunction()
    essenceCraft()
    getItemClipboard()
    if RegExMatch(Clipboard,"Item Class: Quivers"){
        craftEssence("eleQuiverSuffix",1,"deafTorment")
    }
    if RegExMatch(Clipboard,"Bone Ring"){
        craftEssence("mdRing",1,"deafFear")
    }
    if RegExMatch(Clipboard,"Helical Ring"){
        craftEssence("Genius",1,"deafScorn")
    }
    if RegExMatch(Clipboard,"Profane Wand"){
        craftEssence("Dissolution",1,"deafMisery")
    }
    ;craftEssence("eleBowPrefix",1,"dHatred")
    return

Numpad4::
    useFossil(1,"Dense")
    