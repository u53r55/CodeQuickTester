class Paste
{
	__New(Parent)
	{
		this.Parent := Parent
		
		ParentWnd := this.Parent.hMainWindow
		Gui, New, +Owner%ParentWnd% +ToolWindow +hWndhWnd
		this.hWnd := hWnd
		Gui, Margin, 5, 5
		Gui, Font, % this.Parent.Settings.Font, % this.Parent.Settings.TypeFace
		
		Gui, Add, Text, xm ym w30 h22 +0x200, Desc: ; 0x200 for vcenter
		Gui, Add, Edit, x+5 yp w125 h22 hWndhPasteDesc, % this.Parent.Settings.DefaultDesc
		this.hPasteDesc := hPasteDesc
		
		Gui, Add, Button, x+4 yp-1 w52 h24 Default hWndhPasteButton, Paste
		this.hPasteButton := hPasteButton
		BoundPaste := this.Paste.Bind(this)
		GuiControl, +g, %hPasteButton%, %BoundPaste%
		
		Gui, Add, Text, xm y+5 w30 h22 +0x200, Name: ; 0x200 for vcenter
		Gui, Add, Edit, x+5 yp w100 h22 hWndhPasteName, % this.Parent.Settings.DefaultName
		this.hPasteName := hPasteName
		
		Gui, Add, ComboBox, x+5 yp w75 hWndhPasteChan, Announce||#ahk|#ahkscript
		this.hPasteChan := hPasteChan
		
		PostMessage, 0x153, -1, 22-6,, ahk_id %hPasteChan% ; Set height of ComboBox
		Gui, Show,, Paste
		
		WinEvents.Register(this.hWnd, this)
	}
	
	GuiClose()
	{
		GuiControl, -g, % this.hPasteButton
		WinEvents.Unregister(this.hWnd)
		Gui, Destroy
	}
	
	Paste()
	{
		GuiControlGet, PasteDesc,, % this.hPasteDesc
		GuiControlGet, PasteName,, % this.hPasteName
		GuiControlGet, PasteChan,, % this.hPasteChan
		this.GuiClose()
		
		Link := Ahkbin(this.Parent.Code, PasteName, PasteDesc, PasteChan)
		
		MsgBox, 292, %Title%, Link received:`n%Link%`n`nCopy to clipboard?
		IfMsgBox, Yes
			Clipboard := Link
	}
}
