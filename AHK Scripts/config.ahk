SetBatchLines, -1
CurrFirstX:=150
CurrFirstY:=604
currWidth:=60
CurrX:=7
CurrY:=2

iAltX := 95
iAltY := 288
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

splashMove=1800

useCooldownSleep(){
	;This is somewhere around your ping.
	;If you start to see "Item Unuseable" you need to increase this.
	Sleep 5
	}
checkRegexSleep(){
	;This number + useCooldownSleep needs to be about double your ping.
	Sleep 70
	}

checkOCRSleep(){
    ;This number + useCooldownSleep needs to be about double your ping.
    Sleep 70
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

resoOne(){
    resoOneX := 190
    resoOneY := 650
    MouseMove resoOneX,resoOneY,0
    }

resoOneS1(){
    resoOneXS1 := 274
    resoOneYS2 := 490
    MouseMove resoOneXS1,resoOneYS2,0
    }

resoTwo(){
    resoTwoX := 251
    resoTwoY := 650
    MouseMove resoOneX,resoTwoY,0
    }
resoThree()
    {
    resoThreeX := 340
    resoThreeY := 650
    MouseMove resoThreeX,resoThreeY,0
    }
resoFour()
    {
    resoFourX := 441
    resoFourY := 650
    MouseMove resoFourX,resoFourY,0
    }
fosAbbr()
    {
    fosAbbrX := 333
    fosAbbrY := 214
    MouseMove fosAbbrX,fosAbbrY,0
    }

fosAssemble()
    {  
        fosAssembleX := 252
        fosAssembleY := 490
        MouseMove fosAssembleX,fosAssembleY,0
    }

fosCraft()
    {
    MouseMove 388,496,0
    }

dWrath()
    {
    MouseMove 68,672,0
    }
dAnger()
    {
    MouseMove 62,430,0
    }

dHatred()
    {
    MouseMove 59,262,0
    }

essenceCraft()
    {
    MouseMove 407,652,0
    }