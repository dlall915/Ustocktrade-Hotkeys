#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; A few AutoHotkey functions to make up for the lack of hotkeys in Ustocktrade. So far there is:
; Increment, decrement, and clear order size (default 100).
; Buy @ market, buy @ bid.
; Sell @ market, sell @ ask.

; Default Coords and window name works on a primary 1440p monitor in a Chrome window that is snapped to the left.
; Only works with the most recently added stock, or the one on the leftmost of the window.
; Hotkeys can be changed as desired, list is here https://autohotkey.com/docs/KeyList.htm

; Enter window name and coordinates here.
windowName:= "Ustocktrade - Google Chrome"
xCoordQuantity:= "x160"
yCoordQuantity:= "y350"
xCoordBuyButton:= "x55"
yCoordBuyButton:= "y380"
xCoordBid:= "x45"
yCoordBid:= "y265"
xCoordSellButton:= "x250"
yCoordSellButton:= "y380"
xCoordSAsk:= "x390"
yCoordSAsk:= "y265"
xCoordConfirmButton:= "x675"
yCoordConfirmButton:= "y465"

increment:= 50 ; Change the increment value here.
decrement:= 50 ; Change the decrement value here.
numShares:= 0 ; Don't touch!
numDigitsToClear:= 5 ; Will clear up to a 99999 share order, didn't see any point in going higher.

; Increments number of shares by the amount defined for "increment".
Ctrl & 6::
	; Clicks the quantity field.
	ControlClick, %xCoordQuantity% %yCoordQuantity%, %windowName%
	Sleep, 25
	; Clears quantity field, increments number of shares and enters it.
	numShares+= %increment%
	Loop, %numDigitsToClear%
	{
		Send {Delete}
	}
	Send "%numShares%"
Return

; Decrements number of shares by the amount defined for "decrement".
Ctrl & 3::
	; Clicks the quantity field.
	ControlClick, %xCoordQuantity% %yCoordQuantity%, %windowName%
	Sleep, 25
	; Clears quantity field, increments number of shares and enters it.
	if (numShares = %decrement%) {
		Return
	}
	if (numShares > 0) {
		numShares-= %decrement%
	}
	Loop, %numDigitsToClear%
	{
		Send {Delete}
	}
	Send "%numShares%"
Return

; Places a buy order at market.
Ctrl & 4::
	; Clicks the buy button.
	ControlClick, %xCoordBuyButton% %yCoordBuyButton%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCoordConfirmButton% %yCoordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a buy order at bid.
Ctrl & 5::
	; Clicks the bid, which enters that as the order price.
	ControlClick, %xCoordBid% %yCoordBid%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the buy button.
	ControlClick, %xCoordBuyButton% %yCoordBuyButton%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCoordConfirmButton% %yCoordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a sell order at market.
Ctrl & 1::
	; Clicks the sell button
	ControlClick, %xCoordSellButton% %yCoordSellButtont%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCoordConfirmButton% %yCoordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a sell order at ask.
Ctrl & 2::
	; Clicks the ask, which enters that as the ask price.
	ControlClick, %xCoordAsk% %yCoordAsk%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the sell button
	ControlClick, %xCoordSellButton% %yCoordSellButtont%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCoordConfirmButton% %yCoordConfirmButton%, %windowName%
	numShares= 0
Return

; Clears the quantity field.
Esc::
	; Clicks the quantity field.
	ControlClick, %xCoordQuantity% %yCoordQuantity%, %windowName%
	Sleep, 25
	Loop, %numDigitsToClear%
	{
		Send {Delete}
	}
	numShares= 0
Return

; Hit ` to exit this program.
`::ExitApp