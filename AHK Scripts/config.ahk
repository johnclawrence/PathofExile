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

InvFirstX = 1296
InvFirstY = 615
InvLastX = 1873
InvLastY = 822
InvLastColor = 0x090909
InvWidth = 53
InvX = 5
InvY = 12

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