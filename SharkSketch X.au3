#cs ----------------------------------------------------------------------------

	SharkSketch™ v2020
	Author: SJ Spar7an
	Last updated on 5/12/2020

	Script Function:
	Draws text and symbols onto the screen.

#ce ----------------------------------------------------------------------------

#include <Array.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <Math.au3>
#include <Misc.au3>
#include <StaticConstants.au3>
#include <TrayConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $ProgramName = "SharkSketch™ 2020"
Global $file = "draw_example.txt"
Global $filehnd = FileOpen($file, 0)
Global $filename = StringSplit($file, ".")
Global $i = 0
Global $totallines = 0

Global $category = "Text"
Global $delayDraw = 5
Global $sizeDraw = 9
Global $orientation = "Normal"
Global $arrays = "Standard"
Global $active = 0
Global $Aborted = 0
Global $Paused = False
Global $circlestate = 0
Global $skip = 0

Global $x = 1
Global $y = 1
Global $h = 1
Global $v = 1
Global $actualsize = 1
Global $pi = 4 * ATan(1)
Global Const $e = 2.71828182845904523536
Global $radiusSize = 50
Global $radiusSpeed = 8
Global $circleSize = 50
Global $RTard = 1

Global $pos = MouseGetPos()
Global $pose = MouseGetPos()
Global $cgp = MouseGetPos()
Global $xOne = $pos[0]
Global $yOne = $pos[1]
Global $xTwo = $pos[0]
Global $yTwo = $pos[1]
Global $xFocus = $pos[0]
Global $yFocus = $pos[1]
Global $xTangent = $pos[0]
Global $yTangent = $pos[1]
Global $ovulation = (2 * $pi / 360)
Global $pixelStart = -5
Global $pixelColor = "0xFFFFFF"
Global $endcolor = "0x008080"
Global $randomcolor = "0x008080"
Global $DotColor = 0x0000FF
Global $DotWidth = 10
Global $hotspot = MouseGetPos()
Global $hotspotX = 0
Global $hotspotY = 0
Global $chain = 0
Global $center = MouseGetPos()
Global $slices = 0
Global $start = 180
Global $end = $start - 30
Global $doodle = 0
Global $eyes = 0
Global $steel = 1
Global $hypo = 0
Global $sway = 0
Global $Preferences = 255
Global $PrefSize = 5
Global $PrefDelay = 5
Global $PrefOffset = 10
Global $inputPrefSize = 5
Global $inputPrefDelay = 5
Global $inputPrefOffset = 10
Global $PrefX = 61
Global $PrefY = 48
Global $InputColor = 255
Global $PrefSave = 0
Global $Rows = 4
Global $Columns = 10
Global $Spacing = 60
Global $linecont = 1
Global $spectrum = 0

Global $dll = DllOpen("user32.dll")
Global $aCPos = ControlGetPos("[CLASS:Shell_TrayWnd]", "", "")
Global $aTaskbar = WinGetPos("[CLASS:Shell_TrayWnd]", "")
Global $offset = 10

HotKeySet("{F10}", "close")
HotKeySet("{END}", "close")
HotKeySet("{ESC}", "draw_circust")
HotKeySet("{PAUSE}", "pause")

HotKeySet("{HOME}", "circled")
HotKeySet("{PGDN}", "hide")
HotKeySet("{PGUP}", "unhide")
HotKeySet("!{UP}", "holdUp")
HotKeySet("!{DOWN}", "holdDown")
HotKeySet("!{LEFT}", "calibrate")
HotKeySet("!{RIGHT}", "calibrate")
HotKeySet("^{LEFT}", "calibrate")
HotKeySet("^{RIGHT}", "calibrate")
HotKeySet("{`}", "vertsway")
HotKeySet("!{`}", "sidesway")
HotKeySet("!{~}", "calibrate")
HotKeySet("{~}", "colorDropper")
HotKeySet("{F1}", "categoryText")
HotKeySet("{F2}", "categorySymbols")
HotKeySet("{F3}", "categoryPeople")
HotKeySet("{F4}", "categoryAnatomy")
HotKeySet("{F5}", "categoryCreatures")
HotKeySet("{F6}", "categoryDevices")
HotKeySet("{F7}", "categoryStructures")
HotKeySet("{F8}", "categoryFood")
HotKeySet("{F9}", "Inscribe")
HotKeySet("{F11}", "abort")

HotKeySet("!{NUMPADADD}", "sizeBigger")
HotKeySet("!{NUMPADSUB}", "sizeSmaller")
HotKeySet("!{NUMPADMULT}", "input_numpadMultiply")
HotKeySet("!{NUMPADDIV}", "input_numpadDivide")

HotKeySet("!{NUMPAD1}", "ArrayRotasis")
HotKeySet("!{NUMPAD2}", "input_numpad2")
HotKeySet("!{NUMPAD3}", "ArrayRotato")
HotKeySet("!{NUMPAD4}", "input_numpad4")
HotKeySet("!{NUMPAD5}", "control_numpad5")
HotKeySet("!{NUMPAD6}", "input_numpad6")
HotKeySet("!{NUMPAD7}", "ArrayRotated")
HotKeySet("!{NUMPAD8}", "input_numpad8")
HotKeySet("!{NUMPAD9}", "ArrayRotary")
HotKeySet("!{NUMPAD0}", "input_numpad0")

HotKeySet("^{NUMPAD1}", "orientationUpsideDown")
HotKeySet("^{NUMPAD3}", "orientationBackFlip")
HotKeySet("^{NUMPAD5}", "control_numpad5")
HotKeySet("^{NUMPAD7}", "orientationNormal")
HotKeySet("^{NUMPAD9}", "orientationBackwards")
HotKeySet("^{NUMPAD0}", "input_numpad0")

HotKeySet("^{NUMPADADD}", "sizeBigger")
HotKeySet("^{NUMPADSUB}", "sizeSmaller")
HotKeySet("^{NUMPADMULT}", "input_numpadMultiply")
HotKeySet("^{NUMPADDIV}", "input_numpadDivide")

HotKeySet("!{NUMPADDOT}", "GridSettings")
HotKeySet("^{NUMPADDOT}", "input_numpadDot")

HotKeySet("!{SPACE}", "input_space")
HotKeySet("!{a}", "input_a")
HotKeySet("!{A}", "input_ShiftA")
HotKeySet("!{b}", "input_b")
HotKeySet("!{B}", "input_ShiftB")
HotKeySet("!{C}", "input_ShiftC")
HotKeySet("!{c}", "input_c")
HotKeySet("!{d}", "input_d")
HotKeySet("!{D}", "input_ShiftD")
HotKeySet("!{e}", "input_e")
HotKeySet("!{E}", "input_ShiftE")
HotKeySet("!{f}", "input_f")
HotKeySet("!{F}", "input_ShiftF")
HotKeySet("!{g}", "input_g")
HotKeySet("!{G}", "input_ShiftG")
HotKeySet("!{h}", "input_h")
HotKeySet("!{H}", "input_ShiftH")
HotKeySet("!{i}", "input_i")
HotKeySet("!{j}", "input_j")
HotKeySet("!{k}", "input_k")
HotKeySet("!{l}", "input_l")
HotKeySet("!{m}", "input_m")
HotKeySet("!{n}", "input_n")
HotKeySet("!{o}", "input_o")
HotKeySet("!{S}", "input_ShiftO")
HotKeySet("!{p}", "input_p")
HotKeySet("!{P}", "input_ShiftP")
HotKeySet("!{q}", "input_q")
HotKeySet("!{r}", "input_r")
HotKeySet("!{s}", "input_s")
HotKeySet("!{S}", "input_ShiftS")
HotKeySet("!{t}", "input_t")
HotKeySet("!{u}", "input_u")
HotKeySet("!{v}", "input_v")
HotKeySet("!{w}", "input_w")
HotKeySet("!{x}", "input_x")
HotKeySet("!{X}", "input_ShiftX")
HotKeySet("!{y}", "input_y")
HotKeySet("!{z}", "input_z")

HotKeySet("^{SPACE}", "input_space")
HotKeySet("^{a}", "input_a")
HotKeySet("^{A}", "input_ShiftA")
HotKeySet("^{b}", "input_b")
HotKeySet("^{B}", "input_ShiftB")
HotKeySet("^{C}", "input_ShiftC")
HotKeySet("^{c}", "input_c")
HotKeySet("^{d}", "input_d")
HotKeySet("^{D}", "input_ShiftD")
HotKeySet("^{e}", "input_e")
HotKeySet("^{E}", "input_ShiftE")
HotKeySet("^{f}", "input_f")
HotKeySet("^{F}", "input_ShiftF")
HotKeySet("^{g}", "input_g")
HotKeySet("^{G}", "input_ShiftG")
HotKeySet("^{h}", "input_h")
HotKeySet("^{H}", "input_ShiftH")
HotKeySet("^{i}", "input_i")
HotKeySet("^{j}", "input_j")
HotKeySet("^{k}", "input_k")
HotKeySet("^{l}", "input_l")
HotKeySet("^{m}", "input_m")
HotKeySet("^{n}", "input_n")
HotKeySet("^{o}", "input_o")
HotKeySet("^{O}", "input_ShiftO")
HotKeySet("^{p}", "input_p")
HotKeySet("^{P}", "input_ShiftP")
HotKeySet("^{q}", "input_q")
HotKeySet("^{r}", "input_r")
HotKeySet("^{s}", "input_s")
HotKeySet("^{S}", "input_ShiftS")
HotKeySet("^{t}", "input_t")
HotKeySet("^{u}", "input_u")
HotKeySet("^{v}", "input_v")
HotKeySet("^{w}", "input_w")
HotKeySet("^{x}", "input_x")
HotKeySet("^{X}", "input_ShiftX")
HotKeySet("^{y}", "input_y")
HotKeySet("^{z}", "input_z")

HotKeySet("!{0}", "input_0")
HotKeySet("!{1}", "input_1")
HotKeySet("!{2}", "input_2")
HotKeySet("!{3}", "input_3")
HotKeySet("!{4}", "input_4")
HotKeySet("!{5}", "input_5")
HotKeySet("!{6}", "input_6")
HotKeySet("!{7}", "input_7")
HotKeySet("!{8}", "input_8")
HotKeySet("!{9}", "input_9")

HotKeySet("^{0}", "input_0")
HotKeySet("^{1}", "input_1")
HotKeySet("^{2}", "input_2")
HotKeySet("^{3}", "input_3")
HotKeySet("^{4}", "input_4")
HotKeySet("^{5}", "input_5")
HotKeySet("^{6}", "input_6")
HotKeySet("^{7}", "input_7")
HotKeySet("^{8}", "input_8")
HotKeySet("^{9}", "input_9")

HotKeySet("!{'}", "input_apostrophe")
HotKeySet("!{*}", "input_asterisk")
HotKeySet("!{@}", "input_at")
HotKeySet("!{[}", "input_bracketLeft")
HotKeySet("!{]}", "input_bracketRight")
HotKeySet("!{^}", "input_caret")
HotKeySet("!{:}", "input_colon")
HotKeySet("!{,}", "input_comma")
HotKeySet("!{$}", "input_dollar")
HotKeySet("!{=}", "input_equal")
HotKeySet("!{!}", "input_exclamation")
HotKeySet("!{>}", "input_greater")
HotKeySet("!{<}", "input_less")
HotKeySet("!{-}", "input_minus")
HotKeySet("!{(}", "input_parenthesisLeft")
HotKeySet("!{)}", "input_parenthesisRight")
HotKeySet("!{.}", "input_period")
HotKeySet("!{+}", "input_plus")
HotKeySet("!{#}", "input_pound")
HotKeySet("!{?}", "input_question")
HotKeySet("!{;}", "input_semicolon")
HotKeySet("!{\}", "input_slashBackward")
HotKeySet("!{/}", "input_slashForward")
HotKeySet("!{_}", "input_underscore")
HotKeySet("!{|}", "input_vertical")

HotKeySet("^{'}", "input_apostrophe")
HotKeySet("^{*}", "input_asterisk")
HotKeySet("^{@}", "input_at")
HotKeySet("^{[}", "input_bracketLeft")
HotKeySet("^{]}", "input_bracketRight")
HotKeySet("^{^}", "input_caret")
HotKeySet("^{:}", "input_colon")
HotKeySet("^{,}", "input_comma")
HotKeySet("^{$}", "input_dollar")
HotKeySet("^{=}", "input_equal")
HotKeySet("^{!}", "input_exclamation")
HotKeySet("^{>}", "input_greater")
HotKeySet("^{<}", "input_less")
HotKeySet("^{-}", "input_minus")
HotKeySet("^{(}", "input_parenthesisLeft")
HotKeySet("^{)}", "input_parenthesisRight")
HotKeySet("^{.}", "input_period")
HotKeySet("^{+}", "input_plus")
HotKeySet("^{#}", "input_pound")
HotKeySet("^{?}", "input_question")
HotKeySet("^{;}", "input_semicolon")
HotKeySet("^{\}", "input_slashBackward")
HotKeySet("^{/}", "input_slashForward")
HotKeySet("^{_}", "input_underscore")
HotKeySet("^{|}", "input_vertical")

HotKeySet("!{INSERT}", "input_insert")
HotKeySet("{INSERT}", "input_insert")
HotKeySet("{SCROLLLOCK}", "input_scroll")
HotKeySet("{CAPSLOCK}", "draw_circoal")

If _Singleton(@ScriptName, 1) = 0 Then
	MsgBox(64, "" & @UserName & "'s Error", "An instance of " & $ProgramName & " is already running.")
	Exit
EndIf

ToolTip("To exit, press F10.", 0, 0)

If Not FileExists(@ScriptDir & "\SharkSketch Preferences.ini") Then
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Draw Size", "9")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Draw Delay", "5")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "SS Window Offset", "10")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Coordinate X", "61")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Coordinate Y", "48")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Use Custom Color", "0")
	IniWrite(@ScriptDir & "\SharkSketch Preferences.ini", "Preferences", "Skip", "0")
EndIf

Global $sizeDraw = IniRead("SharkSketch Preferences.ini", "Preferences", "Draw Size", "")
If $sizeDraw <= 1 And $sizeDraw >= 10 Then
	$sizeDraw = 7
EndIf

Global $delayDraw = IniRead("SharkSketch Preferences.ini", "Preferences", "Draw Delay", "")
If $delayDraw <= 5 And $delayDraw >= 99 Then
	$delayDraw = 5
EndIf

Global $offset = IniRead("SharkSketch Preferences.ini", "Preferences", "SS Window Offset", "")
If $offset < 0 And $offset > @DesktopHeight Then
	$offset = 10
EndIf

Global $PrefX = IniRead("SharkSketch Preferences.ini", "Preferences", "Coordinate X", "")
If $PrefX < 0 Then
	$PrefX = 0
EndIf

Global $PrefY = IniRead("SharkSketch Preferences.ini", "Preferences", "Coordinate Y", "")
If $PrefY < 0 Then
	$PrefY = 0
EndIf

Global $skip = IniRead("SharkSketch Preferences.ini", "Preferences", "Skip", "")
If $skip < 0 Then
	$skip = 0
	If $skip > 1 Then
		$skip = 1
	EndIf
EndIf

