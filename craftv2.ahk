InvFirstX = 1296
InvFirstY = 615
InvLastX = 1873
InvLastY = 822
InvLastColor = 0x090909
InvWidth = 53
InvX = 5
InvY = 12

CurrFirstX:=150
CurrFirstY:=604
currWidth:=60
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
	Sleep 50
	}
checkRegexSleep(){
	;This number + useCooldownSleep needs to be about double your ping.
	Sleep 60
	}
wiggleSleep(){
	;This is the cooldown to wait the stuff on your cursor to stop moving
	Sleep 20
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
	
ID()
{
	CraftX = 100
	CraftY = 200
	MouseMove CraftX,CraftY,1,
	return 0x533720
	}

Chisel()
{
	CraftX = 600
	CraftY = 200
	MouseMove CraftX,CraftY,1,
	return
	;color 
	}
	
Trans() {
	TransX = 50
	TransY = 260
	MouseMove TransX,TransY,1,
	return 0x325180
	}
	
Alteration() {
	global AltX
	global AltY
	MouseMove AltX,AltY,1,
	return 0x439694
	}
	
Annul() {
	AnnilX = 221
	AnnulY = 260
	MouseMove AnnulX,AnnulY,1,
	return 0x061547
	}
	
Regal() {
	RegalX = 440
	RegalY = 270
	MouseMove RegalX,RegalY,1,
	return 0x2A3447
	}

Alch() {
	AlchX = 490
	AlchY = 260
	MouseMove AlchX,AlchY,1,
	return 0x7C6C50
	}

Augmentation() {
	global AugX
	global AugY
	MouseMove AugX,AugY,1,
	return 0x2F2F38
	}

Scour() {
	ScourX = 435
	ScourY = 500
	MouseMove ScourX,ScourY,1,
	return 0x646568
	}
	
Bind() {
	BindX = 166
	BindY = 450
	MouseMove BindX,BindY,1,
	return 0x180F0B
	}

moveToCraft(){
	CraftX = 350
	CraftY = 450
	MouseMove CraftX,CraftY,1,
	return
	}

RegexBar(){
	RegexX = 480
	RegexY = 895
	MouseMove RegexX,RegexY,1
	}
	
setRegex(regexVal){
	RegexBar()
	MouseClick Left
	SendInput, ^a
	SendInput, %regexVal%
	}


regexSuccess()
	{
	checkRegexSleep()
	
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
	oldClip := Clipboard
	loopCount := 0
	loop{
		loopCount := loopCount + 1
		SendInput, ^c
		useCooldownSleep()
		clip := Clipboard
		if (clip != oldClip)
			{
			break
			}
		if (loopCount > 50){
			global misscur
			misscur := "Copy"
			break
			}
		}
	}

MR384(){
	output = 0
	itemArray := StrSplit(Clipboard,"--------")
	itemModData := itemArray[5]
	MES := RegExMatch(itemModData,"(1[7-9]|20) to Maximum Energy Shield")
	ML := RegExMatch(itemModData,"1[3-6] to Maximum Life")
	Intro := RegExMatch(itemModData,"Introspection")
	Eff := RegExMatch(itemModData,"Effect")
	EffT1 := RegExMatch(itemModData,"35% increased Effect")
	if (Eff>0){
		if (Intro>0){
			output = 1
			}
		if (MES + ML > 0){
			if (EffT1 > 0){
				output = 1
				}
			}
		}
	return output
	}
	
SD1284(){
	itemArray := StrSplit(Clipboard,"--------")
	itemModData := itemArray[5]
	MES := RegExMatch(itemModData,"([6-9]|1[0-2]) to Maximum Energy Shield")
	MEST1 := RegExMatch(itemModData,"([8-9]|1[0-2]) to Maximum Energy Shield")
	ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
	MLT1 := RegExMatch(itemModData,"([8-9]|10) to Maximum Life")
	Eff := RegExMatch(itemModData,"Effect")
	EffT1 := RegExMatch(itemModData,"35% increased Effect")
	AA := RegExMatch(itemModData,"[3-4] to All Attributes")
	AAT1 := RegExMatch(itemModData,"4 to All Attributes")
	StrT1 := RegExMatch(itemModData,"[6-8] to Strength")
	IntT1 := RegExMatch(itemModData,"[6-8] to Intelligence")
	Dam := RegExMatch(itemModData,"[3-4] % increased Damage")
	DamT1 := RegExMatch(itemModData,"4% increased Damage")
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
	if (score >2){
		output = 1
		}
	return output
	}

MD1284(){
	itemArray := StrSplit(Clipboard,"--------")
	itemModData := itemArray[5]
	MES := RegExMatch(itemModData,"[6-9]|1[0-2]) to Maximum Energy Shield")
	MEST1 := RegExMatch(itemModData,"([8-9]|1[0-2]) to Maximum Energy Shield")
	ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
	MLT1 := RegExMatch(itemModData,"([8-9]|10) to Maximum Life")
	EffT1 := RegExMatch(itemModData,"35% increased Effect")
	AERes := RegExMatch(itemModData,"[3-4]% to all Elemental Resistances")
	AEResT1 := RegExMatch(itemModData,"4% to all Elemental Resistances")
	ChaosRes := RegExMatch(itemModData,"[4-5]% to Chaos Resistance")
	ChaosResT1 := RegExMatch(itemModData,"5% to Chaos Resistance")
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
	if (score >2){
		output = 1
		}
	return output
	}

BD1284(){
	itemArray := StrSplit(Clipboard,"--------")
	itemModData := itemArray[5]
	MES := RegExMatch(itemModData,"([6-9]|1[0-2]) to Maximum Energy Shield")
	MEST1 := RegExMatch(itemModData,"([8-9]|1[0-2]) to Maximum Energy Shield")
	ML := RegExMatch(itemModData,"([5-9]|10) to Maximum Life")
	MLT1 := RegExMatch(itemModData,"([8-9]|10) to Maximum Life")
	EffT1 := RegExMatch(itemModData,"35% increased Effect")
	AERes := RegExMatch(itemModData,"[3-4]% to all Elemental Resistances")
	AEResT1 := RegExMatch(itemModData,"4% to all Elemental Resistances")
	ChaosRes := RegExMatch(itemModData,"[4-5]% to Chaos Resistance")
	ChaosResT1 := RegExMatch(itemModData,"5% to Chaos Resistance")
	AtkSpedT1 :=  RegExMatch(itemModData,"3% increased Attack Speed")
	Dam := RegExMatch(itemModData,"[3-4]% increased Damage")
	StrT1 := RegExMatch(itemModData,"[6-8] to Strength")
	IntT1 := RegExMatch(itemModData,"[6-8] to Intelligence")
	DexT1 := RegExMatch(itemModData,"[6-8] to Dexterity")
	AA := RegExMatch(itemModData,"[3-4] to All Attributes")
	

	;I must have T1 effect or Attributes in my 3 mods.
	score=0
	output = 0
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
	if (score >2){
		output = 1
		}
	return output
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
		MouseMove curX,curY,1
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
				}
			
			}
			
		sleep 100
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
		wiggleSleep()
		if (Color = curColor)
			{
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
    return
	}

	
