" Name:         forbit
" Description:  Designed to be used with 4-bit terminal colors and a dark background. Tries to save emphasis like red, bold, and non-default background colors for when it really matters.
" Author:       Jordan Torbiak <torbiak@gmail.com>
" Maintainer:   Jordan Torbiak <torbiak@gmail.com>
" Website:      https://torbiak.com
" License:      Public domain
" Last Updated: Tue 06 Feb 2024 03:46:21 PM MST

set background=dark
hi clear
let g:colors_name = 'forbit'

hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment ctermfg=lightblue ctermbg=NONE cterm=NONE
hi Constant ctermfg=darkmagenta ctermbg=NONE cterm=NONE
hi Identifier ctermfg=darkcyan ctermbg=NONE cterm=NONE
hi Function ctermfg=lightcyan ctermbg=NONE cterm=NONE
hi Statement ctermfg=darkyellow ctermbg=NONE cterm=NONE
hi PreProc ctermfg=lightyellow ctermbg=NONE cterm=NONE
hi PreCondit ctermfg=lightred ctermbg=NONE cterm=NONE
hi Type ctermfg=darkgreen ctermbg=NONE cterm=NONE
hi Special ctermfg=lightblue ctermbg=NONE cterm=NONE
hi Underlined ctermfg=lightblue ctermbg=NONE cterm=underline
hi Ignore ctermfg=black ctermbg=black cterm=NONE
hi Error ctermfg=black ctermbg=lightred cterm=NONE
hi Todo ctermfg=black ctermbg=darkyellow cterm=NONE
hi Conceal ctermfg=lightgrey ctermbg=lightgrey cterm=NONE
hi Cursor ctermfg=black ctermbg=white cterm=NONE
hi lCursor ctermfg=black ctermbg=white cterm=NONE
hi CursorIM ctermfg=NONE ctermbg=NONE cterm=NONE
hi Title ctermfg=darkmagenta ctermbg=NONE cterm=NONE
hi Directory ctermfg=darkgreen ctermbg=NONE cterm=NONE
hi Search ctermfg=black ctermbg=darkgreen cterm=NONE
hi IncSearch ctermfg=black ctermbg=lightyellow cterm=bold
hi NonText ctermfg=lightblue ctermbg=NONE cterm=bold
hi EndOfBuffer ctermfg=lightblue ctermbg=NONE cterm=NONE
hi ErrorMsg ctermfg=white ctermbg=darkred cterm=NONE
hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
hi SignColumn ctermfg=lightcyan ctermbg=black cterm=NONE
hi ColorColumn ctermfg=white ctermbg=darkgrey cterm=NONE
hi FoldColumn ctermfg=NONE ctermbg=black cterm=NONE
hi Folded ctermfg=lightblue ctermbg=NONE cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=underline
hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
hi CursorLineNr ctermfg=darkyellow ctermbg=NONE cterm=underline
hi Visual ctermfg=black ctermbg=darkcyan cterm=NONE
hi VisualNOS ctermfg=NONE ctermbg=black cterm=underline
hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi MatchParen ctermfg=white ctermbg=darkgrey cterm=NONE
hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
hi MoreMsg ctermfg=lightblue ctermbg=NONE cterm=bold
hi Question ctermfg=lightgreen ctermbg=NONE cterm=bold
hi SpecialKey ctermfg=darkblue ctermbg=NONE cterm=NONE
hi WildMenu ctermfg=black ctermbg=darkyellow cterm=NONE
hi QuickFixLine ctermfg=black ctermbg=darkcyan cterm=NONE
hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
hi SpellCap ctermfg=darkblue ctermbg=NONE cterm=underline
hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
hi SpellRare ctermfg=darkyellow ctermbg=NONE cterm=underline
hi StatusLine ctermfg=NONE ctermbg=darkblue cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=white cterm=NONE
hi StatusLineTerm ctermfg=lightgreen ctermbg=darkgrey cterm=bold
hi StatusLineTermNC ctermfg=darkgreen ctermbg=darkgrey cterm=NONE
hi VertSplit ctermfg=black ctermbg=white cterm=NONE
hi TabLine ctermfg=white ctermbg=darkgrey cterm=NONE
hi TabLineFill ctermfg=NONE ctermbg=black cterm=reverse
hi TabLineSel ctermfg=white ctermbg=black cterm=bold
hi ToolbarLine ctermfg=NONE ctermbg=black cterm=NONE
hi ToolbarButton ctermfg=black ctermbg=lightgrey cterm=bold
hi Pmenu ctermfg=NONE ctermbg=darkgrey cterm=NONE
hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel ctermfg=black ctermbg=lightgrey cterm=NONE
hi PmenuThumb ctermfg=NONE ctermbg=white cterm=NONE
hi DiffAdd ctermfg=DarkGreen ctermbg=Black cterm=NONE
hi DiffChange ctermfg=DarkYellow ctermbg=Black cterm=NONE
hi DiffDelete ctermfg=DarkRed ctermbg=Black cterm=NONE
hi DiffText ctermfg=Black ctermbg=DarkYellow cterm=bold