$SSMain = GUICreate("SharkSketch™ 2020", 230, 155, @DesktopWidth - 230, (@DesktopHeight - 155 - $aTaskbar[3]) - $offset, _
		BitOR($WS_MINIMIZEBOX, $WS_SYSMENU, $WS_DLGFRAME, $WS_POPUP, $WS_GROUP, $WS_CLIPSIBLINGS), _
		BitOR($WS_EX_OVERLAPPEDWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
$customcolor = IniRead("SharkSketch Preferences.ini", "Preferences", "Use Custom Color", "")
If $customcolor = 1 Then
	$endcolor = IniRead("SharkSketch Preferences.ini", "Preferences", "Color Code", "")
Else
	$randomcolor = Random(0xFFFFFF, 0x2B1B1B1, 0)
	$endcolor = "0x" & Hex($randomcolor, 6)
EndIf
GUISetBkColor($endcolor)

$MenuItem1 = GUICtrlCreateMenu("&File")
$FileHide = GUICtrlCreateMenuItem("Hide", $MenuItem1)
$FilePause = GUICtrlCreateMenuItem("Pause", $MenuItem1)
$FileRestart = GUICtrlCreateMenuItem("Restart", $MenuItem1)
$FileExit = GUICtrlCreateMenuItem("Exit", $MenuItem1)

$MenuItem2 = GUICtrlCreateMenu("&Help")
$MenuPreference = GUICtrlCreateMenuItem("Preferences", $MenuItem2)
$HelpFile = GUICtrlCreateMenuItem("Hotkey List", $MenuItem2)
$AboutSS = GUICtrlCreateMenuItem("About", $MenuItem2)

$Label1 = GUICtrlCreateLabel("Category:", 20, 20, 100, 20)
GUICtrlSetFont(-1, 12, 800, 0, "Californian FB")
$inputCategory = GUICtrlCreateCombo("", 110, 20, 100, 20, _
		BitOR($WS_VSCROLL, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "Text|Symbols|People|" & @UserName & "'s Anatomy|Creatures|Devices|Structures|Food", "Text")

$Label2 = GUICtrlCreateLabel("Orientation:", 20, 40, 100, 20)
GUICtrlSetFont(-1, 12, 800, 0, "Californian FB")
$inputOrientation = GUICtrlCreateCombo("", 110, 40, 100, 20, _
		BitOR($WS_VSCROLL, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "Normal|Backwards|Upside Down|Back Flip|Rotary|Rotated|Rotasis|Rotato|", "Normal")

$Label3 = GUICtrlCreateLabel("Draw Size:", 20, 60, 100, 20)
GUICtrlSetFont(-1, 12, 800, 0, "Californian FB")
$inputSize = GUICtrlCreateInput("", 110, 60, 100, 20, $ES_NUMBER)
GUICtrlSetLimit(-1, 2)
GUICtrlSetData($inputSize, $sizeDraw)

$Label4 = GUICtrlCreateLabel($filename[1] & "", 20, 80, 190, 20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 800, 0, "Californian FB")
GUICtrlSetBkColor($Label4, 0xFFFFFF)

$Label5 = GUICtrlCreateProgress(20, 100, 190, 5, $PBS_SMOOTH)

$buttonApply = GUICtrlCreateButton("Apply All", 120, 105, 90, 20)
GUICtrlSetCursor(-1, 0)

$buttonDefault = GUICtrlCreateButton("Default", 20, 105, 90, 20)
GUICtrlSetCursor(-1, 0)

$Group1 = GUICtrlCreateGroup("Draw Settings", 10, 5, 210, 125)
GUICtrlSetColor(-1, 0x008080)

GUISetState(@SW_SHOW, $SSMain)

$sMyAppPath = @AppDataDir & "\Team 117\SharkSketch\"
If Not FileExists($sMyAppPath) Then DirCreate($sMyAppPath)
FileInstall("SharkSketch Hotkeys.pdf", $sMyAppPath & "SharkSketch Hotkeys.pdf", 1)
$About = GUICreate("About SharkSketch™", 300, 343)
Global $aboutTitle = "SharkSketch™ 2020"
GUISetFont(20, 400, 4, "Comic Sans MS")
GUICtrlCreateLabel($aboutTitle, 15, 20, 320, 45)
$coolor = 0x003333
GUICtrlSetColor(-1, $coolor)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
Global $aboutDate = "Last Updated: 5/12/20"
GUISetFont(16, 400, 0, "Times New Roman")
GUICtrlCreateLabel($aboutDate, 15, 80, 320, 45)
$coolor = 0xFF9900
GUICtrlSetColor(-1, $coolor)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
Global $aboutDescription = "A macro drawing program."
GUISetFont(16, 400, 0, "Times New Roman")
GUICtrlCreateLabel($aboutDescription, 15, 120, 320, 45)
$coolor = 0x00FFFF
GUICtrlSetColor(-1, $coolor)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
Global $aboutCredits = "Special thanks to SJ Spar7an and " & @UserName & " for making this possible!"
GUISetFont(16, 400, 0, "Times New Roman")
GUICtrlCreateLabel($aboutCredits, 15, 160, 320, 45)
$coolor = 0x00FF00
GUICtrlSetColor(-1, $coolor)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

$PrefSize = 5
$PrefDelay = 5
$PrefOffset = 10

$Preferences = GUICreate("User Preferences", 200, 320, -1, -1, _
		BitOR($WS_SYSMENU, $WS_CAPTION))

$inputPrefSize = GUICtrlCreateInput($PrefSize, 10, 30, 180, 21, $ES_NUMBER)
GUICtrlSetLimit($inputPrefSize, 2)
GUICtrlSetData($inputPrefSize, IniRead("SharkSketch Preferences.ini", "Preferences", "Draw Size", ""))

$inputPrefDelay = GUICtrlCreateInput($PrefDelay, 10, 80, 180, 21, $ES_NUMBER)
GUICtrlSetLimit($inputPrefDelay, 2)
GUICtrlSetData($inputPrefDelay, IniRead("SharkSketch Preferences.ini", "Preferences", "Draw Delay", ""))

$inputPrefOffset = GUICtrlCreateInput($PrefOffset, 10, 130, 180, 21, $ES_NUMBER)
GUICtrlSetLimit($inputPrefOffset, 4)
GUICtrlSetData($inputPrefOffset, IniRead("SharkSketch Preferences.ini", "Preferences", "SS Window Offset", ""))
If $inputPrefOffset > @DesktopHeight * 0.8 Then
	ConsoleWrite($inputPrefOffset)
	$inputPrefOffset = @DesktopHeight * 0.8
	GUICtrlSetData($inputPrefOffset, $PrefOffset)
	IniWrite("SharkSketch Preferences.ini", "Preferences", "SS Window Offset", $PrefOffset)
EndIf

$inputPrefX = GUICtrlCreateInput($PrefX, 20, 180, 30, 21, $ES_NUMBER)
GUICtrlSetLimit($inputPrefX, 4)
GUICtrlSetData($inputPrefX, IniRead("SharkSketch Preferences.ini", "Preferences", "Coordinate X", ""))

$inputPrefY = GUICtrlCreateInput($PrefY, 70, 180, 30, 21, $ES_NUMBER)
GUICtrlSetLimit($inputPrefY, 4)
GUICtrlSetData($inputPrefY, IniRead("SharkSketch Preferences.ini", "Preferences", "Coordinate Y", ""))

GUICtrlCreateLabel("Draw Size (1-11)", 10, 10, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "The preset scale for the distance between coordinates when drawing (bigger is larger)." & @CRLF & "(e.g., 3 = 0.6x, 5 = 1x, 7 = 2x, 10 = 4x, etc.)")

GUICtrlCreateLabel("Draw Delay (5-99)", 10, 60, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "The amount of time (ms) to wait between drawing actions (smaller is faster).")

GUICtrlCreateLabel("SS Window Offset (10?)", 10, 110, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "The amount of pixels up off the Windows Taskbar that the main " & $ProgramName & " GUI shall be placed.")

GUICtrlCreateLabel("Homing Coordinates", 10, 160, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "The specified coordinates to move the cursor to when the homing hotkey is pressed.")

GUICtrlCreateLabel("x:", 10, 180, 10, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")

GUICtrlCreateLabel("y:", 60, 180, 10, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")

$ColorEnable = GUICtrlCreateCheckbox("Enable Color Preference", 10, 210, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "Changes background color of the " & $ProgramName & " GUI [HEX-6]." & @CRLF & "(e.g., Teal = 008080, Snowy Mint = D1FEC5, Orange = FFA500, etc.)")
$customcolor = IniRead("SharkSketch Preferences.ini", "Preferences", "Use Custom Color", "")
If $customcolor = 1 Then
	GUICtrlSetState($ColorEnable, $GUI_CHECKED)
	GUICtrlSetState($InputColor, $GUI_ENABLE)
Else
	GUICtrlSetState($ColorEnable, $GUI_UNCHECKED)
	GUICtrlSetState($InputColor, $GUI_DISABLE)
EndIf

$InputColor = GUICtrlCreateInput(Hex($endcolor, 6), 10, 230, 180, 21, $ES_UPPERCASE)
GUICtrlSetLimit(-1, 6)

$skipbox = GUICtrlCreateCheckbox("Skip Draw Confirmation", 10, 255, 180, 17)
GUICtrlSetFont(-1, 10, 800, 0, "Californian FB")
GUICtrlSetTip(-1, "If checked, cursor immediately starts drawing upon hotkey press.")
$skip = IniRead("SharkSketch Preferences.ini", "Preferences", "Skip", "")
If $skip = 1 Then
	GUICtrlSetState($skipbox, $GUI_CHECKED)
Else
	GUICtrlSetState($skipbox, $GUI_UNCHECKED)
EndIf

$PrefSave = GUICtrlCreateButton("Save Preferences", 10, 280, 180, 30)

GUISetState(@SW_HIDE, $Preferences)

$Rows = 7
$Columns = 7
$Spacing = 20
Call("Sizing")

$GridSettings = GUICreate("Grid Settings", 200, 200, -1, -1, _
		BitOR($WS_SYSMENU, $WS_CAPTION))
$inputRows = GUICtrlCreateInput($Rows, 10, 30, 180, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 2)
$inputColumns = GUICtrlCreateInput($Columns, 10, 80, 180, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 2)
$inputSpacing = GUICtrlCreateInput($Spacing, 10, 130, 180, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)
GUICtrlCreateLabel("Number of Rows", 10, 10, 180, 17)
GUICtrlCreateLabel("Number of Columns", 10, 60, 180, 17)
GUICtrlCreateLabel("Line Spacing", 10, 110, 180, 17)
$gsOK = GUICtrlCreateButton("Apply Settings", 10, 160, 180, 30)
GUISetState(@SW_HIDE, $GridSettings)

While 1

	$nMsg = GUIGetMsg()

	If $nMsg = $FileHide Then hide()

	If $nMsg = $FilePause Then pauser()

	If $nMsg = $FileRestart Then restart()

	If $nMsg = $FileExit Then close()

	If $nMsg = $MenuPreference Then Preference()

	If $nMsg = $HelpFile Then helpfile()

	If $nMsg = $AboutSS Then aboutss()

	If $nMsg = $buttonApply Then

		$category = GUICtrlRead($inputCategory)

		$sizeDraw = GUICtrlRead($inputSize)
		Select
			Case $sizeDraw < 1
				$sizeDraw = 1
				GUICtrlSetData($inputSize, $sizeDraw)
		EndSelect
		Call("Sizing")

		$orientation = GUICtrlRead($inputOrientation)
		Call("Orientationing")

		TrayTip("", "Draw settings applied.", 2, 16)

	EndIf

	If $nMsg = $buttonDefault Then
		$category = "Text"
		GUICtrlSetData($inputCategory, $category)
		$delayDraw = 5
		$sizeDraw = 5
		$x = 1
		$y = 1
		GUICtrlSetData($inputSize, $sizeDraw)
		$orientation = "Normal"
		$h = 1
		$v = 1
		$arrays = "Standard"
		GUICtrlSetData($inputOrientation, $orientation)
		$radiusSize = 50
		$radiusSpeed = 5
		$circleSize = 50
		$RTard = 1
		$active = 0
		$circlestate = 0
		$Aborted = 1
		$pixelColor = 0xFFFFFF
		GUISetBkColor(0x00CCCC)
		WinSetTrans($SSMain, "", 255)
		GUISetState(@SW_SHOW, $SSMain)
		TrayTip("", "Draw settings set to default.", 2, 16)
	EndIf

	If $nMsg = -3 Then
		SoundPlay("")
		GUISetState(@SW_HIDE, $About)
	EndIf

	Switch $nMsg
		Case $PrefSave

			$PrefSize = GUICtrlRead($inputPrefSize)
			$PrefDelay = GUICtrlRead($inputPrefDelay)
			$PrefOffset = GUICtrlRead($inputPrefOffset)
			$PrefX = GUICtrlRead($inputPrefX)
			$PrefY = GUICtrlRead($inputPrefY)
			GUISetState(@SW_HIDE, $Preferences)
			GUICtrlSetState($MenuPreference, $GUI_ENABLE)

			Select
				Case $PrefSize < 1
					$PrefSize = 1
					GUICtrlSetData($inputPrefSize, $PrefSize)
				Case $PrefSize > 11
					$PrefSize = 11
					GUICtrlSetData($inputPrefSize, $PrefSize)
			EndSelect

			Select
				Case $PrefDelay < 5
					$PrefDelay = 5
					GUICtrlSetData($inputPrefDelay, $PrefDelay)
				Case $PrefDelay > 99
					$PrefDelay = 99
					GUICtrlSetData($inputPrefDelay, $PrefDelay)
			EndSelect

			Select
				Case $PrefOffset < 0
					$PrefOffset = 0
					GUICtrlSetData($inputPrefOffset, $PrefOffset)
				Case $PrefOffset > @DesktopHeight * 0.8
					$PrefOffset = @DesktopHeight * 0.8
					GUICtrlSetData($inputPrefOffset, $PrefOffset)
			EndSelect

			Select
				Case $PrefX < 0
					$PrefX = 0
					GUICtrlSetData($inputPrefX, $PrefX)
			EndSelect

			Select
				Case $PrefY < 0
					$PrefY = 0
					GUICtrlSetData($inputPrefY, $PrefY)
			EndSelect

			Select
				Case $ColorEnable
					If GUICtrlRead($ColorEnable) = 1 Then
						GUICtrlSetState($InputColor, $GUI_ENABLE)
						IniWrite("SharkSketch Preferences.ini", "Preferences", "Use Custom Color", 1)
						IniWrite("SharkSketch Preferences.ini", "Preferences", "Color Code", "0x" & GUICtrlRead($InputColor))
						GUISetBkColor("0x" & GUICtrlRead($InputColor))
						$endcolor = ("0x" & GUICtrlRead($InputColor))
					Else
						GUICtrlSetState($InputColor, $GUI_DISABLE)
						IniWrite("SharkSketch Preferences.ini", "Preferences", "Use Custom Color", 0)
					EndIf
			EndSelect

			Select
				Case $skipbox
					If GUICtrlRead($skipbox) = 1 Then
						IniWrite("SharkSketch Preferences.ini", "Preferences", "Skip", 1)
						$skip = 1
					Else
						IniWrite("SharkSketch Preferences.ini", "Preferences", "Skip", 0)
						$skip = 0
					EndIf
			EndSelect

			IniWrite("SharkSketch Preferences.ini", "Preferences", "Draw Size", GUICtrlRead($inputPrefSize))
			IniWrite("SharkSketch Preferences.ini", "Preferences", "Draw Delay", GUICtrlRead($inputPrefDelay))
			IniWrite("SharkSketch Preferences.ini", "Preferences", "SS Window Offset", GUICtrlRead($inputPrefOffset))
			IniWrite("SharkSketch Preferences.ini", "Preferences", "Coordinate X", GUICtrlRead($inputPrefX))
			IniWrite("SharkSketch Preferences.ini", "Preferences", "Coordinate Y", GUICtrlRead($inputPrefY))
			$sizeDraw = $PrefSize
			$delayDraw = $PrefDelay
			$offset = $PrefOffset
			Call("Sizing")
			GUICtrlSetData($inputSize, $sizeDraw)
			GUISetBkColor("0x" & GUICtrlRead($InputColor))
			GUISetBkColor("0x" & GUICtrlRead($InputColor), $SSMain)

		Case $GUI_EVENT_CLOSE
			GUICtrlSetData($inputPrefSize, $sizeDraw)
			GUICtrlSetData($inputPrefDelay, $delayDraw)
			GUICtrlSetData($inputPrefOffset, $offset)
			GUICtrlSetData($inputPrefX, $PrefX)
			GUICtrlSetData($inputPrefY, $PrefY)
			$customcolor = IniRead("SharkSketch Preferences.ini", "Preferences", "Use Custom Color", "")
			If $customcolor = 1 Then
				GUICtrlSetState($ColorEnable, $GUI_CHECKED)
				GUICtrlSetState($InputColor, $GUI_ENABLE)
			Else
				GUICtrlSetState($ColorEnable, $GUI_UNCHECKED)
				GUICtrlSetState($InputColor, $GUI_DISABLE)
			EndIf
			GUICtrlSetData($InputColor, Hex($endcolor, 6))
			$skip = IniRead("SharkSketch Preferences.ini", "Preferences", "Skip", "")
			If $skip = 1 Then
				GUICtrlSetState($skipbox, $GUI_CHECKED)
			Else
				GUICtrlSetState($skipbox, $GUI_UNCHECKED)
			EndIf
			WinSetOnTop("User Preferences", "", $WINDOWS_NOONTOP)
			GUISetState(@SW_HIDE, $Preferences)
			GUICtrlSetState($MenuPreference, $GUI_ENABLE)
	EndSwitch

	Switch $nMsg
		Case $gsOK

			$Rows = GUICtrlRead($inputRows)
			$Columns = GUICtrlRead($inputColumns)
			$Spacing = GUICtrlRead($inputSpacing)
			GUISetState(@SW_HIDE, $GridSettings)

			Select
				Case $Rows < 1
					$Rows = 1
					GUICtrlSetData($inputRows, $Rows)
			EndSelect

			Select
				Case $Columns < 1
					$Columns = 1
					GUICtrlSetData($inputColumns, $Columns)
			EndSelect

			Select
				Case $Spacing < 1
					$Spacing = 1
					GUICtrlSetData($inputSpacing, $Spacing)
			EndSelect

		Case $GUI_EVENT_CLOSE
			GUICtrlSetData($inputRows, $Rows)
			GUICtrlSetData($inputColumns, $Columns)
			GUICtrlSetData($inputSpacing, $Spacing)
			GUISetState(@SW_HIDE, $GridSettings)
	EndSwitch
WEnd

Func Sizing()
	Select
		Case $sizeDraw < 1
			$x = 0.2
			$y = 0.2
			$actualsize = 0.2
		Case $sizeDraw = 1
			$x = 0.2
			$y = 0.2
			$actualsize = 0.2
		Case $sizeDraw = 2
			$x = 0.4
			$y = 0.4
			$actualsize = 0.4
		Case $sizeDraw = 3
			$x = 0.6
			$y = 0.6
			$actualsize = 0.6
		Case $sizeDraw = 4
			$x = 0.8
			$y = 0.8
			$actualsize = 0.8
		Case $sizeDraw = 5
			$x = 1
			$y = 1
			$actualsize = 1
		Case $sizeDraw = 6
			$x = 1.5
			$y = 1.5
			$actualsize = 1.5
		Case $sizeDraw = 7
			$x = 2
			$y = 2
			$actualsize = 2
		Case $sizeDraw = 8
			$x = 2.5
			$y = 2.5
			$actualsize = 2.5
		Case $sizeDraw = 9
			$x = 3
			$y = 3
			$actualsize = 3
		Case $sizeDraw = 10
			$x = 4
			$y = 4
			$actualsize = 4
		Case $sizeDraw > 10
			$x = 5
			$y = 5
			$actualsize = 5
	EndSelect
EndFunc   ;==>Sizing

Func Orientationing()
	Select
		Case $orientation = "Normal"
			$h = 1
			$v = 1
			$arrays = "Standard"
		Case $orientation = "Backwards"
			$h = -1
			$v = 1
		Case $orientation = "Upside Down"
			$h = 1
			$v = -1
		Case $orientation = "Back Flip"
			$h = -1
			$v = -1
		Case $orientation = "Rotary"
			$arrays = "Rotary"
		Case $orientation = "Rotated"
			$arrays = "Rotated"
		Case $orientation = "Rotasis"
			$arrays = "Rotasis"
		Case $orientation = "Rotato"
			$arrays = "Rotato"
	EndSelect
EndFunc   ;==>Orientationing

Func Preference()
	GUICtrlSetState($MenuPreference, $GUI_DISABLE)
	GUISetState(@SW_SHOW, $Preferences)
	WinSetOnTop($Preferences, "", $WINDOWS_ONTOP)
EndFunc   ;==>Preference

Func helpfile()
	ShellExecute($sMyAppPath & "SharkSketch Hotkeys.pdf")
	If FileExists($sMyAppPath & "SharkSketch Hotkeys.pdf") = 0 Then
		TrayTip("", "SharkSketch Hotkeys.pdf not found! :(", 2, 16)
	EndIf
EndFunc   ;==>helpfile

Func aboutss()
	GUISetState(@SW_SHOW, $About)
EndFunc   ;==>aboutss

Func GridSettings()
	GUISetState(@SW_SHOW, $GridSettings)
EndFunc   ;==>GridSettings

Func hide()
	GUISetState(@SW_HIDE, $SSMain)
	ToolTip("")
	TrayTip("", "Press PAGE UP to unhide SharkSketch™.", 2, 16)
EndFunc   ;==>hide

Func unhide()
	$prevcolor = $endcolor
	GUISetBkColor("0x" & GUICtrlRead($InputColor), "$Preferences")
	GUISetBkColor($prevcolor, "$Preferences")
	GUISetState(@SW_SHOW, $SSMain)
	TrayTip("", "Press PAGE DOWN to hide SharkSketch™.", 2, 16)
EndFunc   ;==>unhide

Func holdUp()
	MouseUp("primary")
	TrayTip("", "Primary mouse button released.", 2, 16)
EndFunc   ;==>holdUp

Func holdDown()
	MouseDown("primary")
	TrayTip("", "Primary mouse button held down.", 2, 16)
EndFunc   ;==>holdDown

Func circled()
	$circlestate = 0
	$center = MouseGetPos()
	Call("control_numpad5")
EndFunc   ;==>circled

Func vertsway()
	$pos = MouseGetPos()
	$sway = $sway + 1
	Select
		Case $sway = 1
			MouseMove($pos[0] - $h * $x * 0, $pos[1] - $v * $y * 20, 1)
		Case $sway = 2
			MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 20, 1)
			$sway = 0
		Case Else
			$sway = 0
	EndSelect
EndFunc   ;==>vertsway

Func sidesway()
	$pos = MouseGetPos()
	$sway = $sway + 1
	Select
		Case $sway = 1
			MouseMove($pos[0] - $h * $x * 20, $pos[1] - $v * $y * 0, 1)
		Case $sway = 2
			MouseMove($pos[0] + $h * $x * 20, $pos[1] + $v * $y * 0, 1)
			$sway = 0
		Case Else
			$sway = 0
	EndSelect
EndFunc   ;==>sidesway

Func calibrate()
	MouseMove($PrefX, $PrefY, 0)
EndFunc   ;==>calibrate

Func colorDropper()
	$pos = MouseGetPos()
	$pixelColor = PixelGetColor($pos[0], $pos[1])
	GUISetBkColor($pixelColor)
	TrayTip("", "Pixel calibration color set to " & Hex($pixelColor, 6) & "", 2, 16)
	ToolTip("Pixel calibration color set to " & Hex($pixelColor, 6), 0, 0)
	GUISetState(@SW_SHOW, $SSMain)
EndFunc   ;==>colorDropper

Func pause()
	$Paused = Not $Paused
	MouseUp("primary")

	HotKeySet("{PGDN}", "funcDraw")
	HotKeySet("{PGUP}", "funcDraw")
	HotKeySet("!{UP}", "funcDraw")
	HotKeySet("!{DOWN}", "funcDraw")
	HotKeySet("{`}", "funcDraw")
	HotKeySet("!{`}", "funcDraw")
	HotKeySet("!{~}", "funcDraw")
	HotKeySet("{~}", "funcDraw")
	HotKeySet("{F1}", "funcDraw")
	HotKeySet("{F2}", "funcDraw")
	HotKeySet("{F3}", "funcDraw")
	HotKeySet("{F4}", "funcDraw")
	HotKeySet("{F5}", "funcDraw")
	HotKeySet("{F6}", "funcDraw")
	HotKeySet("{F7}", "funcDraw")
	HotKeySet("{F8}", "funcDraw")
	HotKeySet("{F9}", "funcDraw")
	HotKeySet("{F11}", "funcDraw")
	HotKeySet("{HOME}", "funcDraw")

	HotKeySet("!{NUMPADADD}", "funcDraw")
	HotKeySet("!{NUMPADSUB}", "funcDraw")
	HotKeySet("!{NUMPADMULT}", "funcDraw")
	HotKeySet("!{NUMPADDIV}", "funcDraw")

	HotKeySet("!{NUMPAD1}", "funcDraw")
	HotKeySet("!{NUMPAD2}", "funcDraw")
	HotKeySet("!{NUMPAD3}", "funcDraw")
	HotKeySet("!{NUMPAD4}", "funcDraw")
	HotKeySet("!{NUMPAD5}", "funcDraw")
	HotKeySet("^{NUMPAD5}", "funcDraw")
	HotKeySet("!{NUMPAD6}", "funcDraw")
	HotKeySet("!{NUMPAD7}", "funcDraw")
	HotKeySet("!{NUMPAD8}", "funcDraw")
	HotKeySet("!{NUMPAD9}", "funcDraw")
	HotKeySet("!{NUMPAD0}", "funcDraw")

	HotKeySet("^{NUMPAD1}", "funcDraw")
	HotKeySet("^{NUMPAD3}", "funcDraw")
	HotKeySet("^{NUMPAD7}", "funcDraw")
	HotKeySet("^{NUMPAD9}", "funcDraw")
	HotKeySet("^{NUMPAD0}", "funcDraw")

	HotKeySet("!{NUMPADDOT}", "funcDraw")
	HotKeySet("^{NUMPADDOT}", "funcDraw")

	HotKeySet("!{SPACE}", "funcDraw")
	HotKeySet("!{a}", "funcDraw")
	HotKeySet("!{A}", "funcDraw")
	HotKeySet("!{b}", "funcDraw")
	HotKeySet("!{B}", "funcDraw")
	HotKeySet("!{c}", "funcDraw")
	HotKeySet("!{C}", "funcDraw")
	HotKeySet("!{d}", "funcDraw")
	HotKeySet("!{D}", "funcDraw")
	HotKeySet("!{e}", "funcDraw")
	HotKeySet("!{E}", "funcDraw")
	HotKeySet("!{f}", "funcDraw")
	HotKeySet("!{F}", "funcDraw")
	HotKeySet("!{g}", "funcDraw")
	HotKeySet("!{G}", "funcDraw")
	HotKeySet("!{h}", "funcDraw")
	HotKeySet("!{H}", "funcDraw")
	HotKeySet("!{i}", "funcDraw")
	HotKeySet("!{j}", "funcDraw")
	HotKeySet("!{k}", "funcDraw")
	HotKeySet("!{l}", "funcDraw")
	HotKeySet("!{m}", "funcDraw")
	HotKeySet("!{n}", "funcDraw")
	HotKeySet("!{o}", "funcDraw")
	HotKeySet("!{O}", "funcDraw")
	HotKeySet("!{p}", "funcDraw")
	HotKeySet("!{P}", "funcDraw")
	HotKeySet("!{q}", "funcDraw")
	HotKeySet("!{r}", "funcDraw")
	HotKeySet("!{s}", "funcDraw")
	HotKeySet("!{S}", "funcDraw")
	HotKeySet("!{t}", "funcDraw")
	HotKeySet("!{u}", "funcDraw")
	HotKeySet("!{v}", "funcDraw")
	HotKeySet("!{w}", "funcDraw")
	HotKeySet("!{x}", "funcDraw")
	HotKeySet("!{X}", "funcDraw")
	HotKeySet("!{y}", "funcDraw")
	HotKeySet("!{z}", "funcDraw")

	HotKeySet("^{SPACE}", "funcDraw")
	HotKeySet("^{a}", "funcDraw")
	HotKeySet("^{A}", "funcDraw")
	HotKeySet("^{b}", "funcDraw")
	HotKeySet("^{B}", "funcDraw")
	HotKeySet("^{c}", "funcDraw")
	HotKeySet("^{C}", "funcDraw")
	HotKeySet("^{d}", "funcDraw")
	HotKeySet("^{D}", "funcDraw")
	HotKeySet("^{e}", "funcDraw")
	HotKeySet("^{E}", "funcDraw")
	HotKeySet("^{f}", "funcDraw")
	HotKeySet("^{F}", "funcDraw")
	HotKeySet("^{g}", "funcDraw")
	HotKeySet("^{G}", "funcDraw")
	HotKeySet("^{h}", "funcDraw")
	HotKeySet("^{H}", "funcDraw")
	HotKeySet("^{i}", "funcDraw")
	HotKeySet("^{j}", "funcDraw")
	HotKeySet("^{k}", "funcDraw")
	HotKeySet("^{l}", "funcDraw")
	HotKeySet("^{m}", "funcDraw")
	HotKeySet("^{n}", "funcDraw")
	HotKeySet("^{o}", "funcDraw")
	HotKeySet("^{O}", "funcDraw")
	HotKeySet("^{p}", "funcDraw")
	HotKeySet("^{P}", "funcDraw")
	HotKeySet("^{q}", "funcDraw")
	HotKeySet("^{r}", "funcDraw")
	HotKeySet("^{s}", "funcDraw")
	HotKeySet("^{S}", "funcDraw")
	HotKeySet("^{t}", "funcDraw")
	HotKeySet("^{u}", "funcDraw")
	HotKeySet("^{v}", "funcDraw")
	HotKeySet("^{w}", "funcDraw")
	HotKeySet("^{x}", "funcDraw")
	HotKeySet("^{X}", "funcDraw")
	HotKeySet("^{y}", "funcDraw")
	HotKeySet("^{z}", "funcDraw")

	HotKeySet("!{0}", "funcDraw")
	HotKeySet("!{1}", "funcDraw")
	HotKeySet("!{2}", "funcDraw")
	HotKeySet("!{3}", "funcDraw")
	HotKeySet("!{4}", "funcDraw")
	HotKeySet("!{5}", "funcDraw")
	HotKeySet("!{6}", "funcDraw")
	HotKeySet("!{7}", "funcDraw")
	HotKeySet("!{8}", "funcDraw")
	HotKeySet("!{9}", "funcDraw")

	HotKeySet("^{0}", "funcDraw")
	HotKeySet("^{1}", "funcDraw")
	HotKeySet("^{2}", "funcDraw")
	HotKeySet("^{3}", "funcDraw")
	HotKeySet("^{4}", "funcDraw")
	HotKeySet("^{5}", "funcDraw")
	HotKeySet("^{6}", "funcDraw")
	HotKeySet("^{7}", "funcDraw")
	HotKeySet("^{8}", "funcDraw")
	HotKeySet("^{9}", "funcDraw")

	HotKeySet("!{'}", "funcDraw")
	HotKeySet("!{*}", "funcDraw")
	HotKeySet("!{@}", "funcDraw")
	HotKeySet("!{[}", "funcDraw")
	HotKeySet("!{]}", "funcDraw")
	HotKeySet("!{^}", "funcDraw")
	HotKeySet("!{:}", "funcDraw")
	HotKeySet("!{,}", "funcDraw")
	HotKeySet("!{$}", "funcDraw")
	HotKeySet("!{=}", "funcDraw")
	HotKeySet("!{!}", "funcDraw")
	HotKeySet("!{>}", "funcDraw")
	HotKeySet("!{<}", "funcDraw")
	HotKeySet("!{-}", "funcDraw")
	HotKeySet("!{(}", "funcDraw")
	HotKeySet("!{)}", "funcDraw")
	HotKeySet("!{.}", "funcDraw")
	HotKeySet("!{+}", "funcDraw")
	HotKeySet("!{#}", "funcDraw")
	HotKeySet("!{?}", "funcDraw")
	HotKeySet("!{;}", "funcDraw")
	HotKeySet("!{\}", "funcDraw")
	HotKeySet("!{/}", "funcDraw")
	HotKeySet("!{_}", "funcDraw")
	HotKeySet("!{|}", "funcDraw")

	HotKeySet("^{'}", "funcDraw")
	HotKeySet("^{*}", "funcDraw")
	HotKeySet("^{@}", "funcDraw")
	HotKeySet("^{[}", "funcDraw")
	HotKeySet("^{]}", "funcDraw")
	HotKeySet("^{^}", "funcDraw")
	HotKeySet("^{:}", "funcDraw")
	HotKeySet("^{,}", "funcDraw")
	HotKeySet("^{$}", "funcDraw")
	HotKeySet("^{=}", "funcDraw")
	HotKeySet("^{!}", "funcDraw")
	HotKeySet("^{>}", "funcDraw")
	HotKeySet("^{<}", "funcDraw")
	HotKeySet("^{-}", "funcDraw")
	HotKeySet("^{(}", "funcDraw")
	HotKeySet("^{)}", "funcDraw")
	HotKeySet("^{.}", "funcDraw")
	HotKeySet("^{+}", "funcDraw")
	HotKeySet("^{#}", "funcDraw")
	HotKeySet("^{?}", "funcDraw")
	HotKeySet("^{;}", "funcDraw")
	HotKeySet("^{\}", "funcDraw")
	HotKeySet("^{/}", "funcDraw")
	HotKeySet("^{_}", "funcDraw")
	HotKeySet("^{|}", "funcDraw")

	HotKeySet("!{INSERT}", "funcDraw")
	HotKeySet("{INSERT}", "funcDraw")
	HotKeySet("{SCROLLLOCK}", "funcDraw")
	HotKeySet("{CAPSLOCK}", "funcDraw")

	Call("funcDraw")
	Call("hide")
	ToolTip("Script paused.", 0, 0)
	TrayTip("", "Press PAUSE to resume.", 5, 16)
	While $Paused
	WEnd
	TrayTip("", "Script unpaused.", 5, 16)
	ToolTip("Script unpaused.", 0, 0)
EndFunc   ;==>pause

Func funcDraw()
	If $Paused Then

		HotKeySet("{ESC}")

		HotKeySet("{PGDN}")
		HotKeySet("{PGUP}")
		HotKeySet("!{UP}")
		HotKeySet("!{DOWN}")
		HotKeySet("{`}")
		HotKeySet("!{`}")
		HotKeySet("!{~}")
		HotKeySet("{~}")
		HotKeySet("{F1}")
		HotKeySet("{F2}")
		HotKeySet("{F3}")
		HotKeySet("{F4}")
		HotKeySet("{F5}")
		HotKeySet("{F6}")
		HotKeySet("{F7}")
		HotKeySet("{F8}")
		HotKeySet("{F9}")
		HotKeySet("{F11}")
		HotKeySet("{HOME}")

		HotKeySet("!{NUMPADADD}")
		HotKeySet("!{NUMPADSUB}")
		HotKeySet("!{NUMPADMULT}")
		HotKeySet("!{NUMPADDIV}")

		HotKeySet("!{NUMPAD1}")
		HotKeySet("!{NUMPAD2}")
		HotKeySet("!{NUMPAD3}")
		HotKeySet("!{NUMPAD4}")
		HotKeySet("!{NUMPAD5}")
		HotKeySet("^{NUMPAD5}")
		HotKeySet("!{NUMPAD6}")
		HotKeySet("!{NUMPAD7}")
		HotKeySet("!{NUMPAD8}")
		HotKeySet("!{NUMPAD9}")
		HotKeySet("!{NUMPAD0}")

		HotKeySet("^{NUMPAD1}")
		HotKeySet("^{NUMPAD3}")
		HotKeySet("^{NUMPAD7}")
		HotKeySet("^{NUMPAD9}")
		HotKeySet("^{NUMPAD0}")

		HotKeySet("!{NUMPADDOT}")
		HotKeySet("^{NUMPADDOT}")

		HotKeySet("!{SPACE}")
		HotKeySet("!{a}")
		HotKeySet("!{b}")
		HotKeySet("!{B}")
		HotKeySet("!{c}")
		HotKeySet("!{d}")
		HotKeySet("!{D}")
		HotKeySet("!{e}")
		HotKeySet("!{f}")
		HotKeySet("!{g}")
		HotKeySet("!{h}")
		HotKeySet("!{H}")
		HotKeySet("!{i}")
		HotKeySet("!{j}")
		HotKeySet("!{k}")
		HotKeySet("!{l}")
		HotKeySet("!{m}")
		HotKeySet("!{n}")
		HotKeySet("!{o}")
		HotKeySet("!{p}")
		HotKeySet("!{q}")
		HotKeySet("!{r}")
		HotKeySet("!{s}")
		HotKeySet("!{S}")
		HotKeySet("!{t}")
		HotKeySet("!{u}")
		HotKeySet("!{v}")
		HotKeySet("!{w}")
		HotKeySet("!{x}")
		HotKeySet("!{y}")
		HotKeySet("!{z}")

		HotKeySet("^{SPACE}")
		HotKeySet("^{a}")
		HotKeySet("^{b}")
		HotKeySet("^{B}")
		HotKeySet("^{c}")
		HotKeySet("^{d}")
		HotKeySet("^{e}")
		HotKeySet("^{f}")
		HotKeySet("^{g}")
		HotKeySet("^{h}")
		HotKeySet("^{H}")
		HotKeySet("^{i}")
		HotKeySet("^{j}")
		HotKeySet("^{k}")
		HotKeySet("^{l}")
		HotKeySet("^{m}")
		HotKeySet("^{n}")
		HotKeySet("^{o}")
		HotKeySet("^{p}")
		HotKeySet("^{q}")
		HotKeySet("^{r}")
		HotKeySet("^{s}")
		HotKeySet("^{S}")
		HotKeySet("^{t}")
		HotKeySet("^{u}")
		HotKeySet("^{v}")
		HotKeySet("^{w}")
		HotKeySet("^{x}")
		HotKeySet("^{y}")
		HotKeySet("^{z}")

		HotKeySet("!{0}")
		HotKeySet("!{1}")
		HotKeySet("!{2}")
		HotKeySet("!{3}")
		HotKeySet("!{4}")
		HotKeySet("!{5}")
		HotKeySet("!{6}")
		HotKeySet("!{7}")
		HotKeySet("!{8}")
		HotKeySet("!{9}")

		HotKeySet("^{0}")
		HotKeySet("^{1}")
		HotKeySet("^{2}")
		HotKeySet("^{3}")
		HotKeySet("^{4}")
		HotKeySet("^{5}")
		HotKeySet("^{6}")
		HotKeySet("^{7}")
		HotKeySet("^{8}")
		HotKeySet("^{9}")

		HotKeySet("!{'}")
		HotKeySet("!{*}")
		HotKeySet("!{@}")
		HotKeySet("!{[}")
		HotKeySet("!{]}")
		HotKeySet("!{^}")
		HotKeySet("!{:}")
		HotKeySet("!{,}")
		HotKeySet("!{$}")
		HotKeySet("!{=}")
		HotKeySet("!{!}")
		HotKeySet("!{>}")
		HotKeySet("!{<}")
		HotKeySet("!{-}")
		HotKeySet("!{(}")
		HotKeySet("!{)}")
		HotKeySet("!{.}")
		HotKeySet("!{+}")
		HotKeySet("!{#}")
		HotKeySet("!{?}")
		HotKeySet("!{;}")
		HotKeySet("!{\}")
		HotKeySet("!{/}")
		HotKeySet("!{_}")
		HotKeySet("!{|}")

		HotKeySet("^{'}")
		HotKeySet("^{*}")
		HotKeySet("^{@}")
		HotKeySet("^{[}")
		HotKeySet("^{]}")
		HotKeySet("^{^}")
		HotKeySet("^{:}")
		HotKeySet("^{,}")
		HotKeySet("^{$}")
		HotKeySet("^{=}")
		HotKeySet("^{!}")
		HotKeySet("^{>}")
		HotKeySet("^{<}")
		HotKeySet("^{-}")
		HotKeySet("^{(}")
		HotKeySet("^{)}")
		HotKeySet("^{.}")
		HotKeySet("^{+}")
		HotKeySet("^{#}")
		HotKeySet("^{?}")
		HotKeySet("^{;}")
		HotKeySet("^{\}")
		HotKeySet("^{/}")
		HotKeySet("^{_}")
		HotKeySet("^{|}")

		HotKeySet("!{INSERT}")
		HotKeySet("{INSERT}")
		HotKeySet("{SCROLLLOCK}")
		HotKeySet("{CAPSLOCK}")

	EndIf

	Switch @HotKeyPressed

		Case ("{ESC}")
			restart()

		Case ("{PGDN}")
			hide()
		Case ("{PGUP}")
			unhide()
		Case ("!{UP}")
			holdUp()
		Case ("!{DOWN}")
			holdDown()
		Case ("{`}")
			vertsway()
		Case ("!{`}")
			sidesway()
		Case ("!{~}")
			calibrate()
		Case ("{~}")
			colorDropper()
		Case ("{F1}")
			categoryText()
		Case ("{F2}")
			categorySymbols()
		Case ("{F3}")
			categoryPeople()
		Case ("{F4}")
			categoryAnatomy()
		Case ("{F5}")
			categoryCreatures()
		Case ("{F6}")
			categoryDevices()
		Case ("{F7}")
			categoryStructures()
		Case ("{F8}")
			categoryFood()
		Case ("{F11}")
			abort()
		Case ("{Home}")
			circled()

		Case ("!{NUMPADADD}")
			sizeBigger()
		Case ("!{NUMPADSUB}")
			sizeSmaller()
		Case ("!{NUMPADMULT}")
			input_numpadMultiply()
		Case ("!{NUMPADDIV}")
			input_numpadDivide()

		Case ("!{NUMPAD2}")
			input_numpad2()
		Case ("!{NUMPAD4}")
			input_numpad4()
		Case ("!{NUMPAD5}")
			control_numpad5()
		Case ("^{NUMPAD5}")
			control_numpad5()
		Case ("!{NUMPAD6}")
			input_numpad6()
		Case ("!{NUMPAD8}")
			input_numpad8()
		Case ("!{NUMPAD0}")
			input_numpad0()

		Case ("^{NUMPAD1}")
			orientationUpsideDown()
		Case ("^{NUMPAD3}")
			orientationBackFlip()
		Case ("^{NUMPAD7}")
			orientationNormal()
		Case ("^{NUMPAD9}")
			orientationBackwards()
		Case ("^{NUMPAD0}")
			input_numpad0()

		Case ("!{NUMPADDOT}")
			GridSettings()
		Case ("^{NUMPADDOT}")
			input_numpadDot()

		Case ("!{SPACE}")
			input_space()
		Case ("!{a}")
			input_a()
		Case ("!{b}")
			input_b()
		Case ("!{c}")
			input_c()
		Case ("!{d}")
			input_d()
		Case ("!{e}")
			input_e()
		Case ("!{f}")
			input_f()
		Case ("!{g}")
			input_g()
		Case ("!{h}")
			input_h()
		Case ("!{i}")
			input_i()
		Case ("!{j}")
			input_j()
		Case ("!{k}")
			input_k()
		Case ("!{l}")
			input_l()
		Case ("!{m}")
			input_m()
		Case ("!{n}")
			input_n()
		Case ("!{o}")
			input_o()
		Case ("!{p}")
			input_p()
		Case ("!{q}")
			input_q()
		Case ("!{r}")
			input_r()
		Case ("!{s}")
			input_s()
		Case ("!{t}")
			input_t()
		Case ("!{u}")
			input_u()
		Case ("!{v}")
			input_v()
		Case ("!{w}")
			input_w()
		Case ("!{x}")
			input_x()
		Case ("!{y}")
			input_y()
		Case ("!{z}")
			input_z()

		Case ("^{SPACE}")
			input_space()
		Case ("^{a}")
			input_a()
		Case ("^{b}")
			input_b()
		Case ("^{c}")
			input_c()
		Case ("^{d}")
			input_d()
		Case ("^{e}")
			input_e()
		Case ("^{f}")
			input_f()
		Case ("^{g}")
			input_g()
		Case ("^{h}")
			input_h()
		Case ("^{i}")
			input_i()
		Case ("^{j}")
			input_j()
		Case ("^{k}")
			input_k()
		Case ("^{l}")
			input_l()
		Case ("^{m}")
			input_m()
		Case ("^{n}")
			input_n()
		Case ("^{o}")
			input_o()
		Case ("^{p}")
			input_p()
		Case ("^{q}")
			input_q()
		Case ("^{r}")
			input_r()
		Case ("^{s}")
			input_s()
		Case ("^{t}")
			input_t()
		Case ("^{u}")
			input_u()
		Case ("^{v}")
			input_v()
		Case ("^{w}")
			input_w()
		Case ("^{x}")
			input_x()
		Case ("^{y}")
			input_y()
		Case ("^{z}")
			input_z()

		Case ("!{0}")
			input_0()
		Case ("!{1}")
			input_1()
		Case ("!{2}")
			input_2()
		Case ("!{3}")
			input_3()
		Case ("!{4}")
			input_4()
		Case ("!{5}")
			input_5()
		Case ("!{6}")
			input_6()
		Case ("!{7}")
			input_7()
		Case ("!{8}")
			input_8()
		Case ("!{9}")
			input_9()

		Case ("^{0}")
			input_0()
		Case ("^{1}")
			input_1()
		Case ("^{2}")
			input_2()
		Case ("^{3}")
			input_3()
		Case ("^{4}")
			input_4()
		Case ("^{5}")
			input_5()
		Case ("^{6}")
			input_6()
		Case ("^{7}")
			input_7()
		Case ("^{8}")
			input_8()
		Case ("^{9}")
			input_9()

		Case ("!{'}")
			input_apostrophe()
		Case ("!{*}")
			input_asterisk()
		Case ("!{@}")
			input_at()
		Case ("!{[}")
			input_bracketLeft()
		Case ("!{]}")
			input_bracketRight()
		Case ("!{^}")
			input_caret()
		Case ("!{:}")
			input_colon()
		Case ("!{,}")
			input_comma()
		Case ("!{$}")
			input_dollar()
		Case ("!{=}")
			input_equal()
		Case ("!{!}")
			input_exclamation()
		Case ("!{>}")
			input_greater()
		Case ("!{<}")
			input_less()
		Case ("!{-}")
			input_minus()
		Case ("!{(}")
			input_parenthesisLeft()
		Case ("!{)}")
			input_parenthesisRight()
		Case ("!{.}")
			input_period()
		Case ("!{+}")
			input_plus()
		Case ("!{#}")
			input_pound()
		Case ("!{?}")
			input_question()
		Case ("!{;}")
			input_semicolon()
		Case ("!{\}")
			input_slashBackward()
		Case ("!{/}")
			input_slashForward()
		Case ("!{_}")
			input_underscore()
		Case ("!{|}")
			input_vertical()

		Case ("^{'}")
			input_apostrophe()
		Case ("^{*}")
			input_asterisk()
		Case ("^{@}")
			input_at()
		Case ("^{[}")
			input_bracketLeft()
		Case ("^{]}")
			input_bracketRight()
		Case ("^{^}")
			input_caret()
		Case ("^{:}")
			input_colon()
		Case ("^{,}")
			input_comma()
		Case ("^{$}")
			input_dollar()
		Case ("^{=}")
			input_equal()
		Case ("^{!}")
			input_exclamation()
		Case ("^{>}")
			input_greater()
		Case ("^{<}")
			input_less()
		Case ("^{-}")
			input_minus()
		Case ("^{(}")
			input_parenthesisLeft()
		Case ("^{)}")
			input_parenthesisRight()
		Case ("^{.}")
			input_period()
		Case ("^{+}")
			input_plus()
		Case ("^{#}")
			input_pound()
		Case ("^{?}")
			input_question()
		Case ("^{;}")
			input_semicolon()
		Case ("^{\}")
			input_slashBackward()
		Case ("^{/}")
			input_slashForward()
		Case ("^{_}")
			input_underscore()
		Case ("^{|}")
			input_vertical()

		Case ("!{INSERT}")
			input_insert()
		Case ("{INSERT}")
			input_insert()
		Case ("{SCROLLLOCK}")
			input_scroll()
		Case ("{CAPSLOCK}")
			draw_circool()

	EndSwitch

EndFunc   ;==>funcDraw

Func pauser()
	Call("pause")
EndFunc   ;==>pauser

Func restart()
	If _Singleton(@ScriptName, 1) = 0 Then
		MouseUp("primary")
		$active = 0
		$circlestate = 0
		$Aborted = 1
		Run(@ScriptFullPath) ; restart script
		ProcessClose(@ScriptName)
		TrayTip("", "" & $ProgramName & " Restarted.", 2, 16)
	EndIf
EndFunc   ;==>restart

Func close()
	MouseUp("primary")
	Exit
EndFunc   ;==>close

Func abort()
	$Aborted = 1
EndFunc   ;==>abort

Func tip()
	ToolTip("To exit, press F10.", 0, 0)
EndFunc   ;==>tip

Func categoryText()
	$category = "Text"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryText

Func categorySymbols()
	$category = "Symbols"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categorySymbols

Func categoryPeople()
	$category = "People"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryPeople

Func categoryAnatomy()
	$category = "" & @UserName & "'s Anatomy"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryAnatomy

Func categoryCreatures()
	$category = "Creatures"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryCreatures

Func categoryDevices()
	$category = "Devices"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryDevices

Func categoryStructures()
	$category = "Structures"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryStructures

Func categoryFood()
	$category = "Food"
	GUICtrlSetData($inputCategory, $category)
	TrayTip("", "Draw direction set to " & $category & "", 0, 0)
EndFunc   ;==>categoryFood

Func sizeBigger()
	$sizeDraw = $sizeDraw + 1
	Call("Sizing")
	Select
		Case $sizeDraw <= 11

			TrayTip("Drawing size increased to " & $sizeDraw & "", " (x: " & ($x * 100) & "%, y: " & ($y * 100) & "%)", 0, 0)
		Case Else
			$sizeDraw = 11
			TrayTip("Maximum Size Reached!", "" & $sizeDraw & " is the maximum reachable size.", 2, 16)
	EndSelect
	GUICtrlSetData($inputSize, $sizeDraw)
EndFunc   ;==>sizeBigger

Func sizeSmaller()
	$sizeDraw = $sizeDraw - 1
	Call("Sizing")
	Select
		Case $sizeDraw >= 1

			TrayTip("Drawing size decreased to " & $sizeDraw & "", " (x: " & ($x * 100) & "%, y: " & ($y * 100) & "%)", 0, 0)
		Case Else
			$sizeDraw = 1
			TrayTip("Minimum Size Reached!", "" & $sizeDraw & " is the minimum reachable size.", 2, 16)
	EndSelect
	GUICtrlSetData($inputSize, $sizeDraw)
EndFunc   ;==>sizeSmaller

Func ArrayRotary()
	$arrays = "Rotary"
	$orientation = $arrays
	GUICtrlSetData($inputOrientation, $arrays)
	ToolTip("Drawing arrays set to " & $arrays & "", 0, 0)
EndFunc   ;==>ArrayRotary

Func ArrayRotated()
	$arrays = "Rotated"
	$orientation = $arrays
	GUICtrlSetData($inputOrientation, $orientation)
	ToolTip("Drawing arrays set to " & $arrays & "", 0, 0)
EndFunc   ;==>ArrayRotated

Func ArrayRotasis()
	$arrays = "Rotasis"
	$orientation = $arrays
	GUICtrlSetData($inputOrientation, $arrays)
	ToolTip("Drawing arrays set to " & $arrays & "", 0, 0)
EndFunc   ;==>ArrayRotasis

Func ArrayRotato()
	$arrays = "Rotato"
	$orientation = $arrays
	GUICtrlSetData($inputOrientation, $arrays)
	ToolTip("Drawing arrays set to " & $arrays & "", 0, 0)
EndFunc   ;==>ArrayRotato

Func orientationNormal()
	$h = 1
	$v = 1
	$orientation = "Normal"
	$arrays = "Standard"
	GUICtrlSetData($inputOrientation, $orientation)
	TrayTip("", "Draw direction set to " & $orientation & "", 2, 16)
EndFunc   ;==>orientationNormal

Func orientationBackwards()
	$h = -1
	$v = 1
	$orientation = "Backwards"
	GUICtrlSetData($inputOrientation, $orientation)
	TrayTip("", "Draw direction set to " & $orientation & "", 2, 16)
EndFunc   ;==>orientationBackwards

Func orientationUpsideDown()
	$h = 1
	$v = -1
	$orientation = "Upside Down"
	GUICtrlSetData($inputOrientation, $orientation)
	TrayTip("", "Draw direction set to " & $orientation & "", 2, 16)
EndFunc   ;==>orientationUpsideDown

Func orientationBackFlip()
	$h = -1
	$v = -1
	$orientation = "Back Flip"
	GUICtrlSetData($inputOrientation, $orientation)
	TrayTip("", "Draw direction set to " & $orientation & "", 2, 16)
EndFunc   ;==>orientationBackFlip

Func undefined()
	TrayTip("Undefined Function", "Make sure the key is assigned to a function.", 2, 3)
EndFunc   ;==>undefined

Func busy()
	TrayTip("Drawing In Progress", "Allow time for current drawing to process.", 2, 2)
EndFunc   ;==>busy

Func alt_scroll()

	Select

		Case $active = 0
			Call("draw_sample")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>alt_scroll

Func control_scroll()

	Select

		Case $active = 0
			Call("draw_example")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>control_scroll

Func input_numpad2()
	$pos = MouseGetPos()
	MouseMove($pos[0] + 0, $pos[1] + 20, 1)
EndFunc   ;==>input_numpad2

Func input_numpad4()
	$pos = MouseGetPos()
	MouseMove($pos[0] - 20, $pos[1] + 0, 1)
EndFunc   ;==>input_numpad4

Func control_numpad5()
	$hotspot = MouseGetPos()
	$pixie = PixelGetColor($hotspot[0], $hotspot[1])
	TrayTip("", "Coords: (" & $hotspot[0] & ", " & $hotspot[1] & ")" & @CRLF & "Pixel Color: " & Hex($pixie, 6) & "", 1, 16)
EndFunc   ;==>control_numpad5

Func input_numpad5()
	MouseDown("primary")
EndFunc   ;==>input_numpad5

Func input_numpad6()
	$pos = MouseGetPos()
	MouseMove($pos[0] + 20, $pos[1] + 0, 1)
EndFunc   ;==>input_numpad6

Func input_numpad8()
	$pos = MouseGetPos()
	MouseMove($pos[0] + 0, $pos[1] - 20, 1)
EndFunc   ;==>input_numpad8

Func input_numpad0()

	Select

		Case $active = 0
			ToolTip("Currently drawing a grid.", 0, 0)
			Call("draw_grid")
			Call("tip")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_numpad0

Func input_numpadMultiply()

	Select

		Case $active = 0
			Call("draw_example")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_numpadMultiply

Func input_numpadDivide()

	Select

		Case $active = 0
			Call("draw_sample")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_numpadDivide

Func input_numpadDot()
	MouseMove($hotspot[0], $hotspot[1], 1)
EndFunc   ;==>input_numpadDot

Func input_space()

	Select

		Case $active = 0
			ToolTip("Currently placing a Space.", 0, 0)
			Call("write_space")
			TrayTip("", "", 0)
			Call("tip")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_space

Func input_a()

	Select

		Case $category = "Text" And $active = 0
			Call("write_a")

		Case $category = "Symbols" And $active = 0
			Call("draw_droplet")

		Case $category = "People" And $active = 0
			Call("draw_alone")

		Case $category = "Creatures" And $active = 0
			Call("draw_alien")

		Case $category = "Devices" And $active = 0
			Call("draw_ak47")

		Case $category = "Structures" And $active = 0
			Call("draw_AUS")

		Case $category = "Food" And $active = 0
			Call("draw_apple")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_a

Func input_ShiftA()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_axe")

		Case $category = "Symbols" And $active = 0
			Call("draw_emblem")

		Case $category = "Creatures" And $active = 0
			Call("draw_cardinal")

		Case $category = "Devices" And $active = 0
			Call("draw_alien")

		Case $category <> "Text" Or "Symbols" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftA

Func input_b()

	Select

		Case $category = "Text" And $active = 0
			Call("write_b")

		Case $category = "Symbols" And $active = 0
			Call("draw_batman")

		Case $category = "People" And $active = 0
			Call("draw_bart")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_brain")

		Case $category = "Creatures" And $active = 0
			Call("draw_butterfly")

		Case $category = "Devices" And $active = 0
			Call("draw_blade")

		Case $category = "Structures" And $active = 0
			Call("draw_barn")

		Case $category = "Food" And $active = 0
			Call("draw_banana")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_b

Func input_ShiftB()

	Select

		Case $category = "Symbols" And $active = 0
			Call("draw_bomber")

		Case $category = "People" And $active = 0
			Call("draw_bubblegum")

		Case $category = "Creatures" And $active = 0
			Call("draw_bull")

		Case $category = "Devices" And $active = 0
			Call("draw_bicycle")

		Case $category = "Structures" And $active = 0
			Call("draw_box")

		Case $category = "Food" And $active = 0
			Call("draw_bowl")

		Case $category <> "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftB

Func input_c()

	Select

		Case $category = "Text" And $active = 0
			Call("write_c")

		Case $category = "Symbols" And $active = 0
			Call("draw_cloud")

		Case $category = "People" And $active = 0
			Call("draw_cartman")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			$doodle = 1
			Call("draw_cat")

		Case $category = "Creatures" And $active = 0
			Call("draw_crash")

		Case $category = "Devices" And $active = 0
			Call("draw_scissors")

		Case $category = "Structures" And $active = 0
			Call("draw_CND")

		Case $category = "Food" And $active = 0
			Call("draw_cake")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_c

Func input_ShiftC()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_chick")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a cog", 0, 0)
			Call("draw_cog")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Creatures" And $active = 0
			Call("draw_cow")

		Case $category = "Devices" And $active = 0
			Call("draw_bowl")

		Case $category = "Structures" And $active = 0
			Call("draw_castle")

		Case $category = "Food" And $active = 0
			Call("draw_crab")

		Case $category <> "Text" Or "Symbols" Or "Creatures" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftC

Func input_d()

	Select

		Case $category = "Text" And $active = 0
			Call("write_d")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a daisy.", 0, 0)
			Call("draw_daisy")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_daria")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			$doodle = 1
			Call("draw_doodle")

		Case $category = "Creatures" And $active = 0
			Call("draw_dog")

		Case $category = "Devices" And $active = 0
			Call("draw_computer")

		Case $category = "Structures" And $active = 0
			Call("draw_diner")

		Case $category = "Food" And $active = 0
			Call("draw_dish")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_d

Func input_ShiftD()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_daffodil")

		Case $category = "Symbols" And $active = 0
			Call("draw_mickey")

		Case $category = "People" And $active = 0
			Call("draw_bummed")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			$doodle = 1
			Call("draw_cat")

		Case $category = "Creatures" And $active = 0
			Call("draw_dolphin")

		Case $category = "Devices" And $active = 0
			Call("draw_domino")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftD

Func input_e()

	Select

		Case $category = "Text" And $active = 0
			Call("write_e")

		Case $category = "Symbols" And $active = 0
			Call("draw_smiley")

		Case $category = "People" And $active = 0
			Call("draw_elf")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_ear")

		Case $category = "Creatures" And $active = 0
			Call("draw_eagle")

		Case $category = "Devices" And $active = 0
			Call("draw_swordenergy")

		Case $category = "Structures" And $active = 0
			Call("draw_eiffel")

		Case $category = "Food" And $active = 0
			Call("draw_eggplant")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_e

Func input_ShiftE()

	Select

		Case $category = "Symbols" And $active = 0
			Call("draw_bomb")

		Case $category = "Creatures" And $active = 0
			Call("draw_elephant")

		Case $category = "Devices" And $active = 0
			Call("draw_bomb")

		Case $category <> "Symbols" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftE

Func input_f()

	Select

		Case $category = "Text" And $active = 0
			Call("write_f")

		Case $category = "Symbols" And $active = 0
			Call("draw_flame")

		Case $category = "People" And $active = 0
			Call("draw_fry")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_foot")

		Case $category = "Creatures" And $active = 0
			Call("draw_fairy")

		Case $category = "Devices" And $active = 0
			Call("draw_fender")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_f

Func input_ShiftF()

	Select

		Case $category = "Symbols" And $active = 0
			Call("draw_flask")

		Case $category = "People" And $active = 0
			Call("draw_feels")

		Case $category = "Creatures" And $active = 0
			Call("draw_fox")

		Case $category = "Devices" And $active = 0
			Call("draw_soccer")

		Case $category <> "Symbols" Or "People" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftF

Func input_g()

	Select

		Case $category = "Text" And $active = 0
			Call("write_g")

		Case $category = "Symbols" And $active = 0
			WinSetTrans($SSMain, "", 117)
			Call("draw_boo")

		Case $category = "People" And $active = 0
			Call("draw_knight")

		Case $category = "Creatures" And $active = 0
			Call("draw_gator")

		Case $category = "Devices" And $active = 0
			Call("draw_gameboy")

		Case $category = "Structures" And $active = 0
			Call("draw_triangoof")

		Case $category = "Food" And $active = 0
			Call("draw_glass")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_g

Func input_ShiftG()

	Select

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a cog", 0, 0)
			Call("draw_cog")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Creatures" And $active = 0
			WinSetTrans($SSMain, "", 117)
			Call("draw_ghost")

		Case $category = "Devices" And $active = 0
			Call("draw_lamp")

		Case $category = "Food" And $active = 0
			Call("draw_glass")

		Case $category <> "Symbols" Or "Creatures" Or "Devices" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftG

Func input_h()

	Select

		Case $category = "Text" And $active = 0
			Call("write_h")

		Case $category = "Symbols" And $active = 0
			Call("draw_heart")

		Case $category = "People" And $active = 0
			Call("draw_helmet")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_hand")

		Case $category = "Creatures" And $active = 0
			Call("draw_horse")

		Case $category = "Devices" And $active = 0
			Call("draw_hourglass")

		Case $category = "Structures" And $active = 0
			Call("draw_home")

		Case $category <> "Text" Or "Symbols" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_h

Func input_ShiftH()

	Select

		Case $category = "Text" And $active = 0
			ToolTip("Currently drawing an astroid", 0, 0)
			$steel = 0
			Call("draw_astroid")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a steelmark", 0, 0)
			$steel = 1
			Call("draw_astroid")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_joker")

		Case $category = "Creatures" And $active = 0
			Call("draw_goldfish")

		Case $category = "Devices" And $active = 0
			Call("draw_wheelchair")

		Case $category <> "Symbols" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftH

Func input_i()

	Select

		Case $category = "Text" And $active = 0
			Call("write_i")

		Case $category = "Symbols" And $active = 0
			Call("draw_thunderbolt")

		Case $category = "People" And $active = 0
			Call("draw_mario")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			ToolTip("Currently drawing an eye.", 0, 0)
			Call("draw_eye")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Creatures" And $active = 0
			Call("draw_siamese")

		Case $category = "Devices" And $active = 0
			Call("draw_light")

		Case $category = "Structures" And $active = 0
			Call("draw_intersection")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_i

Func input_j()

	Select

		Case $category = "Text" And $active = 0
			Call("write_j")

		Case $category = "Symbols" And $active = 0
			Call("draw_jewel")

		Case $category = "People" And $active = 0
			Call("draw_bieber")

		Case $category = "Creatures" And $active = 0
			Call("draw_puma")

		Case $category = "Devices" And $active = 0
			Call("draw_controller")

		Case $category = "Food" And $active = 0
			Call("draw_java")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_j

Func input_k()

	Select

		Case $category = "Text" And $active = 0
			Call("write_k")

		Case $category = "Symbols" And $active = 0
			Call("draw_snowflake")

		Case $category = "People" And $active = 0
			Call("draw_kid")

		Case $category = "Creatures" And $active = 0
			Call("draw_kitty")

		Case $category = "Devices" And $active = 0
			Call("draw_key")

		Case $category = "Devices" And $active = 0
			Call("draw_crab")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_k

Func input_l()

	Select

		Case $category = "Text" And $active = 0
			Call("write_l")

		Case $category = "Symbols" And $active = 0
			Call("draw_leaf")

		Case $category = "People" And $active = 0
			Call("draw_lady")

		Case $category = "Creatures" And $active = 0
			Call("draw_lizard")

		Case $category = "Devices" And $active = 0
			Call("draw_lamp")

		Case $category = "Structures" And $active = 0
			Call("draw_lantern")

		Case $category = "Food" And $active = 0
			Call("draw_lemon")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_l

Func input_m()

	Select

		Case $category = "Text" And $active = 0
			Call("write_m")

		Case $category = "Symbols" And $active = 0
			Call("draw_mask")

		Case $category = "People" And $active = 0
			Call("draw_mulan")

		Case $category = "Creatures" And $active = 0
			Call("draw_mouse")

		Case $category = "Devices" And $active = 0
			Call("draw_m16")

		Case $category = "Structures" And $active = 0
			Call("draw_castle")

		Case $category = "Food" And $active = 0
			Call("draw_mushroom")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_m

Func input_n()

	Select

		Case $category = "Text" And $active = 0
			Call("write_n")

		Case $category = "Symbols" And $active = 0
			Call("draw_nazi")

		Case $category = "People" And $active = 0
			Call("draw_ninja")

		Case $category = "Creatures" And $active = 0
			Call("draw_android")

		Case $category = "Devices" And $active = 0
			Call("draw_book")

		Case $category = "Food" And $active = 0
			Call("draw_buffalo")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_n

Func input_o()

	Select

		Case $category = "Text" And $active = 0
			Call("write_o")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on circle's perimeter to finalize circle.", 0, 0)
			Call("toolCircle")
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_politician")

		Case $category = "Creatures" And $active = 0
			Call("draw_hedgehog")

		Case $category = "Devices" And $active = 0
			ToolTip("Press TAB on oval's tip to finalize oval.", 0, 0)
			Call("toolOval")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Structures" And $active = 0
			Call("draw_target")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_o

Func input_ShiftO()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_kirby")

		Case $category = "Symbols" And $active = 0
			Call("draw_olympics")

		Case $category = "Creatures" And $active = 0
			Call("draw_birdy")

		Case $category = "Devices" And $active = 0
			Call("draw_octagon")

		Case $category <> "Text" Or "Symbols" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftO

Func input_p()

	Select

		Case $category = "Text" And $active = 0
			Call("write_p")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a pansy.", 0, 0)
			Call("draw_pansy")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_peach")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_doodle")

		Case $category = "Creatures" And $active = 0
			Call("draw_pikachu")

		Case $category = "Devices" And $active = 0
			Call("draw_plane")

		Case $category = "Structures" And $active = 0
			Call("draw_pyramid")

		Case $category = "Food" And $active = 0
			Call("draw_chili")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_p

Func input_ShiftP()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_pusheen")

		Case $category = "Symbols" And $active = 0
			Call("draw_portal")

		Case $category = "People" And $active = 0
			Call("draw_portrait")

		Case $category = "Creatures" And $active = 0
			Call("draw_penguin")

		Case $category = "Devices" And $active = 0
			Call("draw_deagle")

		Case $category = "Structures" And $active = 0
			Call("draw_plant")

		Case $category = "Food" And $active = 0
			Call("draw_pretzel")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftP

Func input_q()

	Select

		Case $category = "Text" And $active = 0
			Call("write_q")

		Case $category = "Symbols" And $active = 0
			Call("draw_feather")

		Case $category = "People" And $active = 0
			Call("draw_taylor")

		Case $category = "Creatures" And $active = 0
			Call("draw_slowpoke")

		Case $category = "Devices" And $active = 0
			Call("draw_feather")

		Case $category = "Structures" And $active = 0
			Call("draw_woodpile")

		Case $category <> "Text" Or "People" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_q

Func input_r()

	Select

		Case $category = "Text" And $active = 0
			Call("write_r")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on rectangle's bottom right corner to finalize rectangle.", 0, 0)
			Call("toolRectangle")
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_rage")

		Case $category = "Creatures" And $active = 0
			Call("draw_bunny")

		Case $category = "Devices" And $active = 0
			Call("draw_car")

		Case $category = "Structures" And $active = 0
			ToolTip("Currently drawing a rainbow.", 0, 0)
			Call("draw_rainbow")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_r

Func input_s()

	Select

		Case $category = "Text" And $active = 0
			Call("write_s")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on square's bottom right corner to finalize square.", 0, 0)
			Call("toolSquare")
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_agent")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_skull")

		Case $category = "Creatures" And $active = 0
			Call("draw_shark")

		Case $category = "Devices" And $active = 0
			Call("draw_suitcase")

		Case $category = "Food" And $active = 0
			Call("draw_sandwich")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_s

Func input_scroll()

	Select

		Case $active = 0
			Call("calibrate")
			$sizeDraw = 5
			$x = 1
			$y = 1
			$actualsize = 1
			GUICtrlSetData($inputSize, $sizeDraw)
			Call("draw_experiment")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_scroll

Func input_ShiftS()

	Select

		Case $category = "Text" And $active = 0
			Call("draw_star")

		Case $category = "Symbols" And $active = 0
			Call("draw_allstar")

		Case $category = "People" And $active = 0
			Call("draw_samurai")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			Call("draw_crossbones")

		Case $category = "Creatures" And $active = 0
			Call("draw_surprised")

		Case $category = "Devices" And $active = 0
			Call("draw_steam")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftS

Func input_t()

	Select

		Case $category = "Text" And $active = 0
			Call("write_t")

		Case $category = "Symbols" And $active = 0
			Call("draw_lightning")

		Case $category = "People" And $active = 0
			Call("draw_trollface")

		Case $category = "" & @UserName & "'s Anatomy" And $active = 0
			If $doodle = 0 Then
				$pos = MouseGetPos()
			EndIf
			Call("draw_cattail")

		Case $category = "Creatures" And $active = 0
			Call("draw_dragon")

		Case $category = "Devices" And $active = 0
			Call("draw_autobot")

		Case $category = "Structures" And $active = 0
			Call("draw_phonebooth")

		Case $category = "Food" And $active = 0
			Call("draw_toast")

		Case $category <> "Text" Or "Symbols" Or "People" Or "" & @UserName & "'s Anatomy" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_t

Func input_u()

	Select

		Case $category = "Text" And $active = 0
			Call("write_u")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a shell.", 0, 0)
			Call("draw_shell")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_beavis")

		Case $category = "Creatures" And $active = 0
			Call("draw_bear")

		Case $category = "Devices" And $active = 0
			Call("draw_uniform")

		Case $category = "Structures" And $active = 0
			Call("draw_USA")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_u

Func input_v()

	Select

		Case $category = "Text" And $active = 0
			Call("write_v")

		Case $category = "Symbols" And $active = 0
			Call("draw_steam")

		Case $category = "People" And $active = 0
			Call("draw_misty")

		Case $category = "Creatures" And $active = 0
			Call("draw_panda")

		Case $category = "Devices" And $active = 0
			Call("draw_vending")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_v

Func input_w()

	Select

		Case $category = "Text" And $active = 0
			Call("write_w")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a wallflower.", 0, 0)
			Call("draw_wallflower")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_painter")

		Case $category = "Creatures" And $active = 0
			Call("draw_spider")

		Case $category = "Devices" And $active = 0
			Call("draw_wrench")

		Case $category = "Structures" And $active = 0
			Call("draw_wall")

		Case $category = "Food" And $active = 0
			ToolTip("Currently drawing a pizza.", 0, 0)
			Call("draw_pizza")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_w

Func input_x()

	Select

		Case $category = "Text" And $active = 0
			Call("write_x")

		Case $category = "Symbols" And $active = 0
			Call("draw_playboy")

		Case $category = "People" And $active = 0
			Call("draw_maid")

		Case $category = "Creatures" And $active = 0
			Call("draw_phoenix")

		Case $category = "Devices" And $active = 0
			Call("draw_xbox")

		Case $category = "Structures" And $active = 0
			ToolTip("Currently drawing framex.", 0, 0)
			Call("draw_framex")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_x

Func input_ShiftX()

	Select

		Case $category = "Symbols" And $active = 0
			Call("draw_axe")

		Case $category = "People" And $active = 0
			Call("draw_dancers")

		Case $category = "Devices" And $active = 0
			Call("draw_pickaxe")

		Case $category <> "Symbols" Or "People" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_ShiftX

Func input_y()

	Select

		Case $category = "Text" And $active = 0
			Call("write_y")

		Case $category = "Symbols" And $active = 0
			Call("draw_suit")

		Case $category = "People" And $active = 0
			Call("draw_yotsuba")

		Case $category = "Creatures" And $active = 0
			Call("draw_pony")

		Case $category = "Devices" And $active = 0
			Call("draw_axe")

		Case $category = "Structures" And $active = 0
			ToolTip("Currently drawing a tetra.", 0, 0)
			Call("draw_tetra")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" Or "People" Or "Creatures" Or "Devices" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_y

Func input_z()

	Select

		Case $category = "Text" And $active = 0
			Call("write_z")

		Case $category = "Symbols" And $active = 0
			Call("draw_chain")

		Case $category = "People" And $active = 0
			Call("draw_sweetface")

		Case $category = "Creatures" And $active = 0
			Call("draw_sponge")

		Case $category = "Devices" And $active = 0
			Call("draw_swordmaster")

		Case $category = "Structures" And $active = 0
			ToolTip("Currently drawing framez.", 0, 0)
			Call("draw_framez")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Food" And $active = 0
			Call("draw_pretzel")

		Case $category <> "Text" Or "People" Or "Creatures" Or "Devices" Or "Structures" Or "Food" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_z

Func input_0()

	Select

		Case $category = "Text" And $active = 0
			Call("write_0")

		Case $category = "Symbols" And $active = 0
			Call("draw_portal")

		Case $category = "Devices" And $active = 0
			ToolTip("Currently drawing a can.", 0, 0)
			Call("draw_can")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_0

Func input_1()

	Select

		Case $category = "Text" And $active = 0
			Call("write_1")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on line's endpoint to finalize line.", 0, 0)
			Call("toolLine")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_1

Func input_2()

	Select

		Case $category = "Text" And $active = 0
			Call("write_2")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a swirly.", 0, 0)
			Call("draw_swirly")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Devices" And $active = 0
			Call("draw_bicycle")

		Case $category <> "Text" Or "Symbols" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_2

Func input_3()

	Select

		Case $category = "Text" And $active = 0
			Call("write_3")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_3

Func input_4()

	Select

		Case $category = "Text" And $active = 0
			Call("write_4")

		Case $category = "Devices" And $active = 0
			Call("draw_car")

		Case $category <> "Text" Or "Devices" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_4

Func input_5()

	Select

		Case $category = "Text" And $active = 0
			Call("write_5")

		Case $category = "Structures" And $active = 0
			Call("draw_bingo")

		Case $category <> "Text" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_5

Func input_6()

	Select

		Case $category = "Text" And $active = 0
			Call("write_6")

		Case $category = "Symbols" And $active = 0
			Call("draw_triangle")

		Case $category = "Structures" And $active = 0
			Call("draw_triangle")

		Case $category <> "Text" Or "Symbols" Or "Structures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_6

Func input_7()

	Select

		Case $category = "Text" And $active = 0
			Call("write_7")

		Case $category = "Symbols" And $active = 0
			Call("draw_harrier")

		Case $category = "People" And $active = 0
			Call("draw_agent")

		Case $category <> "Text" Or "Symbols" Or "People" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_7

Func input_8()

	Select

		Case $category = "Text" And $active = 0
			Call("write_8")

		Case $category = "Symbols" And $active = 0
			Call("draw_apache")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_8

Func input_9()

	Select

		Case $category = "Text" And $active = 0
			Call("write_9")

		Case $category = "Symbols" And $active = 0
			Call("draw_bomber")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_9

Func input_apostrophe()

	Select

		Case $category = "Text" And $active = 0
			Call("write_apostrophe")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_apostrophe

Func input_asterisk()

	Select

		Case $category = "Text" And $active = 0
			Call("write_asterisk")

		Case $category = "Symbols" And $active = 0
			Call("draw_star")

		Case $category = "People" And $active = 0
			Call("draw_bart")

		Case $category <> "Text" Or "Symbols" Or "People" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_asterisk

Func input_at()

	Select

		Case $category = "Text" And $active = 0
			ToolTip("Currently drawing an atom", 0, 0)
			Call("draw_atom")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a swirl", 0, 0)
			Call("draw_swirl")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "People" And $active = 0
			Call("draw_nurse")

		Case $category <> "Text" Or "Symbols" Or "People" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_at

Func input_bracketLeft()

	Select

		Case $category = "Text" And $active = 0
			Call("write_bracketLeft")

		Case $category = "Symbols" And $active = 0
			Call("draw_square")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_bracketLeft

Func input_bracketRight()

	Select

		Case $category = "Text" And $active = 0
			Call("write_bracketRight")

		Case $category = "Symbols" And $active = 0
			Call("draw_cube")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_bracketRight

Func input_caret()

	Select

		Case $category = "Text" And $active = 0
			Call("write_caret")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on triangle's bottom corner to finalize triangle.", 0, 0)
			Call("toolTriangle")
			Call("tip")

		Case $category = "Devices" And $active = 0
			Call("draw_car")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_caret

Func input_colon()

	Select

		Case $category = "Text" And $active = 0
			Call("write_colon")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_colon

Func input_comma()

	Select

		Case $category = "Text" And $active = 0
			Call("write_comma")

		Case $category = "Symbols" And $active = 0
			Call("draw_chrome")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_comma

Func input_dollar()

	Select

		Case $category = "Text" And $active = 0
			Call("write_dollar")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_dollar

Func input_equal()

	Select

		Case $category = "Text" And $active = 0
			Call("write_equal")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing horizontal bars.", 0, 0)
			Call("draw_barsHorizontal")
			TrayTip("", "", 0)
			Call("tip")

		Case $category = "Creatures" And $active = 0
			Call("draw_eagle")

		Case $category <> "Text" Or "Symbols" Or "Creatures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_equal

Func input_exclamation()

	Select

		Case $category = "Text" And $active = 0
			Call("write_exclamation")

		Case $category = "Symbols" And $active = 0
			ToolTip("Press TAB on line's endpoint to finalize line.", 0, 0)
			Call("toolLine")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_exclamation

Func input_greater()

	Select

		Case $category = "Text" And $active = 0
			Call("write_greater")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_greater

Func input_less()

	Select

		Case $category = "Text" And $active = 0
			Call("write_less")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_less

Func input_minus()

	Select

		Case $category = "Text" And $active = 0
			Call("write_minus")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_minus

Func input_parenthesisLeft()

	Select

		Case $category = "Text" And $active = 0
			Call("write_parenthesisLeft")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_parenthesisLeft

Func input_parenthesisRight()

	Select

		Case $category = "Text" And $active = 0
			Call("write_parenthesisRight")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently writing a canned.", 0, 0)
			Call("draw_canned")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_parenthesisRight

Func input_period()

	Select

		Case $category = "Text" And $active = 0
			Call("write_period")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_period

Func input_plus()

	Select

		Case $category = "Text" And $active = 0
			Call("write_plus")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_plus


Func input_pound()

	Select

		Case $category = "Text" And $active = 0
			Call("write_pound")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_pound

Func input_question()

	Select

		Case $category = "Text" And $active = 0
			Call("write_question")

		Case $category = "Creatures" And $active = 0
			Call("draw_slowpoke")

		Case $category <> "Text" Or "Creatures" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_question

Func input_semicolon()

	Select

		Case $category = "Text" And $active = 0
			Call("write_dot")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing a spot.", 0, 0)
			Call("draw_spot")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_semicolon

Func input_slashBackward()

	Select

		Case $category = "Text" And $active = 0
			Call("write_slashBackward")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_slashBackward

Func input_slashForward()

	Select

		Case $category = "Text" And $active = 0
			Call("write_slashForward")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_slashForward

Func input_underscore()

	Select

		Case $category = "Text" And $active = 0
			Call("write_underscore")

		Case $category <> "Text" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_underscore

Func input_vertical()

	Select

		Case $category = "Text" And $active = 0
			Call("write_vertical")

		Case $category = "Symbols" And $active = 0
			ToolTip("Currently drawing vertical bars.", 0, 0)
			Call("draw_barsVertical")
			TrayTip("", "", 0)
			Call("tip")

		Case $category <> "Text" Or "Symbols" And $active = 0
			Call("undefined")

		Case Else
			Call("busy")

	EndSelect

EndFunc   ;==>input_vertical

Func input_insert()
	$active = $active + 1
	$circlestate = 1

	Select

		Case $active = 1
			Call("tacticalCircle")
			$active = 0

		Case Else
			Call("busy")

	EndSelect

	Call("tip")

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>input_insert

Func draw_apache()
	$circleSize = 50
	$Propellers = 0
	$PropellerStart = 15
	$PropellerEnd = $PropellerStart + 60
	$pos = MouseGetPos()
	MouseMove($pos[0] + $h * $x * 21, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 26, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 34, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 44, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 12, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 16, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 24, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 18, $pos[1] + $v * $y * 40, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 24.5, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 27, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 33, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 38, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 20, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 22, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 25.75, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 23.25, $pos[1] + $v * $y * 36, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 47, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 27, $pos[1] + $v * $y * 47, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 27, $pos[1] + $v * $y * 52, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 29, $pos[1] + $v * $y * 52, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 29, $pos[1] + $v * $y * 63, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 27, $pos[1] + $v * $y * 63, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 27, $pos[1] + $v * $y * 69, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 21, $pos[1] + $v * $y * 69, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 21, $pos[1] + $v * $y * 75, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 39, $pos[1] + $v * $y * 75, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 39, $pos[1] + $v * $y * 69, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 69, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 63, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 31, $pos[1] + $v * $y * 63, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 31, $pos[1] + $v * $y * 52, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 52, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 33, $pos[1] + $v * $y * 47, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 29, $pos[1] + $v * $y * 47, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 31, $pos[1] + $v * $y * 47, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 30, 1)
	$pos = MouseGetPos()
	$xCircle = $pos[0]
	$yCircle = $pos[1]
	$circleSize = $circleSize * 0.5
	MouseMove($pos[0] + $h * $x * 30, $pos[1] + $v * $y * 30, 1)
	Do
		For $R = $PropellerStart To $PropellerEnd Step +5
			$Rad = _Radian($R)
			$XX = Sin($Rad) * $circleSize + $xCircle
			$YY = Cos($Rad) * $circleSize + $yCircle
			MouseMove($XX, $YY, 1)
			MouseDown("primary")
		Next
		$PropellerStart = $PropellerStart + 90
		$PropellerEnd = $PropellerStart + 60
		$Propellers = $Propellers + 1
		MouseUp("primary")
	Until $Propellers >= 4
	MouseUp("primary")
	$circleSize = $circleSize * 2

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_apache

Func draw_barsHorizontal()
	$tileHeight = 220
	$tileGap = 10
	$tileLength = 385
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		$tileGap = $tileGap + 20
		Sleep($delayDraw)
	Until $tileGap > $tileHeight
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_barsHorizontal

Func draw_barsVertical()
	$tileHeight = 220
	$tileGap = 10
	$tileLength = 385
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * 0, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * $tileHeight, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * 0, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		$tileGap = $tileGap + 20
		Sleep($delayDraw)
	Until $tileGap > $tileLength
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_barsVertical

Func draw_can()
	$pos = MouseGetPos()
	$Xoval = $pos[0]
	$Yoval = $pos[1]
	$ovalRadius = 25
	$canHeight = 30
	$canSides = 0
	$paces = 0

	While $paces < 6.3
		MouseMove($Xoval + ($ovalRadius * $x * 2 * Cos($paces)), $Yoval + $canHeight + ($ovalRadius * $y) * Sin($paces), 0)
		Sleep($delayDraw)
		MouseDown("primary")
		$paces += 0.1
	WEnd
	MouseUp("primary")
	$paces = 0

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)

	$canHeight = 150
	$cylinder = 1

	While $paces < 6.3
		MouseMove($Xoval + ($ovalRadius * $x * 2 * Cos($paces)), $Yoval + $canHeight + ($ovalRadius * $y) * Sin($paces), 0)
		Sleep($delayDraw)
		MouseDown("primary")
		$paces += 0.1
	WEnd
	MouseUp("primary")
	$paces = 0

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)

	While $canSides < 2
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + (0.2 * $canHeight) + $v * $y, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + $v * $y * ($canHeight / $y), 1)
		Sleep($delayDraw)
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + $v * $y * (($canHeight / $y) - 1), 1)
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
		Local $h = -1
		$canSides = $canSides + 1
	WEnd

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_can