altToRegex(Mode) 
	{
	;Mode 0 is Alt Check
	;Mode 1 is Alt Aug Check
	;Mode 2 is Alt Check Aug Check
	;Mode 3 is Check Alt Scour
	loopCount:=0
	global misscur
	Loop{
		loopCount := loopCount+1
		if (loopCount = 10){
			loopCount:=0
			magicCheck()
			}
		if GetKeyState("Esc", "P"){
			break
			}
		if (misscur != 0){
			break
			}
		;Loop Code
		if (regexSuccess()){
			if (Mode = 2){
				useCurrency("Augmentation")
				if (regexSuccess()){
					break
					}
				}
			if (Mode != 2){
				break
				}
			}
		else{
			if (Mode != 3){
				useCurrency("Alteration")
				}
			if (Mode = 3) {
				useCurrency("Scour")
				useCurrency("Alch")
				}
			if (Mode=1){
				useCurrency("Augmentation")
				}
			}
		}
	}

altAugRegalToRegex(Mode,Res1) 
	{
	;Mode 0: Alt Check Aug Regal Check 
	;Mode 1: Alt Check Aug Check Regal Check
	;Mode 2: Alt Check Aug Check Regal Check Optimized for Fracture
	global misscur
	Loop
	{
		if GetKeyState("Esc", "P")
			{
			break
			}
		if (misscur != 0){
			break
			}
		;Loop Code
		if (Mode=0){
			altToRegex(0)
			useCurrency("Augmentation")
			}
		if (Mode=1){
			altToRegex(2)
			}
		if (Mode=2){
			altToRegex(2)
			}
		useCurrency("Regal")
		if (regexSuccess())
			if (res1 = ""){
				break
				}
			else{
				getItemClipboard()
					result := %Res1%()
					if (result = 1){
						break
						}
				}
			useCurrency("Scour")
			if (Mode=0){
				useCurrency("Trans")
				}
			if (Mode=1){
				useCurrency("Trans")
				}
		}
	}

magicCheck(){
	moveToCraft()
	getItemClipboard()
	if (RegExMatch(Clipboard,"Rarity: Normal")){
		useCurrency("Trans")
		}
	}
	
F1::
    Toggle := !Toggle
    if (Toggle)
        SetTimer, Clicker, 100  ; Adjust the click interval (e.g., 100ms)
    else
        SetTimer, Clicker, Off
	return
	
F2::
	{
	Send, {Control down}
	Loop{
		if GetKeyState("Esc", "P"){
			Send, {Control up}
			break
			}
		PixelGetColor Color,%InvLastX%,%InvLastY%,RGB
		if (Color != InvLastColor){
			Send, {Control up}
			break
			}
		MouseClick Left
		wiggleSleep()
	}
	return
	}

