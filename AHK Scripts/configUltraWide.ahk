SetBatchLines, -1
CurrFirstX:=150
CurrFirstY:=604
currWidth:=60
CurrX:=7
CurrY:=2

iAltX := 140
iAltY := 358
iAugX := 300
iAugY := 439

AltX := iAltX
AltY := iAltY
AugX := iAugX
AugY := iAugY
misscur :=0

InvFirstX = 2592
InvFirstY = 798
InvLastX = 3382
InvLastY = 1092
InvLastColor = 0x090909
InvWidth = 70
InvX = 5
InvY = 12

splashMove=900

useCooldownSleep(){
	;This is somewhere around your ping.
	;If you start to see "Item Unuseable" you need to increase this.
	Sleep 100
	}
checkRegexSleep(){
	;This number + useCooldownSleep needs to be about double your ping.
	Sleep 20
	}

checkOCRSleep(){
    ;This number + useCooldownSleep needs to be about double your ping.
    Sleep 100
    }

wiggleSleep(){
	;This is the cooldown to wait the stuff on your cursor to stop moving
	Sleep 10
	}
	
Trans() {
	TransX = 70
	TransY = 367
	MouseMove TransX,TransY,0
	return 0x294265
	}
	
Alteration() {
	global AltX
	global AltY
	MouseMove AltX,AltY,0
	return 0x479C8A
	}

Augmentation() {
    global AugX
    global AugY
    MouseMove AugX,AugY,0
    return 0x212431
    }
	
Regal() {
	RegalX = 580
	RegalY = 367
	MouseMove RegalX,RegalY,0
	return 0x26344C
	}

Alch() {
	AlchX = 655
	AlchY = 364
	MouseMove AlchX,AlchY,0
	return 0x6A5A3C
	}

Scour() {
	ScourX = 579
	ScourY = 676
	MouseMove ScourX,ScourY,0
	return 0x616466
	}

Exalt() {
    ExaltX = 400
    ExaltY = 363
    MouseMove ExaltX,ExaltY,0
    return 0x3D2F23
    }

Annul() {
    AnnulX = 226
    AnnulY = 363
    MouseMove AnnulX,AnnulY,0
    return 0x060818
    }

moveToCraft(){
	CraftX = 439
	CraftY = 614
	MouseMove CraftX,CraftY,0
	return
	}

harvestCraft(){
    harvestCraftX := 1721
    harvestCraftY := 605
    MouseMove harvestCraftX,harvestCraftY,0
    }

RegexBar(){
	RegexX = 632
	RegexY = 1191
	MouseMove RegexX,RegexY,0
	}
	
harvestRegex(){
    harvestRegexX := 1733
    harvestRegexY := 807
    MouseMove harvestRegexX,harvestRegexY,0
    }
	
harvestButton(){
    harvestButtonX := 1737
    harvestButtonY := 805
    MouseMove harvestButtonX,harvestButtonY,0
    }
    
harvestTop(){
    harvestTopX := 1043
    harvestTopY := 413
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


EssenceY1 := 230
EssenceY2 := 300
EssenceY3 := 360
EssenceY4 := 420
EssenceY5 := 500
EssenceY6 := 560
EssenceY7 := 630
EssenceY8 := 690
EssenceY9 := 750
EssenceY10 := 820
EssenceY11 := 880
EssenceY12 := 940
EssenceX1 := 90
EssenceX2 := 150
EssenceX10 := 725
ExxenceX11 := 790

dGreed(){
    MouseMove EssenceX1,EssenceY1,0
    }
dContempt(){
    MouseMove EssenceX1,EssenceY2,0
}
dHatred(){
    MouseMove EssenceX1,EssenceY3,0
}
dWoe(){
    MouseMove EssenceX1,EssenceY4,0
}
dFear(){
    MouseMove EssenceX1,EssenceY5,0
}
dAnger(){
    MouseMove EssenceX1,EssenceY6,0
}
dTorment(){
    MouseMove EssenceX1,EssenceY7,0
}
dSorrow(){
    MouseMove EssenceX1,EssenceY8,0
}
dRage(){
    MouseMove EssenceX1,EssenceY9,0
}
dSuffering(){
    MouseMove EssenceX1,EssenceY10,0
}
dWrath(){
    MouseMove EssenceX1,EssenceY11,0
}
dDoubt(){
    MouseMove EssenceX1,EssenceY12,0
}
sGreed(){
    MouseMove EssenceX2,EssenceY1,0
}
sContempt(){
    MouseMove EssenceX2,EssenceY2,0
}
sHatred(){
    MouseMove EssenceX2,EssenceY3,0
}
sWoe(){
    MouseMove EssenceX2,EssenceY4,0
}
sFear(){
    MouseMove EssenceX2,EssenceY5,0
}    
sAnger(){
    MouseMove EssenceX2,EssenceY6,0
}
sTorment(){
    MouseMove EssenceX2,EssenceY7,0
}
sSorrow(){
    MouseMove EssenceX2,EssenceY8,0
}
sRage(){
    MouseMove EssenceX2,EssenceY9,0
}
sSuffering(){
    MouseMove EssenceX2,EssenceY10,0
}
sWrath(){
    MouseMove EssenceX2,EssenceY11,0
}
sDoubt(){
    MouseMove EssenceX2,EssenceY12,0
}


dLoathing(){
    MouseMove EssenceX10,EssenceY1,0
}
dZeal(){
    MouseMove EssenceX10,EssenceY2,0
}
dAnguish(){
    MouseMove EssenceX10,EssenceY3,0
}
dSpite(){
    MouseMove EssenceX10,EssenceY4,0
}
dScorn(){
    MouseMove EssenceX10,EssenceY5,0
}
dEnvy(){
    MouseMove EssenceX10,EssenceY6,0
}
dMisery(){
    MouseMove EssenceX10,EssenceY7,0
}
dDread(){
    MouseMove EssenceX10,EssenceY8,0
}
sLoathing(){
    MouseMove EssenceX10,EssenceY1,0
}
sZeal(){
    MouseMove EssenceX10,EssenceY2,0
}
sAnguish(){
    MouseMove EssenceX10,EssenceY3,0
}
sSpite(){
    MouseMove EssenceX10,EssenceY4,0
}
sScorn(){
    MouseMove EssenceX10,EssenceY5,0
}
sEnvy(){
    MouseMove EssenceX10,EssenceY6,0
}
sMisery(){
    MouseMove EssenceX10,EssenceY7,0
}
sDread(){
    MouseMove EssenceX10,EssenceY8,0
}

cInsanity(){
    MouseMove EssenceX11,EssenceY9,0
}
cHorror(){
    MouseMove EssenceX11,EssenceY10,0
}
cDelirium(){
    MouseMove EssenceX11,EssenceY11,0
}
cHysteria(){
    MouseMove EssenceX11,EssenceY12,0
}


essenceCraft()
    {
    MouseMove 548,869,0
    }