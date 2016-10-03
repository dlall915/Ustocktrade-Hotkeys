#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; A few AutoHotkey functions to make up for the lack of hotkeys in Ustocktrade. So far there is:
; Increment, decrement, and clear order size (default 100).
; Buy @ market, buy @ bid.
; Sell @ market, sell @ ask.

; Default cords and window name works on a primary 1440p monitor in a Chrome window that is snapped to the left.
; Only works with the most recently added stock, or the one on the leftmost of the window.
; Hotkeys can be changed as desired, list is here https://autohotkey.com/docs/KeyList.htm

; Enter window name and coordinates here.
windowName:= "Ustocktrade - Google Chrome"
xCordQuantity:= "x160"
yCordQuantity:= "y350"
xCordBuyButton:= "x55"
yCordBuyButton:= "y380"
xCordBid:= "x45"
yCordBid:= "y265"
xCordSellButton:= "x250"
yCordSellButton:= "y380"
xCordSAsk:= "x390"
yCordSAsk:= "y265"
xCordConfirmButton:= "x675"
yCordConfirmButton:= "y465"

increment:= 50 ; Change the increment value here.
decrement: = 50; Change the decrement value here.
numShares:= 0 ; Don't touch!
numDigitsToClear:= 5 ; Will clear up to a 99999 share order, didn't see any point in going higher.

; Increments number of shares by the amount defined for "increment".
Ctrl & 6::
	; Clicks the quantity field.
	ControlClick, %xCordQuantity% %yCordQuantity%, %windowName%
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
	ControlClick, %xCordQuantity% %yCordQuantity%, %windowName%
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
	ControlClick, %xCordBuyButton% %yCordBuyButton%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCordConfirmButton% %yCordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a buy order at bid.
Ctrl & 5::
	; Clicks the bid, which enters that as the order price.
	ControlClick, %xCordBid% %yCordBid%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the buy button.
	ControlClick, %xCordBuyButton% %yCordBuyButton%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCordConfirmButton% %yCordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a sell order at market.
Ctrl & 1::
	; Clicks the sell button
	ControlClick, %xCordSellButton% %yCordSellButtont%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCordConfirmButton% %yCordConfirmButton%, %windowName%
	numShares= 0
Return

; Places a sell order at ask.
Ctrl 2::
	; Clicks the ask, which enters that as the ask price.
	ControlClick, %xCordAsk% %yCordAsk%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the sell button
	ControlClick, %xCordSellButton% %yCordSellButtont%, %windowName%
	; Delay between clicks can possibly be lowered to 226-229, 225 is too fast.
	Sleep, 230
	; Clicks the confirm button
	ControlClick, %xCordConfirmButton% %yCordConfirmButton%, %windowName%
	numShares= 0
Return

; Clears the quantity field.
Esc::
	; Clicks the quantity field.
	ControlClick, %xCordQuantity% %yCordQuantity%, %windowName%
	Sleep, 25
	Loop, %numDigitsToClear%
	{
		Send {Delete}
	}
	numShares= 0
Return

; Hit ` to exit this program.
`::ExitApp