Func draw_canned()
	$pos = MouseGetPos()
	$Xoval = $pos[0]
	$Yoval = $pos[1]
	$ovalRadius = 25
	$canHeight = 80
	$canSides = 0
	$paces = 0

	While $paces < 6.3
		MouseMove($Xoval + ($ovalRadius * $x * 2 * Cos($paces)), $Yoval + $canHeight + ($ovalRadius * $y) * Sin($paces), 0)
		Sleep($delayDraw)
		MouseDown("primary")
		$paces += 0.1
	WEnd
	MouseUp("primary")
	$paces = 0

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)

	$canHeight = 360
	$cylinder = 1

	While $paces < 6.3
		MouseMove($Xoval + ($ovalRadius * $x * 2 * Cos($paces)), $Yoval + $canHeight + ($ovalRadius * $y) * Sin($paces), 0)
		Sleep($delayDraw)
		MouseDown("primary")
		$paces += 0.1
	WEnd
	MouseUp("primary")
	$paces = 0

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)

	While $canSides < 2
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + (0.2 * $canHeight) + $v * $y, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + $v * $y * ($canHeight / $y), 1)
		Sleep($delayDraw)
		MouseMove($pos[0] - $h * $x * (2 * $ovalRadius), $pos[1] + $v * $y * (($canHeight / $y) - 1), 1)
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
		Local $h = -1
		$canSides = $canSides + 1
	WEnd

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_canned

