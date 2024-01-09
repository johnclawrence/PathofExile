#Include, config.ahk


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
	MouseMove xTradeL,yTrade1,0
	MouseMove xTradeR,yTrade1,9
	MouseMove xTradeR,yTrade2,0
	MouseMove xTradeL,yTrade2,9
	MouseMove xTradeL,yTrade3,0
	MouseMove xTradeR,yTrade3,9
	MouseMove xTradeR,yTrade4,0
	MouseMove xTradeL,yTrade4,9
	MouseMove xTradeL,yTrade5,0
	MouseMove xTradeR,yTrade5,9
    return

F6::
	MouseGetPos xPos,yPos
	Send, {Control down}
	sleep 20
	MouseClick Left
	sleep 20
	Send, {Control up}
	MouseMove 564,970,0
	sleep 80
	MouseClick Left
	sleep 80
	MouseMove 619,669,0
	sleep 30
	Send, {Control down}
	sleep 20
	MouseClick Left
	sleep 20
	Send, {Control up}
	sleep 20
	MouseMove xPos,yPos,0
	return