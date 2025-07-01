function SetTheme()
    if $TERM =~ "linux"
        colorscheme default
    else
        colorscheme nightfox
    endif
endfunction

call SetTheme()