Func draw_circle()
	Local $pos = MouseGetPos()
	$xCircle = $pos[0]
	$yCircle = $pos[1]

	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = Sin($Rad) * $circleSize + $xCircle
		$YY = Cos($Rad) * $circleSize + $yCircle
		MouseMove($XX, $YY, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
	Sleep($delayDraw)

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_circle

Func draw_cog()
	$beginning = 360
	$ending = 0
	$differential = 30
	$set = 1
	$gear = 1
	Local $pos = MouseGetPos()
	Do
		For $R = $beginning To $ending Step -5
			$Rad = _Radian($R)
			$XX = Sin($Rad) * $gear * $actualsize * 50 + $pos[0]
			$YY = Cos($Rad) * $gear * $actualsize * 50 + $pos[1]
			MouseMove($XX, $YY, 0)
			MouseDown("primary")
			$differential = $beginning - $R
			If $differential >= 30 Then
				$set = $set * -1
				$beginning = $R
			EndIf
			If $set = 1 Then
				$gear = 1
			ElseIf $set = -1 Then
				$gear = 0.8
			EndIf
		Next
	Until $R <= 0
	$XX = Sin($Rad) * $gear * $actualsize * 50 + $pos[0]
	$YY = Cos($Rad) * $gear * $actualsize * 50 + $pos[1]
	MouseMove($XX, $YY, 0)
	MouseDown("primary")
	MouseUp("primary")
	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = Sin($Rad) * 0.5 * $actualsize * 50 + $pos[0]
		$YY = Cos($Rad) * 0.5 * $actualsize * 50 + $pos[1]
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	If $chain = 0 Then
		MouseMove($pos[0] + $actualsize * (75), $pos[1] + $actualsize * (50), 0)
		$chain = 1
	ElseIf $chain = 1 Then
		MouseMove($pos[0] + $actualsize * (75), $pos[1] + $actualsize * (-50), 0)
		$chain = 0
	EndIf
EndFunc   ;==>draw_cog

Func draw_daisy()
	Local $RMax = @DesktopHeight / (12 * $RTard)
	Local $R = 0
	Local $S = 0.03125
	Local $g = 0
	$pos = MouseGetPos()
	MouseDown("primary")
	For $i = 0 To 4 * $pi Step $S
		If $g = 0 Then
			MouseMove($pos[0] + ($R * ($sizeDraw / 4) * Cos($i)), $pos[1] + ($R * ($sizeDraw / 4) * Sin($i)), 0)
			$R += 4 * $pi
			If $R > $RMax Then $g = 1
		EndIf
		If $g = 1 Then
			MouseMove($pos[0] + ($R * ($sizeDraw / 4) * Cos($i)), $pos[1] + ($R * ($sizeDraw / 4) * Sin($i)), 0)
			$R -= 4 * $pi
			If $R < 0 Then $g = 0
		EndIf
		Sleep(1)
	Next
	MouseUp("primary")
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_daisy

Func draw_eye()
	Local $pos = MouseGetPos()
	$xCircle = $pos[0]
	$yCircle = $pos[1]

	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = 0.75 * Sin($Rad) ^ 5 * (50 * $actualsize) + $xCircle
		$YY = 2 * Cos($Rad) * (50 * $actualsize) + $yCircle
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = 0.6 * Sin($Rad) ^ 5 * (50 * $actualsize) + $xCircle
		$YY = 1.5 * Cos($Rad) * (50 * $actualsize) + $yCircle
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = 0.15 * Sin($Rad) ^ 5 * (50 * $actualsize) + $xCircle
		$YY = 1.5 * Cos($Rad) * (50 * $actualsize) + $yCircle
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	For $R = 360 To 0 Step -10
		$Rad = _Radian($R)
		$XX = Sin($Rad) * (7 * $actualsize) + $xCircle
		$YY = Cos($Rad) * (7 * $actualsize) + $yCircle
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	For $R = 360 To 0 Step -10
		$Rad = _Radian($R)
		$XX = Sin($Rad) * (3 * $actualsize) + $xCircle
		$YY = Cos($Rad) * (3 * $actualsize) + $yCircle + ($actualsize * -78)
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseUp("primary")
	$eyes = $eyes + 1
	If $eyes = 1 Then
		MouseMove($pos[0] + ($actualsize * 37.5), $pos[1] + ($actualsize * 100), 0)
	Else
		$eyes = 0
		MouseMove($pos[0] + ($actualsize * 37.5), $pos[1] + ($actualsize * -100), 0)
	EndIf
EndFunc   ;==>draw_eye

Func draw_framex()
	$tileGap = 0
	$tileLength = 110
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + $h * $x * (($tileGap + $tileLength) / 2), $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * (($tileGap + $tileLength) / 2), 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * (($tileGap + $tileLength) / 2), $pos[1] + $v * $y * $tileLength, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * (($tileGap + $tileLength) / 2), 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * (($tileGap + $tileLength) / 2), $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * (($tileGap + $tileLength) / 2), $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * (($tileGap + $tileLength) / 2), 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * (($tileGap + $tileLength) / 2), $pos[1] + $v * $y * $tileLength, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		$tileLength = $tileLength - 5
		$tileGap = $tileGap + 5
	Until $tileGap >= $tileLength

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_framex

Func draw_framez()
	$tileGap = 0
	$tileLength = 110
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * $tileLength, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * $tileLength, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileGap, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * $tileGap, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tileLength, $pos[1] + $v * $y * $tileLength, 1)
		Sleep($delayDraw)
		MouseUp("primary")
		$tileLength = $tileLength - 5
		$tileGap = $tileGap + 5
	Until $tileGap >= $tileLength

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_framez

