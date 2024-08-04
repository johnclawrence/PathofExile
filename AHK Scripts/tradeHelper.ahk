#Include, configUltraWide.ahk


Clicker:
    Click
return

Compare(c1, c2, vary=20) {
    rdiff := Abs( c1.r - c2.r )
    gdiff := Abs( c1.g - c2.g )
    bdiff := Abs( c1.b - c2.b )

    return rdiff > vary || gdiff > vary || bdiff > vary
}

ToRGB(color) {
    return { "r": (color >> 16) & 0xFF, "g": (color >> 8) & 0xFF, "b": color & 0xFF }
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
		MouseMove curX,curY,0
		MouseClick Left
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
		MouseMove curX,curY,0
		PixelGetColor Color,%curX%,%curY%,
		biColor := ToRGB(0x070707)
		miColor := ToRGB(Color)
		dColor := Compare(biColor,miColor)
		if (dColor){
			MouseMove curX,curY,0
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

F4::
	xTradeL=330
	xTradeR=915
	yTrade1=220
	yTrade2=270
	yTrade3=330
	yTrade4=380
	yTrade5=440
	;MouseMove xTradeL,yTrade1,0
	;MouseMove xTradeR,yTrade1,9
	;MouseMove xTradeR,yTrade2,0
	;MouseMove xTradeL,yTrade2,9
	;MouseMove xTradeL,yTrade3,0
	;MouseMove xTradeR,yTrade3,9
	;MouseMove xTradeR,yTrade4,0
	;MouseMove xTradeL,yTrade4,9
	;MouseMove xTradeL,yTrade5,0
	;MouseMove xTradeR,yTrade5,9
    return

F6::
	MouseGetPos xPos,yPos
	Send, {Control down}
	sleep 20
	MouseClick Left
	sleep 20
	Send, {Control up}
	;MouseMove 564,970,0
	MouseMove 1280,970,0
	sleep 80
	MouseClick Left
	sleep 80
	;MouseMove 619,669,0
	MouseMove 1283,669,0
	sleep 30
	Send, {Control down}
	sleep 20
	MouseClick Left
	sleep 20
	Send, {Control up}
	sleep 20
	MouseMove xPos,yPos,0
	return
	
	
F7::
	sleepdur=65
	MouseGetPos xPos,yPos
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos,yPos-invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos,yPos+invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos-invWidth,yPos,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos+invWidth,yPos,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos+invWidth,yPos-invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos-invWidth,yPos+invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos-invWidth,yPos-invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Right
	sleep %sleepdur%
	MouseMove xPos+invWidth,yPos+invWidth,0
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos,yPos
	sleep %sleepdur%
	MouseClick Left
	sleep %sleepdur%
	MouseMove xPos+invWidth+invWidth+invWidth,yPos
	sleep %sleepdur%
	MouseClick Left
	return

LeftSubFunction(price,offset){
	MouseGetPos xPos,yPos
	MouseClick Right
	MouseMove xPos,yPos+120
	MouseClick Left
	MouseMove xPos,yPos+220
	MouseClick Left
	MouseMove xPos+200-offset,yPos+120
	MouseClick Left
	Send, ^a
	Send, %price%
	MouseMove xPos+535-offset,ypos+165,0
	MouseClick Left
}
LeftSubFunctionDiv(price,offset){
	MouseGetPos xPos,yPos
	MouseClick Right
	MouseMove xPos,yPos+120
	MouseClick Left
	MouseMove xPos,yPos+220
	MouseClick Left
	MouseMove xPos+200-offset,yPos+120
	MouseClick Left
	Send, ^a
	Send, %price%
	MouseMove xPos+290-offset,ypos+120,0
	MouseClick Left
	MouseMove xPos+290-offset,ypos+380,0
	MouseClick Left
	MouseMove xPos+535-offset,ypos+165,0
	MouseClick Left
}
RightSubFunction(price,offset){
	MouseGetPos xPos,yPos
	MouseClick Right
	MouseMove xPos-250,yPos+120
	MouseClick Left
	MouseMove xPos-250,yPos+220
	MouseClick Left
	MouseMove xPos-50-offset,yPos+120
	MouseClick Left
	Send, ^a
	Send, %price%
	MouseMove xPos+290-offset,ypos+165,0
	MouseClick Left
}

RightSubFunctionDiv(price,offset){
	MouseGetPos xPos,yPos
	MouseClick Right
	MouseMove xPos-250,yPos+120
	MouseClick Left
	MouseMove xPos-250,yPos+220
	MouseClick Left
	MouseMove xPos-50-offset,yPos+120
	MouseClick Left
	Send, ^a
	Send, %price%
	MouseMove xPos+290-offset,ypos+120,0
	MouseClick Left
	MouseMove xPos+250-offset,ypos+380,0
	MouseClick Left
	MouseMove xPos+290-offset,ypos+165,0
	MouseClick Left
}

F9::
	dGreedP:="126/36"
	dContemptP:="229/36"
	dHatredP:="126/36"
	dWoeP:="126/36"
	dFearP:="126/36"
	dAngerP:="126/36"
	dTormentP:="126/36"
	dSorrowP:="126/36"
	dRageP:="126/36"
	dSufferingP:="126/36"
	dWrathP:="126/36"
	dDoubtP:="126/36"
	dLoath :="126/36"
	dZeal :="144/36"
	dAnguish :="126/36"
	dSpite :="126/36"
	dScorn :="126/36"
	dEnvy :="211/36"
	dMisery :="126/36"
	dDread :="126/36"

	sGreedP:="104/72"
	sContemptP:="144/72"
	sHatredP:="104/72"
	sWoeP:="72/72"
	sFearP:="72/72"
	sAngerP:="78/72"
	sTormentP:="72/72"
	sSorrowP:="72/72"
	sRageP:="72/72"
	sSufferingP:="72/72"
	sWrathP:="108/72"
	sDoubtP:="72/72"
	sLoath :="72/72"
	sZeal :="144/72"
	sAnguish :="72/72"
	sSpite :="72/72"
	sScorn :="72/72"
	sEnvy :="144/72"
	sMisery :="107/72"
	sDread :="72/72"

	cGreedP:="144/144"
	cContemptP:="128/144"
	cHatredP:="120/144"
	cWoeP:="82/144"
	cFearP:="72/144"
	cAngerP:="128/144"
	cTormentP:="72/144"
	cSorrowP:="72/144"
	cRageP:="72/144"
	cSufferingP:="72/144"
	cWrathP:="128/144"
	cDoubtP:="72/144"
	cLoath :="72/144"
	cZeal :="144/144"
	cAnguish :="72/144"
	cSpite :="112/144"
	cScorn :="144/144"
	cEnvy :="144/144"
	cMisery :="144/144"
	cDread :="88/144"

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
	EssenceX11 := 790
	EssenceX3 := 220
	EssenceX9 := 664

	MouseMove EssenceX1,EssenceY1,0
	LeftSubFunction(dGreedP,0)
	MouseMove EssenceX1,EssenceY2,0
	LeftSubFunction(dContemptP,0)
	MouseMove EssenceX1,EssenceY3,0
	LeftSubFunction(dHatredP,0)
	MouseMove EssenceX1,EssenceY4,0
	LeftSubFunction(dWoeP,0)
	MouseMove EssenceX1,EssenceY5,0
	LeftSubFunction(dFearP,0)
	MouseMove EssenceX1,EssenceY6,0
	LeftSubFunction(dAngerP,0)
	MouseMove EssenceX1,EssenceY7,0
	LeftSubFunction(dTormentP,0)
	MouseMove EssenceX1,EssenceY8,0
	LeftSubFunction(dSorrowP,0)
	MouseMove EssenceX1,EssenceY9,0
	LeftSubFunction(dRageP,0)
	MouseMove EssenceX1,EssenceY10,0
	LeftSubFunction(dSufferingP,0)
	MouseMove EssenceX1,EssenceY11,0
	LeftSubFunction(dWrathP,0)
	MouseMove EssenceX1,EssenceY12,0
	LeftSubFunction(dDoubtP,0)

	MouseMove EssenceX2,EssenceY1,0
	LeftSubFunction(sGreedP,60)
	MouseMove EssenceX2,EssenceY2,0
	LeftSubFunction(sContemptP,60)
	MouseMove EssenceX2,EssenceY3,0
	LeftSubFunction(sHatredP,60)
	MouseMove EssenceX2,EssenceY4,0
	LeftSubFunction(sWoeP,60)
	MouseMove EssenceX2,EssenceY5,0
	LeftSubFunction(sFearP,60)
	MouseMove EssenceX2,EssenceY6,0
	LeftSubFunction(sAngerP,60)
	MouseMove EssenceX2,EssenceY7,0
	LeftSubFunction(sTormentP,60)
	MouseMove EssenceX2,EssenceY8,0
	LeftSubFunction(sSorrowP,60)
	MouseMove EssenceX2,EssenceY9,0
	LeftSubFunction(sRageP,60)
	MouseMove EssenceX2,EssenceY10,0
	LeftSubFunction(sSufferingP,60)
	MouseMove EssenceX2,EssenceY11,0
	LeftSubFunction(sWrathP,60)
	MouseMove EssenceX2,EssenceY12,0
	LeftSubFunction(sDoubtP,60)

	MouseMove EssenceX3,EssenceY1,0
	LeftSubFunction(cGreedP,120)
	MouseMove EssenceX3,EssenceY2,0
	LeftSubFunction(cContemptP,120)
	MouseMove EssenceX3,EssenceY3,0
	LeftSubFunction(cHatredP,120)
	MouseMove EssenceX3,EssenceY4,0
	LeftSubFunction(cWoeP,120)
	MouseMove EssenceX3,EssenceY5,0
	LeftSubFunction(cFearP,120)
	MouseMove EssenceX3,EssenceY6,0
	LeftSubFunction(cAngerP,120)
	MouseMove EssenceX3,EssenceY7,0
	LeftSubFunction(cTormentP,120)
	MouseMove EssenceX3,EssenceY8,0
	LeftSubFunction(cSorrowP,120)
	MouseMove EssenceX3,EssenceY9,0
	LeftSubFunction(cRageP,120)
	MouseMove EssenceX3,EssenceY10,0
	LeftSubFunction(cSufferingP,120)
	MouseMove EssenceX3,EssenceY11,0
	LeftSubFunction(cWrathP,120)
	MouseMove EssenceX3,EssenceY12,0
	LeftSubFunction(cDoubtP,120)

	MouseMove EssenceX9,EssenceY1,0
	RightSubFunction(cLoath,0)
	MouseMove EssenceX9,EssenceY2,0
	RightSubFunction(cZeal,0)
	MouseMove EssenceX9,EssenceY3,0
	RightSubFunction(cAnguish,0)
	MouseMove EssenceX9,EssenceY4,0
	RightSubFunction(cSpite,0)
	MouseMove EssenceX9,EssenceY5,0
	RightSubFunction(cScorn,0)
	MouseMove EssenceX9,EssenceY6,0
	RightSubFunction(cEnvy,0)
	MouseMove EssenceX9,EssenceY7,0
	RightSubFunction(cMisery,0)
	MouseMove EssenceX9,EssenceY8,0
	RightSubFunction(cDread,0)

	MouseMove EssenceX10,EssenceY1,0
	RightSubFunction(sLoath,0)
	MouseMove EssenceX10,EssenceY2,0
	RightSubFunction(sZeal,0)
	MouseMove EssenceX10,EssenceY3,0
	RightSubFunction(sAnguish,0)
	MouseMove EssenceX10,EssenceY4,0
	RightSubFunction(sSpite,0)
	MouseMove EssenceX10,EssenceY5,0
	RightSubFunction(sScorn,0)
	MouseMove EssenceX10,EssenceY6,0
	RightSubFunction(sEnvy,0)
	MouseMove EssenceX10,EssenceY7,0
	RightSubFunction(sMisery,0)
	MouseMove EssenceX10,EssenceY8,0
	RightSubFunction(sDread,0)

	MouseMove EssenceX11,EssenceY1,0
	RightSubFunction(dLoath,0)
	MouseMove EssenceX11,EssenceY2,0
	RightSubFunction(dZeal,0)
	MouseMove EssenceX11,EssenceY3,0
	RightSubFunction(dAnguish,0)
	MouseMove EssenceX11,EssenceY4,0
	RightSubFunction(dSpite,0)
	MouseMove EssenceX11,EssenceY5,0
	RightSubFunction(dScorn,0)
	MouseMove EssenceX11,EssenceY6,0
	RightSubFunction(dEnvy,0)
	MouseMove EssenceX11,EssenceY7,0
	RightSubFunction(dMisery,0)
	MouseMove EssenceX11,EssenceY8,0
	RightSubFunction(dDread,0)
	return

