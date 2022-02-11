isSpaceDown := false
isFirstSpaceDown := true

isH := false
isJ := false
isK := false
isL := false

$Space::
    if isFirstSpaceDown
    {
        isSpaceDown := true

        tries := 1
        isAnyHjkl := false
        While (tries < 4)
        {
            if isSpaceDown = false
            {
                break
            }
            if (isH or isJ or isK or isL)
            {
                isAnyHjkl := true
                break
            }
            tries := tries + 1
            Sleep 50
        }

        If isAnyHjkl
        {
            isSpaceDown := true
        }
        else
        {
            Send {Space}
            isFirstSpaceDown := false
            isSpaceDown := false
        }
    }
    else
    {
        Send {Space}
    }
return

$Space Up::
    isSpaceDown := false
    isFirstSpaceDown := true
return






$h::
    isH := true
    if isSpaceDown
        Send {Left}
    else
        Send {h}
return
$h Up::
    isH := false
return

$j::
    isJ := true
    if isSpaceDown
        Send {Down}
    else
        Send {j}
return
$j Up::
    isJ := false
return

$k::
    isK := true
    if isSpaceDown
        Send {Up}
    else
        Send {k}
return
$k Up::
    isK := false
return

$l::
    isL := true
    if isSpaceDown
        Send {Right}
    else
        Send {l}
return
$l Up::
    isL := false
return