Func draw_pansy()
	Local $n = $e
	Local $t = 0
	Local $S = (50 * (($x + $y) / 2))
	Local $R = $S * Sin($n * $t)
	$pos = MouseGetPos()
	MouseDown("primary")
	For $t = 0 To 7 * $pi Step $pi / 64
		$R = $S * Sin($n * $t)
		Local $x = $pos[0] - ($R * Cos($t))
		Local $y = $pos[1] - ($R * Sin($t))
		MouseMove($x, $y, 1)
	Next
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)

EndFunc   ;==>draw_pansy

Func draw_rainbow()
	Local $pos = MouseGetPos()
	$drop = 1
	Do
		For $R = 270 To 90 Step -5
			$Rad = _Radian($R)
			$XX = Sin($Rad) * 1.17 * $drop * 100 * $actualsize + $pos[0] + $actualsize * 117
			$YY = Cos($Rad) * $drop * 100 * $actualsize + $pos[1] + $actualsize * 100
			MouseMove($XX, $YY, 1)
			MouseDown("primary")
		Next
		$drop = $drop - 0.1
		MouseUp("primary")
	Until $drop <= 0.3
	MouseMove($pos[0] + $actualsize * 117 * 2, $pos[1] + $actualsize * 100, 0)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $actualsize * 117 * 1.3, $pos[1] + $actualsize * 100, 0)
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $actualsize * 117 * 0.7, $pos[1] + $actualsize * 100, 0)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0], $pos[1] + $actualsize * 100, 0)
	MouseUp("primary")
	MouseMove($pos[0] + $actualsize * 117 * 0.7, $pos[1], 0)
