isShift := false
isLeftAlt := false
isFirstTab := true

;$ - ļauj pārķert taustiņu un pēc tam turpināt tos pašu taustiņu vai arī cancelot
;~ - ļauj pārkērt taustiņu bet nepārtrauc to

;---Disable left alt, bet pieglabājam mainīgajā ir nospiests vai nav
Alt::
    isLeftAlt := true
return
Alt Up::
    isLeftAlt := false
    isFirstTab := true
return


~Shift::
    isShift := true
return
~Shift Up::
    isShift := false
return

;Shift modifier tāpēc, ja ir nospiests kopā ar kādu citu taustiņu, tad tas otrs taustiņš nesaņe eventu
;nospiežot Shift Alt vienkārši Alt nenostrādā. Tāpēc šeit ieslēdzam gan shift, gan alt
+Alt::
    isShift := true
    isLeftAlt := true
return
+Alt Up::
    isShift := false
    isLeftAlt := false
return



;Shift Left, Shift ir HotKey. Shift kopā ar Left - Left nesaņem savu eventu
$+Left::
    if isLeftAlt
        Send {Shift down}{Home}
    else
        Send {Shift down}{Left}
return
$+Right::
    if isLeftAlt
        Send {Shift down}{End}
    else
        Send {Shift down}{Right}
return
$+Up::
    if isLeftAlt
        Send {Shift down}{Ctrl down}{Home}{Shift up}{Ctrl up}
    else
        Send {Shift down}{Up}
return
$+Down::
    if isLeftAlt
        Send {Shift down}{Ctrl down}{End}{Shift up}{Ctrl up}
    else
        Send {Shift down}{Down}
return

;Vienkārši Left, Right. Te pārbaudām vai ir Alt nospiests
$Left::
    if isLeftAlt
        Send {Home}
    else
        Send {Left}
return
$Right::
    if isLeftAlt
        Send {End}
    else
        Send {Right}
return
$Up::
    if isLeftAlt
        Send {Ctrl down}{Home}{Ctrl up}
    else
        Send {Up}
return
$Down::
    if isLeftAlt
        Send {Ctrl down}{End}{Ctrl Up}
    else
        Send {Down}
return

;Shift Control Left. Gan Shift, gan Control ir hotkeys, tāpēc atsevišķi šāds gadījums jāapstrādā
$+^Left::
    if isShift or GetKeyState("Shift")
        Send {Shift down}{Ctrl down}{Left}
    else
        Send {Ctrl down}{Left}
return
$+^Left Up::
    Send {Shift up}{Ctrl up}
return
$+^Right::
    if isShift or GetKeyState("Shift")
        Send {Shift down}{Ctrl down}{Right}
    else
        Send {Ctrl down}{Right}
return
$+^Right Up::
    Send {Shift up}{Ctrl up}
return


;Enable Right Alt, because Left alt is disabled
;LControl & RAlt::Send {Alt}
;Remap right alt to left alt form Alt-tab
LControl & RAlt::Alt


;CapsLock to Ctrl
CapsLock::Ctrl



;Alt-w acts like Ctrl-w
$w::
    if isLeftAlt
        Send {Ctrl down}{w}{Ctrl up}
    else
        Send {w}
return
;Alt-s acts like Ctrl-s
$s::
    if isLeftAlt
        Send {Ctrl down}{s}{Ctrl up}
    else
        Send {s}
return
;Alt-c acts like Ctrl-c
$c::
    if isLeftAlt
        Send {Ctrl down}{c}{Ctrl up}
    else
        Send {c}
return
;Alt-v acts like Ctrl-v
$v::
    if isLeftAlt
        Send {Ctrl down}{v}{Ctrl up}
    else
        Send {v}
return
;Alt-z acts like Ctrl-z
$z::
    if isLeftAlt
        Send {Ctrl down}{z}{Ctrl up}
    else
        Send {z}
return
;Alt-x acts like Ctrl-x
$x::
    if isLeftAlt
        Send {Ctrl down}{x}{Ctrl up}
    else
        Send {x}
return
;Alt-r acts like Ctrl-r
$r::
    if isLeftAlt
        Send {Ctrl down}{r}{Ctrl up}
    else
        Send {r}
return
;Alt-f acts like Ctrl-f
$f::
    if isLeftAlt
        Send {Ctrl down}{f}{Ctrl up}
    else
        Send {f}
return
;Alt-t acts like Ctrl-t
$t::
    if isLeftAlt
        Send {Ctrl down}{t}{Ctrl up}
    else
        Send {t}
return

winId := 0
winIndex := 1

$Tab::
    if isLeftAlt
    {
        if isFirstTab
        {
            winIndex := 0
            ;Pirmajā tab nolasām visus aktīvos logus
            WinGet, winId, List,,, Program Manager
        }

        isFirstTab := false


        loop 30
        {
            this_id := winId%winIndex%
            winIndex := winIndex + 1

            WinGetTitle, this_title, ahk_id %this_id%
            WinGetClass, this_class, ahk_id %this_id%


            if StrLen(this_title) = 0
                continue

            if WinActive("ahk_id" this_id)
                continue

            ;windows file explorer
            if (this_class = "CabinetWClass")
            {
                continue
            }

            if InStr(this_title, "WinSCP") > 0
                continue

            if InStr(this_title, "Screen Ruler") > 0
                continue


            break
        }

        WinActivate, ahk_id %this_id%




        ;WinGet, id, List,,, Program Manager
        ;Loop, %id%
        ;{
            ;this_id := id%A_Index%
            ;WinActivate, ahk_id %this_id%
            ;WinGetClass, this_class, ahk_id %this_id%
            ;WinGetTitle, this_title, ahk_id %this_id%
            ;MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
            ;IfMsgBox, NO, break
        ;}

    }
    else
    {
        Send {Tab}
    }
return


;---Alt aizmet līdz galam pa labi vai kreisi
;!Right::Send {End}
;!Left::Send {Home}

;---Shift Alt iezīmē visu pa labi vai kreisi
;+!Left::Send {Shift down}{Home}
;+!Right::Send {Shift down}{End}

;---Left Alt disable
;Alt::return