F3::
	{
	curX:= InvFirstX
	curY:= InvFirstY
	countX=0
	countY=0
	Send, {Control down}
	Loop {
		if GetKeyState("Esc", "P")
			{
			Send, {Control up}
			break
			}
		if (countX = 12)
			break
		if (countY = 7)
			break
		MouseMove curX,curY,1
		MouseClick Left
		wiggleSleep()
		countY := countY + 1
		curY := curY + invWidth
		if (countY = 5)
			{
			countX := countX + 1
			countY := 0
			curY := InvFirstY
			curX := curX + invWidth
			}
		}
	curX:= InvFirstX
	curY:= InvFirstY
	countX=0
	countY=0
	Loop {
		if GetKeyState("Esc", "P")
			{
			Send, {Control up}
			break
			}
		if (countX = 12)
			break
		if (countY = 7)
			break
		MouseMove curX,curY,1
		PixelGetColor Color,%curX%,%curY%,
		biColor := ToRGB(0x070707)
		miColor := ToRGB(Color)
		dColor := Compare(biColor,miColor)
		if (dColor){
			MouseMove curX,curY,1
			MouseClick Left
			wiggleSleep()
			}
		countY := countY + 1
		curY := curY + invWidth
		if (countY = 5)
			{
			countX := countX + 1
			countY := 0
			curY := InvFirstY
			curX := curX + invWidth
			}
		}
		
	Send, {Control up}
	}
	return

Clicker:
    Click
return

Numpad4::
	useCurrency("Scour")
	useCurrency("Trans")
	altToRegex(2)
	useCurrency("Regal")
	return

Numpad3::
	initFunction()
	setRegex("""ros|pow|ax""" " " """ffe|ota|tou|pul""" " " """ros|ffe|tou|pul""")
	useCurrency("Scour")
	useCurrency("Trans")
	altAugRegalToRegex(0,"MR384")
	return

Numpad6::
	setRegex("Many|e\sBow$")
	altToRegex(2)
	return
	
	
Numpad7::
	initFunction()
	setRegex("nge|ow|san|{^}Lar mete|ear|igy|jewel$")
	useCurrency("Scour")
	moveToCraft()
	getItemClipboard()
	if (RegExMatch(Clipboard,"fractured")){
		altAugRegalToRegex(2,"SD1284")
		}
	else {
		useCurrency("Trans")
		altAugRegalToRegex(1,"SD1284")
		}	
	return
	
Numpad8::
	initFunction()
	setRegex("San|ow|{^}Lar  vi|zi|id|jewel$")
	useCurrency("Scour")
	moveToCraft()
	getItemClipboard()
	if (RegExMatch(Clipboard,"fractured")){
		altAugRegalToRegex(2,"MD1284")
		}
	else {
		useCurrency("Trans")
		altAugRegalToRegex(1,"MD1284")
		}	
	
	return
	

Numpad9::
	var := "BD1284"
	MsgBox % %var%()
		return
	
Numpad1::
	initFunction()
	moveToCraft()
	getItemClipboard()
	clusterType:=""

	if RegExMatch(Clipboard,"Item Level: [84-89]"){
		if RegExMatch(Clipboard,"Adds 12 Passive Skills"){
			if RegExMatch(Clipboard,"Minions deal 10% increased Damage"){
				clusterType:="MD1284"
				setRegex("San|ow|{^}Lar vi|zi|id|jewel$")
				}
			if RegExMatch(Clipboard,"10% increased Spell Damage"){
				clusterType:="SD1284"
				setRegex("nge|ow|san|{^}Lar mete|ear|igy|jewel$")
				}
			if RegExMatch(Clipboard,"12% increased Damage with Bows"){
				clusterType:="BD1284"
				setRegex("nge|pow|san|{^}Lar mete|ear|igy|vi|id|fox|tery|ewel$")
				}
			useCurrency("Scour")
			if (RegExMatch(Clipboard,"fractured")){
				altAugRegalToRegex(2,clusterType)
				}
			else {
				useCurrency("Trans")
				altAugRegalToRegex(1,clusterType)
				}	
			}
		if RegExMatch(Clipboard,"Adds 3 Passive Skills"){
			if RegExMatch(Clipboard,"6% increased Mana Reservation Efficiency of Skills"){
				setRegex("""ros|pow|ax""" " " """ffe|ota|tou|pul""" " " """ros|ffe|tou|pul""")
				useCurrency("Scour")
				useCurrency("Trans")
				altAugRegalToRegex(0,"MR384")
				}
			}
		}
	return
	
;"ros|pow|ax" "ffe|ota|tou|pul" "ros|ffe|tou|pul" Regex for 84-3-Reservation (Introspection/Effect/Life/ES)

;San|ow|{^}Lar  vi|zi|id|jewel$ Regex 1 for 84-12-Minion

;nge|ow|san|{^}Lar mete|ear|igy|jewel$ Regex 1 for 84-12-Spelle (Int/Strength)
;nge|ow|san|^Lar mete|ear|igy|jewel$
;Regex 2
;Prefixes are Effect Life, Effect ES, Effect Damage
;Sufixes are All Attr Strength, All Attr Int
;In the case where I do not know anything about the cluster...

;nge|ow|san|^Lar mete|ear|igy|jewel$
;nge|ow|san|^Lar mete|intel|stren|eff