EndFunc   ;==>draw_rainbow

Func draw_shell()
	$pos = MouseGetPos()
	$shellX = $pos[0]
	$shellY = $pos[1]
	$RMax = @DesktopHeight / 10
	$R = 0
	$shelling = 0

	MouseDown("primary")
	Do
		For $i = 0 To 2 * $pi Step 0.03125
			MouseMove($shellX + ($R * Cos($i)), $shellY + ($R * Sin($i)), 0)
			$R += 0.5
			$shelling = $shelling + 1
			If $R > $RMax Then $R = 0
			Sleep(1)
			$shelling = $shelling + 1
		Next
	Until $shelling >= 2000
	MouseUp("primary")

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_shell

Func draw_spot()
	Local $RMax = @DesktopHeight / (12 * $RTard)
	Local $R = 0
	$pos = MouseGetPos()
	MouseDown("primary")
	TrayTip("", "Press the PAUSE key to terminate current loop", 0)
	Do
		For $i = 0 To 2 * $pi Step 0.25
			MouseMove($pos[0] + ($R * Cos($i)), $pos[1] + ($R * Sin($i)), 0)
			$R += 0.05
			Sleep(1)
		Next
	Until $R > $RMax Or _IsPressed("13")
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_spot

Func draw_swirl()
	Local $RMax = @DesktopHeight / (12 * $RTard)
	Local $R = 0
	Local $S = 0.03
	Local $g = 0
	$pos = MouseGetPos()
	MouseDown("primary")
	For $i = 0 To 18.2 * $pi Step $S
		If $g = 0 Then
			MouseMove($pos[0] + ($R * Cos($i)), $pos[1] + ($R * Sin($i)), 0)
			$R += .1
			If $R > $RMax Then $g = 1
		EndIf
		If $g = 1 Then
			MouseMove($pos[0] + ($R * Cos($i)), $pos[1] + ($R * Sin($i)), 0)
			$R -= .1
			If $R < 0 Then $g = 0
		EndIf
		Sleep(1)
	Next
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_swirl

Func draw_swirly()
	Local $RMax = @DesktopHeight / (6 * $RTard)
	Local $R = 0
	Local $S = 0.05
	Local $g = 0
	$pos = MouseGetPos()
	MouseDown("primary")
	For $i = 0 To 9.25 * $pi Step $S
		If $g = 0 Then
			MouseMove($pos[0] + ($R * Cos($i)), $pos[1] + ($R * Sin($i)), 0)
			$R += .5
			If $R > $RMax Then $g = 1
		EndIf
		If $g = 1 Then
			MouseMove($pos[0] + ($R * Cos($i)), $pos[1] + ($R * Sin($i)), 0)
			$R -= .1
			If $R < 0 Then $g = 0
		EndIf
		Sleep(1)
	Next
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_swirly

