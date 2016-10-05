#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; A few AutoHotkey functions to make up for the lack of hotkeys in Ustocktrade. So far there is:
; Increment, decrement, and clear order size.
; Buy @ market, buy @ bid.
; Sell @ market, sell @ ask.

; Default coords and window name works on a primary 1440p monitor in a Chrome window that is snapped to the left.
; Only works with the most recently added stock, or the one on the leftmost of the window.
; Hotkeys can be changed as desired, list is here https://autohotkey.com/docs/KeyList.htm

; Enter window name and coordinates here.
global windowName:= "Ustocktrade - Google Chrome"
global xCoordQuantity:= "x120"
global yCoordQuantity:= "y350"
global xCoordBuyButton:= "x60"
global yCoordBuyButton:= "y380"
global xCoordBid:= "x50"
global yCoordBid:= "y260"
global xCoordSellButton:= "x260"
global yCoordSellButton:= "y380"
global xCoordAsk:= "x350"
global yCoordAsk:= "y260"
global xCoordConfirmButton:= "x700"
global yCoordConfirmButton:= "y390"
global numDigitsToClear:= 5 ; Will clear up to a 99999 share order, didn't see any point in going higher.
global shareCounter:= 0 ; Don't touch!
increment:= 50 ; Change the increment value here.
decrement:= 50 ; Change the decrement value here.

; Increments number of shares by the amount defined for "increment".
Ctrl & 6::
	clickQuantity()
	Sleep, 25
	; Clears quantity field, increments number of shares and enters it.
	shareCounter+= %increment%
	clearQuantity()
	Send "%shareCounter%"
Return

; Decrements number of shares by the amount defined for "decrement".
Ctrl & 3::
	clickQuantity()
	Sleep, 25
	; Clears quantity field, increments number of shares and enters it.
	if (shareCounter = %decrement%) {
		Return
	}
	if (shareCounter > 0) {
		shareCounter-= %decrement%
	}
	clearQuantity()
	Send "%shareCounter%"
Return

; Places a buy order at market.
Ctrl & 4::
	clickBuy()
	; Delay between clicks can possibly be lowered, 225 is too fast.
	Sleep, 250
	clickConfirm()
	resetShareCounter()
Return

; Places a buy order at bid.
Ctrl & 5::
	clickBid()
Return

; Places a sell order at market.
Ctrl & 1::
	clickSell()
	Sleep, 250
	clickConfirm()
Return

; Places a sell order at ask.
Ctrl & 2::
	clickAsk()
Return

; Clears the quantity field.
Esc::
	clickQuantity()
	Sleep, 25
	clearQuantity()
	resetShareCounter()
Return

; Sets quantity to 500
Ctrl & 8::
	clickQuantity()
	Send 500
Return

; Sets quantity to 1000
Ctrl & 9::
	clickQuantity()
	Send 1000
Return

resetShareCounter() {
	shareCounter= 0
}

clickBuy() {
	ControlClick, %xCoordBuyButton% %yCoordBuyButton%, %windowName%
}

clickSell() {
	ControlClick, %xCoordSellButton% %yCoordSellButton%, %windowName%
}

clickBid() {
	ControlClick, %xCoordBid% %yCoordBid%, %windowName%
}

clickAsk() {
	ControlClick, %xCoordAsk% %yCoordAsk%, %windowName%
}

clickConfirm() {
	ControlClick, %xCoordConfirmButton% %yCoordConfirmButton%, %windowName%
	resetShareCounter()
}

clickQuantity() {
	ControlClick, %xCoordQuantity% %yCoordQuantity%, %windowName%
}

clearQuantity() {
	Loop, %numDigitsToClear%
	{
		Send {Delete}
	}
}

; Hit ` to exit this program.
`::ExitApp