Func draw_triangle()
	$pos = MouseGetPos()
	MouseMove($pos[0] + $h * $x * 50, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 100, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 50, $pos[1] + $v * $y * 0, 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 75, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 25, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 50, $pos[1] + $v * $y * (25 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 25, $pos[1] + $v * $y * (25 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 50, $pos[1] + $v * $y * (50 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 75, $pos[1] + $v * $y * (25 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 37, $pos[1] + $v * $y * (25 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseMove($pos[0] + $h * $x * 63, $pos[1] + $v * $y * (25 * Sqrt(3)), 1)
	Sleep($delayDraw)
	MouseUp("primary")

	MouseMove($pos[0] + $h * $x * 50, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_triangle

Func draw_wallflower()
	Local $RMax = @DesktopHeight / (12 * $RTard)
	Local $R = 0
	Local $S = 0.03125
	Local $g = 0
	$pos = MouseGetPos()
	MouseDown("primary")
	For $i = 0 To 4 * $pi Step $S
		If $g = 0 Then
			MouseMove($pos[0] + ($R * ($sizeDraw / 4) * Cos($i)), $pos[1] + ($R * ($sizeDraw / 4) * Sin($i)), 0)
			$R += 8
			If $R > $RMax Then $g = 1
		EndIf
		If $g = 1 Then
			MouseMove($pos[0] + ($R * ($sizeDraw / 4) * Cos($i)), $pos[1] + ($R * ($sizeDraw / 4) * Sin($i)), 0)
			$R -= 8
			If $R < 0 Then $g = 0
		EndIf
		Sleep(1)
	Next
	MouseUp("primary")
	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_wallflower

Func dottie()
	$hd = DllCall("user32.dll", "int", "GetDC", "hwnd", 0)
	$pen = DllCall("gdi32.dll", "int", "CreatePen", "int", 0, "int", $DotWidth, "int", $DotColor)
	DllCall("gdi32.dll", "int", "SelectObject", "int", $hd[0], "int", $pen[0])
	DllCall("GDI32.dll", "int", "MoveToEx", "hwnd", $hd[0], "int", $pos[0], "int", $pos[1], "int", 0)
;~ 	DllCall("GDI32.dll", "int", "LineTo", "hwnd", $hd[0], "int", $pose[0], "int", $pose[1])
	DllCall("GDI32.dll", "int", "LineTo", "hwnd", $hd[0], "int", $pos[0], "int", $pos[1])
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "int", $hd[0])
EndFunc   ;==>dottie

Func hottie()
	Local $DotColor = 0x00FF00
	$hd = DllCall("user32.dll", "int", "GetDC", "hwnd", 0)
	$pen = DllCall("gdi32.dll", "int", "CreatePen", "int", 0, "int", $DotWidth, "int", $DotColor)
	DllCall("gdi32.dll", "int", "SelectObject", "int", $hd[0], "int", $pen[0])
	DllCall("GDI32.dll", "int", "MoveToEx", "hwnd", $hd[0], "int", $pos[0], "int", $pos[1], "int", 0)
	DllCall("GDI32.dll", "int", "LineTo", "hwnd", $hd[0], "int", $pose[0], "int", $pose[1])
	DllCall("GDI32.dll", "int", "LineTo", "hwnd", $hd[0], "int", $pos[0], "int", $pos[1])
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "int", $hd[0])
EndFunc   ;==>hottie

Func SetPixel($handle, $x, $y, $color)
	$dc = DllCall("user32.dll", "int", "GetDC", "hwnd", $handle)
	DllCall("gdi32.dll", "long", "SetPixel", "long", $dc[0], "long", $x, "long", $y, "long", $color)
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "int", $dc[0])
EndFunc   ;==>SetPixel

Func pixelCenter()
	$pos = MouseGetPos()
	While $pixelStart <= 5
		SetPixel("pixelCenter", ($xFocus + 0), ($yFocus + $pixelStart), 0xFF0000)
		SetPixel("pixelCenter", ($xFocus + $pixelStart), ($yFocus + 0), 0xFF0000)
		$pixelStart = $pixelStart + 1
	WEnd
	$pixelStart = -5
EndFunc   ;==>pixelCenter

Func pixelPoint()
	$pos = MouseGetPos()
	While $pixelStart <= 5
		SetPixel("pixelPoint", ($xOne + $pixelStart), ($yOne + $pixelStart), 0xFF0000)
		SetPixel("pixelPoint", ($xOne + $pixelStart), ($yOne - $pixelStart), 0xFF0000)
		$pixelStart = $pixelStart + 1
	WEnd
	$pixelStart = -5
EndFunc   ;==>pixelPoint

Func pixelRectangle()
	$pos = MouseGetPos()
	While $pixelStart <= 5
		SetPixel("pixelRectangle", ($xOne + 5), ($yOne + $pixelStart), 0x3300FF)
		SetPixel("pixelRectangle", ($xOne + $pixelStart), ($yOne + 5), 0x3300FF)
		SetPixel("pixelRectangle", ($xOne - 5), ($yOne + $pixelStart), 0xFF0000)
		SetPixel("pixelRectangle", ($xOne + $pixelStart), ($yOne - 5), 0xFF0000)
		$pixelStart = $pixelStart + 1
	WEnd
	$pixelStart = -5
EndFunc   ;==>pixelRectangle

Func pixelTriangle()
	$pos = MouseGetPos()
	While $pixelStart <= 5
		SetPixel("pixelTriangle", (($xOne + ($pixelStart / 2)) + 2.50), ($yOne + $pixelStart), 0x3300FF)
		SetPixel("pixelTriangle", (($xOne + ($pixelStart / 2)) - 2.50), ($yOne - $pixelStart), 0x3300FF)
		SetPixel("pixelTriangle", ($xOne + $pixelStart), ($yOne + 5), 0xFF0000)
		$pixelStart = $pixelStart + 1
	WEnd
	$pixelStart = -5
EndFunc   ;==>pixelTriangle

Func tacticalCircle()
	$pos = MouseGetPos()
	$xFocus = $pos[0]
	$yFocus = $pos[1]
	$circlestate = 1
	Call("dottie")

	ToolTip("Press TAB to complete circle, Mouse Back to resposition origin, or HOME to terminate circle tool.", 0, 0)

	While $circlestate = 1

		While 1
			If _IsPressed("06") Then
				$pos = MouseGetPos()
				$xTangent = $pose[0]
				$yTangent = $pose[1]
				$xFocus = $pos[0]
				$yFocus = $pos[1]
				Call("dottie")
			EndIf

			If _IsPressed("05") Then
				$pose = MouseGetPos()
				$xTangent = $pose[0]
				$yTangent = $pose[1]
				Call("hottie")
			EndIf

			If _IsPressed("09") And $circlestate = 1 Then
				$pose = MouseGetPos()
				$xTangent = $pose[0]
				$yTangent = $pose[1]
				MouseUp("Primary")

				$radiusSize = Abs(Sqrt((($xTangent - $xFocus) ^ 2) + (($yTangent - $yFocus) ^ 2)))

				For $R = 360 To 0 Step -$radiusSpeed
					$Rad = _Radian($R)
					$RX = Sin($Rad) * $radiusSize + $xFocus
					$RY = Cos($Rad) * $radiusSize + $yFocus
					MouseMove($RX, $RY, 1)
					MouseDown("primary")
				Next

				MouseUp("primary")

				ToolTip("Press TAB to complete another circle, Mouse Back to resposition origin, or HOME to terminate circle tool.", 0, 0)

				ExitLoop
			ElseIf $circlestate = 0 Then
				ExitLoop
			EndIf
		WEnd

	WEnd

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>tacticalCircle

Func toolCircle()
	$pos = MouseGetPos()
	$xFocus = $pos[0]
	$yFocus = $pos[1]
	Call("pixelCenter")

	TrayTip("Press TAB to complete circle.", "Place cursor on the circle's perimeter and press TAB.", 5)
	While 1
		If _IsPressed("09", $dll) Then
			$pose = MouseGetPos()
			$xTangent = $pose[0]
			$yTangent = $pose[1]
			ExitLoop
		EndIf
	WEnd

	$radiusSize = Abs(Sqrt((($xTangent - $xFocus) ^ 2) + (($yTangent - $yFocus) ^ 2)))

	For $R = 360 To 0 Step -$radiusSpeed
		$Rad = _Radian($R)
		$RX = Sin($Rad) * $radiusSize + $xFocus
		$RY = Cos($Rad) * $radiusSize + $yFocus
		MouseMove($RX, $RY, 1)
		MouseDown("primary")
	Next

	MouseUp("primary")

	TrayTip("", "Circle drawn!", 2, 16)
	Call("tip")

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>toolCircle

Func toolLine()
	$pos = MouseGetPos()
	$xOne = $pos[0]
	$yOne = $pos[1]
	Call("pixelPoint")

	TrayTip("Press TAB to complete line.", "Place cursor on the line's endpoint and press TAB.", 5)
	While 1
		If _IsPressed("09", $dll) Then
			$pos = MouseGetPos()
			$xTwo = $pos[0]
			$yTwo = $pos[1]
			ExitLoop
		EndIf
	WEnd

	MouseMove($xOne, $yOne, 0)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo, 0)
	Sleep($delayDraw)
	MouseMove((($xOne + $xTwo) / 2), (($yOne + $yTwo) / 2), 0)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo, 0)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)

	TrayTip("", "Line drawn!", 2, 16)
	Call("tip")

	MouseMove($xTwo, $yTwo, 1)
EndFunc   ;==>toolLine

Func toolOval()
	$pos = MouseGetPos()
	$xFocus = $pos[0]
	$yFocus = $pos[1]
	Call("pixelCenter")

	TrayTip("Press TAB to complete oval.", "Place cursor on the oval's tip and press TAB.", 2, 16)
	While 1
		If _IsPressed("09", $dll) Then
			$pose = MouseGetPos()
			$xTangent = $pose[0]
			$yTangent = $pose[1]
			ExitLoop
		EndIf
	WEnd

	$radiusSize = Abs(Sqrt((($xTangent - $xFocus) ^ 2) + (($yTangent - $yFocus) ^ 2)))

	If Abs($yTangent - $yFocus) >= Abs($xTangent - $xFocus) Then
		For $R = 360 To 0 Step -$radiusSpeed
			$Rad = _Radian($R)
			$RX = Sin($Rad) * 0.5 * $radiusSize + $xFocus
			$RY = Cos($Rad) * $radiusSize + $yFocus
			MouseMove($RX, $RY, 1)
			MouseDown("primary")
		Next

	Else
		For $R = 360 To 0 Step -$radiusSpeed
			$Rad = _Radian($R)
			$RX = Sin($Rad) * $radiusSize + $xFocus
			$RY = Cos($Rad) * 0.5 * $radiusSize + $yFocus
			MouseMove($RX, $RY, 1)
			MouseDown("primary")
		Next
	EndIf

	MouseUp("primary")

	TrayTip("", "Oval drawn!", 2, 16)
	Call("tip")

	MouseMove($pos[0] + $h * $x * 0, $pos[1] + $v * $y * 0, 1)
EndFunc   ;==>toolOval

Func toolRectangle()
	$pos = MouseGetPos()
	$xOne = $pos[0]
	$yOne = $pos[1]
	Call("pixelRectangle")

	TrayTip("Press TAB to complete rectangle.", "Place cursor on the rectangle's bottom right corner and press TAB.", 2, 16)
	While 1
		If _IsPressed("09", $dll) Then
			$pos = MouseGetPos()
			$xTwo = $pos[0]
			$yTwo = $pos[1]
			ExitLoop
		EndIf
	WEnd

	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($xOne, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo - 2, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo - 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 1, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 2, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 2, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 1, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo - 1, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo - 2, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne + 2, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 1, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 2, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 2, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 1, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)

	TrayTip("", "Rectangle drawn!", 2, 16)
	Call("tip")

	MouseMove($xOne, $yOne, 1)
EndFunc   ;==>toolRectangle

Func toolSquare()
	$pos = MouseGetPos()
	$xOne = $pos[0]
	$yOne = $pos[1]

	TrayTip("Press TAB to complete square.", "Place cursor on the square's bottom right corner and press TAB.", 2, 16)
	While 1
		If _IsPressed("09", $dll) Then
			$pos = MouseGetPos()
			$xTwo = $pos[0]
			$yTwo = $pos[1]
			ExitLoop
		EndIf
	WEnd

	Select

		Case Abs($xTwo - $xOne) > Abs($yTwo - $yOne)
			$yTwo = $yOne + Abs($xTwo - $xOne)
		Case Abs($yTwo - $yOne) > Abs($xTwo - $xOne)
			$xTwo = $xOne + Abs($yTwo - $yOne)

	EndSelect

	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($xOne, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo - 2, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo - 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 1, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 2, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 2, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 1, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo - 1, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo - 2, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne + 2, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xTwo, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 1, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xTwo - 2, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 2, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne + 1, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne + 1, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)

	TrayTip("", "Square drawn!", 5, 16)

	MouseMove($xOne, $yOne, 1)
EndFunc   ;==>toolSquare

Func toolTriangle()
	$pos = MouseGetPos()
	$xOne = $pos[0]
	$yOne = $pos[1]
	Call("pixelTriangle")

	TrayTip("Press TAB to complete triangle.", "Place cursor on the triangle's bottom corner and press TAB.", 2, 16)
	While 1
		If _IsPressed("09", $dll) Then
			$pos = MouseGetPos()
			$xTwo = $pos[0]
			$yTwo = $pos[1]
			ExitLoop
		EndIf
	WEnd

	MouseMove($xOne, $yTwo, 1)
	Sleep($delayDraw)
	MouseDown("primary")
	Sleep($delayDraw)
	MouseMove($xTwo, $yTwo, 1)
	Sleep($delayDraw)
	MouseMove($xOne, $yOne, 1)
	Sleep($delayDraw)
	MouseMove(((2 * $xOne) - $xTwo), $yTwo, 1)
	Sleep($delayDraw)
	MouseMove(((($xTwo - $xOne) / (4 / 3)) + $xOne), $yTwo, 1)
	Sleep($delayDraw)
	MouseMove(((($xTwo - $xOne) / 4) + $xOne), $yTwo, 1)
	Sleep($delayDraw)
	MouseUp("primary")
	Sleep($delayDraw)

	TrayTip("", "Triangle drawn!", 2, 16)
	Call("tip")

	MouseMove($xOne, $yOne, 1)
EndFunc   ;==>toolTriangle

Func draw_astroid()
	Local $pos = MouseGetPos()
	For $R = 360 To 0 Step -5
		$Rad = _Radian($R)
		$XX = Sin($Rad) ^ 5 * 100 * $actualsize + $pos[0]
		$YY = Cos($Rad) ^ 5 * 100 * $actualsize + $pos[1]
		MouseMove($XX, $YY, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
	Sleep($delayDraw)
	If $steel = 1 Then
		$hypo = $hypo + 1
		Switch $hypo
			Case 1
				MouseMove($pos[0] + $actualsize * (100), $pos[1] + $actualsize * (100), 0)
			Case 2
				MouseMove($pos[0] + $actualsize * (-100), $pos[1] + $actualsize * (100), 0)
			Case 3
				MouseMove($pos[0] + $actualsize * (-100), $pos[1] + $actualsize * (-100), 0)
			Case Else
				MouseMove($pos[0] + $actualsize * (+100), $pos[1] + $actualsize * (-100), 0)
				$hypo = 0
		EndSwitch
	Else
		MouseMove($pos[0], $pos[1], 0)
	EndIf
EndFunc   ;==>draw_astroid

Func draw_butterfly()
	$pos = MouseGetPos()
	$t = 0
	$wingspan = (($x + $y) / 2) * 20
	$xWing = ($pos[0]) - $wingspan * (Sin($t) * ($e ^ (Cos($t)) - 2 * Cos(4 * $t) + Sin($t / 12)))
	$yWing = ($pos[1]) - $wingspan * (Cos($t) * ($e ^ (Cos($t)) - 2 * Cos(4 * $t) + Sin($t / 12)))
	MouseMove($xWing, $yWing, 1)
	MouseDown("primary")
	For $t = 0 To 12.6 Step .02
		$xWing = ($pos[0]) - $wingspan * (Sin($t) * ($e ^ (Cos($t)) - 2 * Cos(4 * $t) + Sin($t / 12)))
		$yWing = ($pos[1]) - $wingspan * (Cos($t) * ($e ^ (Cos($t)) - 2 * Cos(4 * $t) + Sin($t / 12)))
		MouseMove($xWing, $yWing, 1)
	Next
	MouseUp("primary")
EndFunc   ;==>draw_butterfly

Func draw_tetra()
	$tetraY1 = 0
	$tetraX1 = 0
	$tetraY2 = 100
	$tetraX2 = 100
	$i = 0
	$depth = 150
	$posOriginal = MouseGetPos()
	MouseMove($posOriginal[0] + $h * $x * $tetraX1 + ($depth), $posOriginal[1] + $v * $y * $tetraY1 + ($depth), 1)
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + $h * $x * $tetraX1 - $i, $pos[1] + $v * $y * $tetraY1 + $i, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tetraX1 + $i, $pos[1] + $v * $y * $tetraY2 + $i, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tetraX2 + $i, $pos[1] + $v * $y * $tetraY2 - $i, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tetraX2 - $i, $pos[1] + $v * $y * $tetraY1 - $i, 1)
		Sleep($delayDraw)
		MouseMove($pos[0] + $h * $x * $tetraX1 - $i, $pos[1] + $v * $y * $tetraY1 + $i, 1)
		Sleep($delayDraw)
		$i = $i + 10
	Until $i >= $depth
	MouseUp("primary")

	MouseMove($posOriginal[0] + $h * $x * 0, $posOriginal[1] + $v * $y * 0, 1)
EndFunc   ;==>draw_tetra

Func draw_grid()
	$linecount = 1
	$pos = MouseGetPos()
	Do
		MouseMove($pos[0] + 0, $pos[1] + $Spacing * $linecount * $actualsize, 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + ($Spacing * ($Columns + 1)) * $actualsize, $pos[1] + $Spacing * $linecount * $actualsize, 1)
		$linecount = $linecount + 1
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
	Until $linecount = $Rows + 1
	$linecount = 1

	Do
		MouseMove($pos[0] + $Spacing * $linecount * $actualsize, $pos[1], 1)
		Sleep($delayDraw)
		MouseDown("primary")
		Sleep($delayDraw)
		MouseMove($pos[0] + ($Spacing * $linecount) * $actualsize, $pos[1] + $Spacing * ($Rows + 1) * $actualsize, 1)
		$linecount = $linecount + 1
		Sleep($delayDraw)
		MouseUp("primary")
		Sleep($delayDraw)
	Until $linecount = $Columns + 1
	$linecount = 1

	MouseMove($pos[0] + 0, $pos[1] + 0, 1)
EndFunc   ;==>draw_grid

Func Chamber()
	$filehnd = FileOpen($file, 0)
	If FileExists($file) = 0 Then
		TrayTip("", "" & $file & " not found! :(", 2, 16)
	Else
		$filename = StringSplit($file, ".")
		GUICtrlSetData($Label4, $filename[1])
		ToolTip("" & $file & " loaded.", 0, 0)
		If $skip = 1 Then
			Call("Inscribe")
		EndIf
	EndIf
EndFunc   ;==>Chamber

Func Inscribe()
	If $active = 0 Then
		$active = 1
		$Aborted = 0
		$totallines = _FileCountLines($file)
		For $i = _FileCountLines($file) To 1 Step -1
			Global $line = FileReadLine($filehnd)
			Global $array = StringSplit($line, ",")
			Global $progress = Round(($totallines - $i) / $totallines * 100)
			If $array[1] = "mg" Then
				$pos = MouseGetPos()
			ElseIf $array[1] = "md" Then
				MouseDown("Primary")
			ElseIf $array[1] = "mu" Then
				MouseUp("Primary")
			ElseIf $array[1] = "dc" Then
				Call("draw_circool")
			ElseIf $array[1] = "cc" Then
				Call("draw_circust")
			ElseIf $array[1] = "oval" Then
				Call("draw_ellipse")
			ElseIf $array[1] = "spiral" Then
				Call("draw_spiral")
			ElseIf $array[1] = "vp" Then
				Call("vpower")
			ElseIf $array[1] = "xp" Then
				Call("xpower")
			ElseIf $array[1] = "rtc" Then
				MouseMove($cgp[0], $cgp[1], 0)
			ElseIf $array[1] = "tan" Then
				Call("tangent")
			ElseIf @error Then
				Return
			ElseIf $arrays = "Rotary" Then
				MouseMove($pos[0] + ($h * $x * (-1 * $array[2])), $pos[1] + ($v * $y * (1 * $array[1])), 1)
				Call("Progression")
			ElseIf $arrays = "Rotated" Then
				MouseMove($pos[0] + ($h * $x * (1 * $array[2])), $pos[1] + ($v * $y * (1 * $array[1])), 1)
				Call("Progression")
			ElseIf $arrays = "Rotasis" Then
				MouseMove($pos[0] + ($h * $x * (1 * $array[2])), $pos[1] + ($v * $y * (-1 * $array[1])), 1)
				Call("Progression")
			ElseIf $arrays = "Rotato" Then
				MouseMove($pos[0] + ($h * $x * (-1 * $array[2])), $pos[1] + ($v * $y * (-1 * $array[1])), 1)
				Call("Progression")
			Else
				MouseMove($pos[0] + ($h * $x * (1 * $array[1])), $pos[1] + ($v * $y * (1 * $array[2])), 1)
				Call("Progression")
			EndIf
		Next
		FileClose($file)
		$filehnd = FileOpen($file, 0)
		GUICtrlSetData($Label5, 100)
		Call("tip")
		$active = 0
	EndIf
EndFunc   ;==>Inscribe

Func Progression()
	ToolTip("" & $filename[1] & ": " & $progress & "%", 0, 0)
	GUICtrlSetData($Label5, $progress)
	Sleep($delayDraw)
	If $Aborted = 1 Then
		TrayTip("", "Drawing aborted!", 2, 3)
		MouseUp("Primary")
		MouseMove($pos[0], $pos[1], 1)
		$Aborted = 0
		FileClose($file)
		$filehnd = FileOpen($file, 0)
		ToolTip("" & $filename[1] & " successfully aborted!", 0, 0)
		Return
	EndIf
EndFunc   ;==>Progression

Func draw_circoal()
	Local $pos = MouseGetPos()
	$xCircle = $pos[0]
	$yCircle = $pos[1]

	For $R = 360 To 0 Step -10
		$Rad = _Radian($R)
		$XX = Sin($Rad) * (100 * $actualsize) + $xCircle
		$YY = Cos($Rad) * (100 * $actualsize) + $yCircle
		MouseMove($XX, $YY, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
	MouseMove($pos[0] + 0, $pos[1] + 0, 0)
EndFunc   ;==>draw_circoal

Func draw_circool()
	Local $pos = MouseGetPos()
	If StringInStr($line, ",", 0, 2) > 0 Then
		Local $stone = $array[3]
	Else
		Local $stone = 6
	EndIf
	For $R = 360 To 0 Step -$stone
		$Rad = _Radian($R)
		$XX = Sin($Rad) * ($actualsize * $array[2]) + $pos[0]
		$YY = Cos($Rad) * ($actualsize * $array[2]) + $pos[1]
		MouseMove($XX, $YY, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
	MouseMove($pos[0] + 0, $pos[1] + 0, 1)
EndFunc   ;==>draw_circool

Func draw_circust()
	$cgp = MouseGetPos()
	$array[4] = Number($array[4])
	$array[5] = Number($array[5])
	If $array[4] < $array[5] Then
		For $R = $array[4] To $array[5] Step $array[6]
			$Rad = _Radian($R)
			$XX = Sin($Rad) * $array[2] * $actualsize + $cgp[0]
			$YY = Cos($Rad) * $array[3] * $actualsize + $cgp[1]
			MouseMove($XX, $YY, 1)
			MouseDown("primary")
		Next
	Else
		For $R = $array[4] To $array[5] Step -$array[6]
			$Rad = _Radian($R)
			$XX = Sin($Rad) * $array[2] * $actualsize + $cgp[0]
			$YY = Cos($Rad) * $array[3] * $actualsize + $cgp[1]
			MouseMove($XX, $YY, 1)
			MouseDown("primary")
		Next
	EndIf
	MouseUp("primary")
	MouseMove($cgp[0], $cgp[1], 0)
EndFunc   ;==>draw_circust

Func draw_ellipse()
	Local $pos = MouseGetPos()
	$array[4] = Number($array[4])
	$array[5] = Number($array[5])
	If $array[4] < $array[5] Then
		For $R = ($array[4] * $ovulation) To ($array[5] * $ovulation) Step ($array[6] * $ovulation)
			$XX = $array[2] * Cos($R) * Cos(($array[7] * $ovulation)) - $array[3] * Sin($R) * Sin(($array[7] * $ovulation))
			$YY = $array[2] * Cos($R) * Sin(($array[7] * $ovulation)) + $array[3] * Sin($R) * Cos(($array[7] * $ovulation))
			MouseMove($XX + $pos[0], $YY + $pos[1], 1)
			MouseDown("primary")
		Next
	Else
		For $R = ($array[4] * $ovulation) To ($array[5] * $ovulation) Step -($array[6] * $ovulation)
			$XX = $array[2] * Cos($R) * Cos(($array[7] * $ovulation)) - $array[3] * Sin($R) * Sin(($array[7] * $ovulation))
			$YY = $array[2] * Cos($R) * Sin(($array[7] * $ovulation)) + $array[3] * Sin($R) * Cos(($array[7] * $ovulation))
			MouseMove($XX + $pos[0], $YY + $pos[1], 1)
			MouseDown("primary")
		Next
	EndIf
	MouseUp("primary")
	MouseMove($pos[0], $pos[1], 0)
EndFunc   ;==>draw_ellipse

Func draw_spiral()
	Local $pos = MouseGetPos()
	Local $angle = 0.1
	Local $click = 0
	$array[2] = Number($array[2])
	$array[3] = Number($array[3])
	$array[4] = Number($array[4])
	Local $backlash = $array[4]
	If $array[2] < $array[3] Then
		Local $xt = Sin
		Local $yt = Cos
		Local $radius = $array[2]
		Local $turnaround = $array[3]
	Else
		Local $xt = Cos
		Local $yt = Sin
		Local $radius = $array[3]
		Local $turnaround = $array[2]
	EndIf
	Do
		$radius += $array[5]
		$angle += $array[6]
		MouseMove($pos[0] + $xt($angle) * $radius, $pos[1] + $yt($angle) * $radius, 1)
		If $click = 0 Then
			MouseDown("primary")
			$click = 1
		EndIf
	Until $radius >= $turnaround
	Do
		$radius -= $array[5]
		$angle += $array[6]
		MouseMove($pos[0] + $xt($angle) * $radius, $pos[1] + $yt($angle) * $radius, 1)
	Until $radius <= $backlash
	MouseUp("primary")
	MouseMove($pos[0], $pos[1], 0)
EndFunc   ;==>draw_spiral

Func vpower()
	Local $pos = MouseGetPos()
	For $YY = $array[4] To $array[5] Step $array[6]
		$XX = ($array[2] * $YY ^ $array[3])
		MouseMove($pos[0] + $XX * $actualsize, $pos[1] + $YY * $actualsize, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
EndFunc   ;==>vpower

Func xpower()
	Local $pos = MouseGetPos()
	For $XX = $array[4] To $array[5] Step $array[6]
		$YY = ($array[2] * $XX ^ $array[3])
		MouseMove($pos[0] + $XX * $actualsize, $pos[1] + $YY * $actualsize, 1)
		MouseDown("primary")
	Next
	MouseUp("primary")
EndFunc   ;==>xpower

Func tangent()
	For $R = $array[4] To $array[4]
		$Rad = _Radian($R)
		$XX = Sin($Rad) * $array[2] * $actualsize + $cgp[0]
		$YY = Cos($Rad) * $array[3] * $actualsize + $cgp[1]
		MouseMove($XX, $YY, 1)
	Next
EndFunc   ;==>tangent

Func draw_pizza()
	If $slices = 0 Then
		$center = MouseGetPos()
		$start = 180
		$end = $start - 30
	EndIf
	MouseMove($center[0], $center[1], 0)
	MouseDown("primary")
	For $R = $start To $end Step -5
		$Rad = _Radian($R)
		$XX = Sin($Rad) * (100 * $actualsize) + $center[0]
		$YY = Cos($Rad) * (100 * $actualsize) + $center[1]
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	MouseMove($center[0], $center[1], 1)
	Sleep(5)
	For $R = $start To $end Step -5
		$Rad = _Radian($R)
		$XX = Sin($Rad) * (0.9 * 100 * $actualsize) + $center[0]
		$YY = Cos($Rad) * (0.9 * 100 * $actualsize) + $center[1]
		MouseMove($XX, $YY, 0)
		MouseDown("primary")
	Next
	$start = $start - 30
	$end = $end - 30
	MouseMove($center[0], $center[1], 0)
	MouseUp("primary")
	$slices = $slices + 1
	If $slices >= 12 Then
		$slices = 0
		MouseMove($center[0] + 200 * $actualsize, $center[1], 0)
	EndIf
EndFunc   ;==>draw_pizza

Func draw_agent()
	$file = "draw_agent.txt"
	Call("Chamber")
EndFunc   ;==>draw_agent

Func draw_ak47()
	$file = "draw_ak47.txt"
	Call("Chamber")
EndFunc   ;==>draw_ak47

Func draw_alien()
	$file = "draw_alien.txt"
	Call("Chamber")
EndFunc   ;==>draw_alien

Func draw_allstar()
	$file = "draw_allstar.txt"
	Call("Chamber")
EndFunc   ;==>draw_allstar

Func draw_alone()
	$file = "draw_alone.txt"
	Call("Chamber")
EndFunc   ;==>draw_alone

Func draw_android()
	$file = "draw_android.txt"
	Call("Chamber")
EndFunc   ;==>draw_android

Func draw_apple()
	$file = "draw_apple.txt"
	Call("Chamber")
EndFunc   ;==>draw_apple

Func draw_atom()
	$file = "draw_atom.txt"
	Call("Chamber")
EndFunc   ;==>draw_atom

Func draw_AUS()
	$file = "draw_AUS.txt"
	Call("Chamber")
EndFunc   ;==>draw_AUS

Func draw_autobot()
	$file = "draw_autobot.txt"
	Call("Chamber")
EndFunc   ;==>draw_autobot

Func draw_axe()
	$file = "draw_axe.txt"
	Call("Chamber")
EndFunc   ;==>draw_axe

Func draw_banana()
	$file = "draw_banana.txt"
	Call("Chamber")
EndFunc   ;==>draw_banana

Func draw_barn()
	$file = "draw_barn.txt"
	Call("Chamber")
EndFunc   ;==>draw_barn

Func draw_bart()
	$file = "draw_bart.txt"
	Call("Chamber")
EndFunc   ;==>draw_bart

Func draw_batman()
	$file = "draw_batman.txt"
	Call("Chamber")
EndFunc   ;==>draw_batman

Func draw_bear()
	$file = "draw_bear.txt"
	Call("Chamber")
EndFunc   ;==>draw_bear

Func draw_beavis()
	$file = "draw_beavis.txt"
	Call("Chamber")
EndFunc   ;==>draw_beavis

Func draw_bicycle()
	$file = "draw_bicycle.txt"
	Call("Chamber")
EndFunc   ;==>draw_bicycle

Func draw_bieber()
	$file = "draw_bieber.txt"
	Call("Chamber")
EndFunc   ;==>draw_bieber

Func draw_bingo()
	$file = "draw_bingo.txt"
	Call("Chamber")
EndFunc   ;==>draw_bingo

Func draw_birdy()
	$file = "draw_birdy.txt"
	Call("Chamber")
EndFunc   ;==>draw_birdy

Func draw_blade()
	$file = "draw_blade.txt"
	Call("Chamber")
EndFunc   ;==>draw_blade

Func draw_bomb()
	$file = "draw_bomb.txt"
	Call("Chamber")
EndFunc   ;==>draw_bomb

Func draw_bomber()
	$file = "draw_bomber.txt"
	Call("Chamber")
EndFunc   ;==>draw_bomber

Func draw_boo()
	$file = "draw_boo.txt"
	$filehnd = FileOpen($file, 0)
	If FileExists($file) = 0 Then
		TrayTip("", "" & $file & " not found! :(", 2, 16)
	Else
		$filename = StringSplit($file, ".")
		GUICtrlSetData($Label4, $filename[1])
		ToolTip("" & $file & " loaded.", 0, 0)
		If $skip = 1 Then
			Call("Inscribe")
			WinSetTrans($SSMain, "", 255)
		EndIf
	EndIf
EndFunc   ;==>draw_boo

Func draw_book()
	$file = "draw_book.txt"
	Call("Chamber")
EndFunc   ;==>draw_book

Func draw_bowl()
	$file = "draw_bowl.txt"
	Call("Chamber")
EndFunc   ;==>draw_bowl

Func draw_box()
	$file = "draw_box.txt"
	Call("Chamber")
EndFunc   ;==>draw_box

Func draw_brain()
	$file = "draw_brain.txt"
	Call("Chamber")
EndFunc   ;==>draw_brain

Func draw_bubblegum()
	$file = "draw_bubblegum.txt"
	Call("Chamber")
EndFunc   ;==>draw_bubblegum

Func draw_buffalo()
	$file = "draw_buffalo.txt"
	Call("Chamber")
EndFunc   ;==>draw_buffalo

Func draw_bull()
	$file = "draw_bull.txt"
	Call("Chamber")
EndFunc   ;==>draw_bull

Func draw_bummed()
	$file = "draw_bummed.txt"
	Call("Chamber")
EndFunc   ;==>draw_bummed

Func draw_bunny()
	$file = "draw_bunny.txt"
	Call("Chamber")
EndFunc   ;==>draw_bunny

Func draw_cake()
	$file = "draw_cake.txt"
	Call("Chamber")
EndFunc   ;==>draw_cake

Func draw_car()
	$file = "draw_car.txt"
	Call("Chamber")
EndFunc   ;==>draw_car

Func draw_cardinal()
	$file = "draw_cardinal.txt"
	Call("Chamber")
EndFunc   ;==>draw_cardinal

Func draw_cartman()
	$file = "draw_cartman.txt"
	Call("Chamber")
EndFunc   ;==>draw_cartman

Func draw_castle()
	$file = "draw_castle.txt"
	Call("Chamber")
EndFunc   ;==>draw_castle

Func draw_cat()
	$file = "draw_cat.txt"
	Call("Chamber")
EndFunc   ;==>draw_cat

Func draw_cattail()
	$file = "draw_cattail.txt"
	Call("Chamber")
EndFunc   ;==>draw_cattail

Func draw_chain()
	$file = "draw_chain.txt"
	Call("Chamber")
EndFunc   ;==>draw_chain

Func draw_chick()
	$file = "draw_chick.txt"
	Call("Chamber")
EndFunc   ;==>draw_chick

Func draw_chili()
	$file = "draw_chili.txt"
	Call("Chamber")
EndFunc   ;==>draw_chili

Func draw_chrome()
	$file = "draw_chrome.txt"
	Call("Chamber")
EndFunc   ;==>draw_chrome

Func draw_cloud()
	$file = "draw_cloud.txt"
	Call("Chamber")
EndFunc   ;==>draw_cloud

Func draw_CND()
	$file = "draw_CND.txt"
	Call("Chamber")
EndFunc   ;==>draw_CND

Func draw_computer()
	$file = "draw_computer.txt"
	Call("Chamber")
EndFunc   ;==>draw_computer

Func draw_controller()
	$file = "draw_controller.txt"
	Call("Chamber")
EndFunc   ;==>draw_controller

Func draw_cow()
	$file = "draw_cow.txt"
	Call("Chamber")
EndFunc   ;==>draw_cow

Func draw_crab()
	$file = "draw_crab.txt"
	Call("Chamber")
EndFunc   ;==>draw_crab

Func draw_crash()
	$file = "draw_crash.txt"
	Call("Chamber")
EndFunc   ;==>draw_crash

Func draw_crossbones()
	$file = "draw_crossbones.txt"
	Call("Chamber")
EndFunc   ;==>draw_crossbones

Func draw_cube()
	$file = "draw_cube.txt"
	Call("Chamber")
EndFunc   ;==>draw_cube

Func draw_daffodil()
	$file = "draw_daffodil.txt"
	Call("Chamber")
EndFunc   ;==>draw_daffodil

Func draw_dancers()
	$file = "draw_dancers.txt"
	Call("Chamber")
EndFunc   ;==>draw_dancers

Func draw_daria()
	$file = "draw_daria.txt"
	Call("Chamber")
EndFunc   ;==>draw_daria

Func draw_deagle()
	$file = "draw_deagle.txt"
	Call("Chamber")
EndFunc   ;==>draw_deagle

Func draw_diner()
	$file = "draw_diner.txt"
	Call("Chamber")
EndFunc   ;==>draw_diner

Func draw_dish()
	$file = "draw_dish.txt"
	Call("Chamber")
EndFunc   ;==>draw_dish

Func draw_dog()
	$file = "draw_dog.txt"
	Call("Chamber")
EndFunc   ;==>draw_dog

Func draw_dolphin()
	$file = "draw_dolphin.txt"
	Call("Chamber")
EndFunc   ;==>draw_dolphin

Func draw_domino()
	$file = "draw_domino.txt"
	Call("Chamber")
EndFunc   ;==>draw_domino

Func draw_doodle()
	$file = "draw_doodle.txt"
	Call("Chamber")
EndFunc   ;==>draw_doodle

Func draw_dragon()
	$file = "draw_dragon.txt"
	Call("Chamber")
EndFunc   ;==>draw_dragon

Func draw_droplet()
	$file = "draw_droplet.txt"
	Call("Chamber")
EndFunc   ;==>draw_droplet

Func draw_eagle()
	$file = "draw_eagle.txt"
	Call("Chamber")
EndFunc   ;==>draw_eagle

Func draw_ear()
	$file = "draw_ear.txt"
	Call("Chamber")
EndFunc   ;==>draw_ear

Func draw_eggplant()
	$file = "draw_eggplant.txt"
	Call("Chamber")
EndFunc   ;==>draw_eggplant

Func draw_eiffel()
	$file = "draw_eiffel.txt"
	Call("Chamber")
EndFunc   ;==>draw_eiffel

Func draw_elephant()
	$file = "draw_elephant.txt"
	Call("Chamber")
EndFunc   ;==>draw_elephant

Func draw_elf()
	$file = "draw_elf.txt"
	Call("Chamber")
EndFunc   ;==>draw_elf

Func draw_emblem()
	$file = "draw_emblem.txt"
	Call("Chamber")
EndFunc   ;==>draw_emblem

Func draw_example()
	$file = "draw_example.txt"
	Call("Chamber")
EndFunc   ;==>draw_example

Func draw_experiment()
	$file = "draw_experiment.txt"
	Call("Chamber")
EndFunc   ;==>draw_experiment

Func draw_fairy()
	$file = "draw_fairy.txt"
	Call("Chamber")
EndFunc   ;==>draw_fairy

Func draw_feather()
	$file = "draw_feather.txt"
	Call("Chamber")
EndFunc   ;==>draw_feather

Func draw_feels()
	$file = "draw_feels.txt"
	Call("Chamber")
EndFunc   ;==>draw_feels

Func draw_fender()
	$file = "draw_fender.txt"
	Call("Chamber")
EndFunc   ;==>draw_fender

Func draw_flame()
	$file = "draw_flame.txt"
	Call("Chamber")
EndFunc   ;==>draw_flame

Func draw_flask()
	$file = "draw_flask.txt"
	Call("Chamber")
EndFunc   ;==>draw_flask

Func draw_foot()
	$file = "draw_foot.txt"
	Call("Chamber")
EndFunc   ;==>draw_foot

Func draw_fox()
	$file = "draw_fox.txt"
	Call("Chamber")
EndFunc   ;==>draw_fox

Func draw_fry()
	$file = "draw_fry.txt"
	Call("Chamber")
EndFunc   ;==>draw_fry

Func draw_gameboy()
	$file = "draw_gameboy.txt"
	Call("Chamber")
EndFunc   ;==>draw_gameboy

Func draw_gator()
	$file = "draw_gator.txt"
	Call("Chamber")
EndFunc   ;==>draw_gator

Func draw_ghost()
	$file = "draw_boo.txt"
	$filehnd = FileOpen($file, 0)
	If FileExists($file) = 0 Then
		TrayTip("", "" & $file & " not found! :(", 2, 16)
	Else
		$filename = StringSplit($file, ".")
		GUICtrlSetData($Label4, $filename[1])
		ToolTip("" & $file & " loaded.", 0, 0)
		If $skip = 1 Then
			Call("Inscribe")
			WinSetTrans($SSMain, "", 255)
		EndIf
	EndIf
EndFunc   ;==>draw_ghost

Func draw_glass()
	$file = "draw_glass.txt"
	Call("Chamber")
EndFunc   ;==>draw_glass

Func draw_goldfish()
	$file = "draw_goldfish.txt"
	Call("Chamber")
EndFunc   ;==>draw_goldfish

Func draw_hand()
	$file = "draw_hand.txt"
	Call("Chamber")
EndFunc   ;==>draw_hand

Func draw_harrier()
	$file = "draw_harrier.txt"
	Call("Chamber")
EndFunc   ;==>draw_harrier

Func draw_heart()
	$file = "draw_heart.txt"
	Call("Chamber")
EndFunc   ;==>draw_heart

Func draw_hedgehog()
	$file = "draw_hedgehog.txt"
	Call("Chamber")
EndFunc   ;==>draw_hedgehog

Func draw_helmet()
	$file = "draw_helmet.txt"
	Call("Chamber")
EndFunc   ;==>draw_helmet

Func draw_home()
	$file = "draw_home.txt"
	Call("Chamber")
EndFunc   ;==>draw_home

Func draw_horse()
	$file = "draw_horse.txt"
	Call("Chamber")
EndFunc   ;==>draw_horse

Func draw_hourglass()
	$file = "draw_hourglass.txt"
	Call("Chamber")
EndFunc   ;==>draw_hourglass

Func draw_intersection()
	$file = "draw_intersection.txt"
	Call("Chamber")
EndFunc   ;==>draw_intersection

Func draw_lady()
	$file = "draw_lady.txt"
	Call("Chamber")
EndFunc   ;==>draw_lady

Func draw_lamp()
	$file = "draw_lamp.txt"
	Call("Chamber")
EndFunc   ;==>draw_lamp

Func draw_lantern()
	$file = "draw_lantern.txt"
	Call("Chamber")
EndFunc   ;==>draw_lantern

Func draw_leaf()
	$file = "draw_leaf.txt"
	Call("Chamber")
EndFunc   ;==>draw_leaf

Func draw_lemon()
	$file = "draw_lemon.txt"
	Call("Chamber")
EndFunc   ;==>draw_lemon

Func draw_light()
	$file = "draw_light.txt"
	Call("Chamber")
EndFunc   ;==>draw_light

Func draw_lightning()
	$file = "draw_lightning.txt"
	Call("Chamber")
EndFunc   ;==>draw_lightning

Func draw_lizard()
	$file = "draw_lizard.txt"
	Call("Chamber")
EndFunc   ;==>draw_lizard

Func draw_java()
	$file = "draw_java.txt"
	Call("Chamber")
EndFunc   ;==>draw_java

Func draw_jewel()
	$file = "draw_jewel.txt"
	Call("Chamber")
EndFunc   ;==>draw_jewel

Func draw_joker()
	$file = "draw_joker.txt"
	Call("Chamber")
EndFunc   ;==>draw_joker

Func draw_key()
	$file = "draw_key.txt"
	Call("Chamber")
EndFunc   ;==>draw_key

Func draw_kid()
	$file = "draw_kid.txt"
	Call("Chamber")
EndFunc   ;==>draw_kid

Func draw_kirby()
	$file = "draw_kirby.txt"
	Call("Chamber")
EndFunc   ;==>draw_kirby

Func draw_kitty()
	$file = "draw_kitty.txt"
	Call("Chamber")
EndFunc   ;==>draw_kitty

Func draw_knight()
	$file = "draw_knight.txt"
	Call("Chamber")
EndFunc   ;==>draw_knight

Func draw_m16()
	$file = "draw_m16.txt"
	Call("Chamber")
EndFunc   ;==>draw_m16

Func draw_mario()
	$file = "draw_mario.txt"
	Call("Chamber")
EndFunc   ;==>draw_mario

Func draw_maid()
	$file = "draw_maid.txt"
	Call("Chamber")
EndFunc   ;==>draw_maid

Func draw_mask()
	$file = "draw_mask.txt"
	Call("Chamber")
EndFunc   ;==>draw_mask

Func draw_mickey()
	$file = "draw_mickey.txt"
	Call("Chamber")
EndFunc   ;==>draw_mickey

Func draw_misty()
	$file = "draw_misty.txt"
	Call("Chamber")
EndFunc   ;==>draw_misty

Func draw_mouse()
	$file = "draw_mouse.txt"
	Call("Chamber")
EndFunc   ;==>draw_mouse

Func draw_mulan()
	$file = "draw_mulan.txt"
	Call("Chamber")
EndFunc   ;==>draw_mulan

Func draw_mushroom()
	$file = "draw_mushroom.txt"
	Call("Chamber")
EndFunc   ;==>draw_mushroom

Func draw_nazi()
	$file = "draw_nazi.txt"
	Call("Chamber")
EndFunc   ;==>draw_nazi

Func draw_ninja()
	$file = "draw_ninja.txt"
	Call("Chamber")
EndFunc   ;==>draw_ninja

Func draw_nurse()
	$file = "draw_nurse.txt"
	Call("Chamber")
EndFunc   ;==>draw_nurse

Func draw_octagon()
	$file = "draw_octagon.txt"
	Call("Chamber")
EndFunc   ;==>draw_octagon

Func draw_olympics()
	$file = "draw_olympics.txt"
	Call("Chamber")
EndFunc   ;==>draw_olympics

Func draw_painter()
	$file = "draw_painter.txt"
	Call("Chamber")
EndFunc   ;==>draw_painter

Func draw_panda()
	$file = "draw_panda.txt"
	Call("Chamber")
EndFunc   ;==>draw_panda

Func draw_peach()
	$file = "draw_peach.txt"
	Call("Chamber")
EndFunc   ;==>draw_peach

Func draw_penguin()
	$file = "draw_penguin.txt"
	Call("Chamber")
EndFunc   ;==>draw_penguin

Func draw_phoenix()
	$file = "draw_phoenix.txt"
	Call("Chamber")
EndFunc   ;==>draw_phoenix

Func draw_phonebooth()
	$file = "draw_phonebooth.txt"
	Call("Chamber")
EndFunc   ;==>draw_phonebooth

Func draw_pickaxe()
	$file = "draw_pickaxe.txt"
	Call("Chamber")
EndFunc   ;==>draw_pickaxe

Func draw_pikachu()
	$file = "draw_pikachu.txt"
	Call("Chamber")
EndFunc   ;==>draw_pikachu

Func draw_plane()
	$file = "draw_plane.txt"
	Call("Chamber")
EndFunc   ;==>draw_plane

Func draw_plant()
	$file = "draw_plant.txt"
	Call("Chamber")
EndFunc   ;==>draw_plant

Func draw_playboy()
	$file = "draw_playboy.txt"
	Call("Chamber")
EndFunc   ;==>draw_playboy

Func draw_politician()
	$file = "draw_politician.txt"
	Call("Chamber")
EndFunc   ;==>draw_politician

Func draw_pony()
	$file = "draw_pony.txt"
	Call("Chamber")
EndFunc   ;==>draw_pony

Func draw_portal()
	$file = "draw_portal.txt"
	Call("Chamber")
EndFunc   ;==>draw_portal

Func draw_portrait()
	$file = "draw_portrait.txt"
	Call("Chamber")
EndFunc   ;==>draw_portrait

Func draw_pretzel()
	$file = "draw_pretzel.txt"
	Call("Chamber")
EndFunc   ;==>draw_pretzel

Func draw_puma()
	$file = "draw_puma.txt"
	Call("Chamber")
EndFunc   ;==>draw_puma

Func draw_pusheen()
	$file = "draw_pusheen.txt"
	Call("Chamber")
EndFunc   ;==>draw_pusheen

Func draw_pyramid()
	$file = "draw_pyramid.txt"
	Call("Chamber")
EndFunc   ;==>draw_pyramid

Func draw_rage()
	$file = "draw_rage.txt"
	Call("Chamber")
EndFunc   ;==>draw_rage

Func draw_sample()
	$file = "draw_sample.txt"
	Call("Chamber")
EndFunc   ;==>draw_sample

Func draw_samurai()
	$file = "draw_samurai.txt"
	Call("Chamber")
EndFunc   ;==>draw_samurai

Func draw_sandwich()
	$file = "draw_sandwich.txt"
	Call("Chamber")
EndFunc   ;==>draw_sandwich

Func draw_scissors()
	$file = "draw_scissors.txt"
	Call("Chamber")
EndFunc   ;==>draw_scissors

Func draw_siamese()
	$file = "draw_siamese.txt"
	Call("Chamber")
EndFunc   ;==>draw_siamese

Func draw_shark()
	$file = "draw_shark.txt"
	Call("Chamber")
EndFunc   ;==>draw_shark

Func draw_skull()
	$file = "draw_skull.txt"
	Call("Chamber")
EndFunc   ;==>draw_skull

Func draw_slowpoke()
	$file = "draw_slowpoke.txt"
	Call("Chamber")
EndFunc   ;==>draw_slowpoke

Func draw_smiley()
	$file = "draw_smiley.txt"
	Call("Chamber")
EndFunc   ;==>draw_smiley

Func draw_snowflake()
	$file = "draw_snowflake.txt"
	Call("Chamber")
EndFunc   ;==>draw_snowflake

Func draw_soccer()
	$file = "draw_soccer.txt"
	Call("Chamber")
EndFunc   ;==>draw_soccer

Func draw_spider()
	$file = "draw_spider.txt"
	Call("Chamber")
EndFunc   ;==>draw_spider

Func draw_sponge()
	$file = "draw_sponge.txt"
	Call("Chamber")
EndFunc   ;==>draw_sponge

Func draw_square()
	$file = "draw_square.txt"
	Call("Chamber")
EndFunc   ;==>draw_square

Func draw_star()
	$file = "draw_star.txt"
	Call("Chamber")
EndFunc   ;==>draw_star

Func draw_steam()
	$file = "draw_steam.txt"
	Call("Chamber")
EndFunc   ;==>draw_steam

Func draw_suit()
	$file = "draw_suit.txt"
	Call("Chamber")
EndFunc   ;==>draw_suit

Func draw_suitcase()
	$file = "draw_suitcase.txt"
	Call("Chamber")
EndFunc   ;==>draw_suitcase

Func draw_surprised()
	$file = "draw_surprised.txt"
	Call("Chamber")
EndFunc   ;==>draw_surprised

Func draw_sweetface()
	$file = "draw_sweetface.txt"
	Call("Chamber")
EndFunc   ;==>draw_sweetface

Func draw_swordenergy()
	$file = "draw_swordenergy.txt"
	Call("Chamber")
EndFunc   ;==>draw_swordenergy

Func draw_swordmaster()
	$file = "draw_swordmaster.txt"
	Call("Chamber")
EndFunc   ;==>draw_swordmaster

Func draw_target()
	$file = "draw_target.txt"
	Call("Chamber")
EndFunc   ;==>draw_target

Func draw_taylor()
	$file = "draw_taylor.txt"
	Call("Chamber")
EndFunc   ;==>draw_taylor

Func draw_thunderbolt()
	$file = "draw_thunderbolt.txt"
	Call("Chamber")
EndFunc   ;==>draw_thunderbolt

Func draw_toast()
	$file = "draw_toast.txt"
	Call("Chamber")
EndFunc   ;==>draw_toast

Func draw_triangoof()
	$file = "draw_triangoof.txt"
	Call("Chamber")
EndFunc   ;==>draw_triangoof

Func draw_trollface()
	$file = "draw_trollface.txt"
	Call("Chamber")
EndFunc   ;==>draw_trollface

Func draw_uniform()
	$file = "draw_uniform.txt"
	Call("Chamber")
EndFunc   ;==>draw_uniform

Func draw_USA()
	$file = "draw_USA.txt"
	Call("Chamber")
EndFunc   ;==>draw_USA

Func draw_vending()
	$file = "draw_vending.txt"
	Call("Chamber")
EndFunc   ;==>draw_vending

Func draw_wall()
	$file = "draw_wall.txt"
	Call("Chamber")
EndFunc   ;==>draw_wall

Func draw_wheelchair()
	$file = "draw_wheelchair.txt"
	Call("Chamber")
EndFunc   ;==>draw_wheelchair

Func draw_wrench()
	$file = "draw_wrench.txt"
	Call("Chamber")
EndFunc   ;==>draw_wrench

Func draw_woodpile()
	$file = "draw_woodpile.txt"
	Call("Chamber")
EndFunc   ;==>draw_woodpile

Func draw_xbox()
	$file = "draw_xbox.txt"
	Call("Chamber")
EndFunc   ;==>draw_xbox

Func draw_yotsuba()
	$file = "draw_yotsuba.txt"
	Call("Chamber")
EndFunc   ;==>draw_yotsuba

Func write_0()
	$file = "write_0.txt"
	Call("Chamber")
EndFunc   ;==>write_0

Func write_1()
	$file = "write_1.txt"
	Call("Chamber")
EndFunc   ;==>write_1

Func write_2()
	$file = "write_2.txt"
	Call("Chamber")
EndFunc   ;==>write_2

Func write_3()
	$file = "write_3.txt"
	Call("Chamber")
EndFunc   ;==>write_3

Func write_4()
	$file = "write_4.txt"
	Call("Chamber")
EndFunc   ;==>write_4

Func write_5()
	$file = "write_5.txt"
	Call("Chamber")
EndFunc   ;==>write_5

Func write_6()
	$file = "write_6.txt"
	Call("Chamber")
EndFunc   ;==>write_6

Func write_7()
	$file = "write_7.txt"
	Call("Chamber")
EndFunc   ;==>write_7

Func write_8()
	$file = "write_8.txt"
	Call("Chamber")
EndFunc   ;==>write_8

Func write_9()
	$file = "write_9.txt"
	Call("Chamber")
EndFunc   ;==>write_9

Func write_a()
	$file = "write_a.txt"
	Call("Chamber")
EndFunc   ;==>write_a

Func write_apostrophe()
	$file = "write_apostrophe.txt"
	Call("Chamber")
EndFunc   ;==>write_apostrophe

Func write_asterisk()
	$file = "write_asterisk.txt"
	Call("Chamber")
EndFunc   ;==>write_asterisk

Func write_b()
	$file = "write_b.txt"
	Call("Chamber")
EndFunc   ;==>write_b

Func write_bracketLeft()
	$file = "write_bracketLeft.txt"
	Call("Chamber")
EndFunc   ;==>write_bracketLeft

Func write_bracketRight()
	$file = "write_bracketRight.txt"
	Call("Chamber")
EndFunc   ;==>write_bracketRight

Func write_c()
	$file = "write_c.txt"
	Call("Chamber")
EndFunc   ;==>write_c

Func write_caret()
	$file = "write_caret.txt"
	Call("Chamber")
EndFunc   ;==>write_caret

Func write_colon()
	$file = "write_colon.txt"
	Call("Chamber")
EndFunc   ;==>write_colon

Func write_comma()
	$file = "write_comma.txt"
	Call("Chamber")
EndFunc   ;==>write_comma

Func write_d()
	$file = "write_d.txt"
	Call("Chamber")
EndFunc   ;==>write_d

Func write_dollar()
	$file = "write_dollar.txt"
	Call("Chamber")
EndFunc   ;==>write_dollar

Func write_dot()
	$file = "write_dot.txt"
	Call("Chamber")
EndFunc   ;==>write_dot


Func write_e()
	$file = "write_e.txt"
	Call("Chamber")
EndFunc   ;==>write_e

Func write_equal()
	$file = "write_equal.txt"
	Call("Chamber")
EndFunc   ;==>write_equal

Func write_exclamation()
	$file = "write_exclamation.txt"
	Call("Chamber")
EndFunc   ;==>write_exclamation

Func write_f()
	$file = "write_f.txt"
	Call("Chamber")
EndFunc   ;==>write_f

Func write_g()
	$file = "write_g.txt"
	Call("Chamber")
EndFunc   ;==>write_g

Func write_greater()
	$file = "write_greater.txt"
	Call("Chamber")
EndFunc   ;==>write_greater

Func write_h()
	$file = "write_h.txt"
	Call("Chamber")
EndFunc   ;==>write_h

Func write_i()
	$file = "write_i.txt"
	Call("Chamber")
EndFunc   ;==>write_i

Func write_j()
	$file = "write_j.txt"
	Call("Chamber")
EndFunc   ;==>write_j

Func write_k()
	$file = "write_k.txt"
	Call("Chamber")
EndFunc   ;==>write_k

Func write_l()
	$file = "write_l.txt"
	Call("Chamber")
EndFunc   ;==>write_l

Func write_less()
	$file = "write_less.txt"
	Call("Chamber")
EndFunc   ;==>write_less

Func write_m()
	$file = "write_m.txt"
	Call("Chamber")
EndFunc   ;==>write_m

Func write_minus()
	$file = "write_minus.txt"
	Call("Chamber")
EndFunc   ;==>write_minus

Func write_n()
	$file = "write_n.txt"
	Call("Chamber")
EndFunc   ;==>write_n

Func write_o()
	$file = "write_o.txt"
	Call("Chamber")
EndFunc   ;==>write_o

Func write_p()
	$file = "write_p.txt"
	Call("Chamber")
EndFunc   ;==>write_p

Func write_parenthesisLeft()
	$file = "write_parenthesisLeft.txt"
	Call("Chamber")
EndFunc   ;==>write_parenthesisLeft

Func write_parenthesisRight()
	$file = "write_parentehsisRight.txt"
	Call("Chamber")
EndFunc   ;==>write_parenthesisRight

Func write_period()
	$file = "write_period.txt"
	Call("Chamber")
EndFunc   ;==>write_period

Func write_plus()
	$file = "write_plus.txt"
	Call("Chamber")
EndFunc   ;==>write_plus

Func write_pound()
	$file = "write_pound.txt"
	Call("Chamber")
EndFunc   ;==>write_pound

Func write_q()
	$file = "write_q.txt"
	Call("Chamber")
EndFunc   ;==>write_q

Func write_question()
	$file = "question.txt"
	Call("Chamber")
EndFunc   ;==>write_question

Func write_r()
	$file = "write_r.txt"
	Call("Chamber")
EndFunc   ;==>write_r

Func write_s()
	$file = "write_s.txt"
	Call("Chamber")
EndFunc   ;==>write_s

Func write_semicolon()
	$file = "write_dot.txt"
	Call("Chamber")
EndFunc   ;==>write_semicolon

Func write_slashBackward()
	$file = "write_slashBackward.txt"
	Call("Chamber")
EndFunc   ;==>write_slashBackward

Func write_slashForward()
	$file = "write_slashForward.txt"
	Call("Chamber")
EndFunc   ;==>write_slashForward

Func write_space()
	$file = "write_space.txt"
	Call("Chamber")
EndFunc   ;==>write_space

Func write_t()
	$file = "write_t.txt"
	Call("Chamber")
EndFunc   ;==>write_t

Func write_u()
	$file = "write_u.txt"
	Call("Chamber")
EndFunc   ;==>write_u

Func write_underscore()
	$file = "write_underscore.txt"
	Call("Chamber")
EndFunc   ;==>write_underscore

Func write_v()
	$file = "write_v.txt"
	Call("Chamber")
EndFunc   ;==>write_v

Func write_vertical()
	$file = "write_vertical.txt"
	Call("Chamber")
EndFunc   ;==>write_vertical

Func write_w()
	$file = "write_w.txt"
	Call("Chamber")
EndFunc   ;==>write_w

Func write_x()
	$file = "write_x.txt"
	Call("Chamber")
EndFunc   ;==>write_x

Func write_y()
	$file = "write_y.txt"
	Call("Chamber")
EndFunc   ;==>write_y

Func write_z()
	$file = "write_z.txt"
	Call("Chamber")
EndFunc   ;==>write_z
