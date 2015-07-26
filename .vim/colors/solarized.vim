if !exists("g:solarized_termtrans")
    let w:solarized_termtrans = 0
  else
    let w:solarized_termtrans = 1
endif
if !exists("g:solarized_degrade")
  let g:solarized_degrade = 0
endif
if !exists("g:solarized_bold")
  let w:solarized_bold = 1
endif
if !exists("g:solarized_underline")
    let w:solarized_underline = 1
else
    let w:solarized_underline = g:solarized_underline
endif
if !exists("g:solarized_italic")
    let w:solarized_italic = 1
else
    let w:solarized_italic = g:solarized_italic
endif
if !exists("g:solarized_termcolors")
    let w:solarized_termcolors = 256
else
    let w:solarized_termcolors = g:solarized_termcolors
endif
if !exists("w:solarized_style") && !exists("g:solarized_style")
    let w:solarized_style = &background
elseif exists("g:solarized_style")
    let w:solarized_style = g:solarized_style
" else we have an existing w:solarized_style
endif
if !exists("g:solarized_contrast")
    let w:solarized_contrast = "normal"
else
    let w:solarized_contrast = g:solarized_contrast
endif
"}}}
" Colorscheme basic settings"{{{
" ---------------------------------------------------------------------

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "solarized"
" GUI & CSApprox hexadecimal palettes"{{{
" ---------------------------------------------------------------------
"
" Set both gui and terminal color values in separate conditional statements
" Due to possibility that CSApprox is running (though I suppose we could just
" leave the hex values out entirely in that case and include only cterm colors)
" We also check to see if user has set solarized (force use of the
" neutral gray monotone palette component)
if has("gui_running") && w:solarized_degrade == 0
    let s:g_back        = "#002b36"
    let s:g_base03      = "#002b36"
    let s:g_base02      = "#073642"
    let s:g_base01      = "#586e75"
    let s:g_base00      = "#657b83"
    let s:g_base0       = "#839496"
    let s:g_base1       = "#93a1a1"
    let s:g_base2       = "#eee8d5"
    let s:g_base3       = "#fdf6e3"
    let s:g_yellow      = "#b58900"
    let s:g_orange      = "#cb4b16"
    let s:g_red         = "#d30102"
    let s:g_magenta     = "#d33682"
    let s:g_violet      = "#6c71c4"
    let s:g_blue        = "#268bd2"
    let s:g_cyan        = "#2aa198"
    let s:g_green       = "#859900"
else
    " these colors are for non-gui vim when CSApprox is installed. CSApprox
    " degrades the base colors poorly (bright blues instead of muted gray
    " blues) so we set all hex values here to ones which CSApprox will not
    " change and which we approve of. Perhaps I should just can the hex values
    " and use just the color table values, leaving these blank. Not much
    " difference either way and I'd rather be thorough about it.
    " They can also be used by setting g:solarized_degrade to 1 in vimrc
    let s:g_back        = "#121212"
    let s:g_base03      = "#121212"
    let s:g_base02      = "#1c1c1c"
    let s:g_base01      = "#4e4e4e"
    let s:g_base00      = "#585858"
    let s:g_base0       = "#808080"
    let s:g_base1       = "#8a8a8a"
    let s:g_base2       = "#e4e4e4"
    let s:g_base3       = "#ffffd7"
    let s:g_yellow      = "#af8700"
    let s:g_orange      = "#d75f00"
    let s:g_red         = "#af0000"
    let s:g_magenta     = "#af005f"
    let s:g_violet      = "#5f5faf"
    let s:g_blue        = "#0087ff"
    let s:g_cyan        = "#00afaf"
    let s:g_green       = "#5f8700"
endif
"}}}
" 256 Terminal (no CSApprox) and 16 color fallback palettes"{{{
" ---------------------------------------------------------------------
" We also set this if gui is running as we use the optional formatting
" values that get set here (ou==optional underline, ob==opt bold).
if (has("gui_running") || &t_Co == 256) && w:solarized_termcolors != 16
    let s:c_back        = "233"
    let s:c_base03      = "233"
    let s:c_base02      = "234"
    let s:c_base01      = "239"
    let s:c_base00      = "240"
    let s:c_base0       = "244"
    let s:c_base1       = "245"
    let s:c_base2       = "254"
    let s:c_base3       = "230"
    let s:c_yellow      = "136"
    let s:c_orange      = "166"
    let s:c_red         = "124"
    let s:c_magenta     = "125"
    let s:c_violet      = "61"
    let s:c_blue        = "33"
    let s:c_cyan        = "37"
    let s:c_green       = "64"
    let s:ou            = ""
    let s:ob            = ""
  elseif &t_Co > 8 || w:solarized_termcolors == 16
    " NOTE: this requires terminal colors to be set to solarized standard
    " 16 colors (see top of this file for details)
    let s:c_back        = "NONE"
    let s:c_base03      = "8"
    let s:c_base02      = "0"
    let s:c_base01      = "10"
    let s:c_base00      = "11"
    let s:c_base0       = "12"
    let s:c_base1       = "14"
    let s:c_base2       = "7"
    let s:c_base3       = "15"
    let s:c_green       = "2"
    let s:c_yellow      = "3"
    let s:c_orange      = "9"
    let s:c_red         = "1"
    let s:c_magenta     = "5"
    let s:c_violet      = "13"
    let s:c_blue        = "4"
    let s:c_cyan        = "6"
    let s:ou            = ""
    let s:ob            = ""
else " must be in an 8 color or less terminal
    let s:c_back        = "NONE"
    let s:c_base03      = "4"
    let s:c_base02      = "darkgrey"
    let s:c_base01      = "grey"
    let s:c_base00      = "darkgrey"
    let s:c_base0       = "6"
    let s:c_base1       = "4"
    let s:c_base2       = "7"
    let s:c_base3       = "7"
    let s:c_green       = "2"
    let s:c_yellow      = "3"
    let s:c_orange      = "3"
    let s:c_red         = "1"
    let s:c_magenta     = "5"
    let s:c_violet      = "5"
    let s:c_blue        = "4"
    let s:c_cyan        = "6"
    let s:ou            = ",underline"
    let s:ob            = ",bold"
endif
"}}}
" Formatting options and null values for passthrough effect"{{{
" ---------------------------------------------------------------------
let s:g_none            = "NONE"
let s:c_none            = "NONE"
let s:t_none            = "NONE"
let s:n                 = "NONE"
let s:c                 = ",undercurl"
let s:r                 = ",reverse"
let s:s                 = ",standout"
if w:solarized_contrast == "high"
    let s:g_base03      = s:g_base03
    let s:g_base02      = s:g_base02
    let s:g_base01      = s:g_base00
    let s:g_base00      = s:g_base0
    let s:g_base0       = s:g_base1
    let s:g_base1       = s:g_base2
    let s:g_base2       = s:g_base3
    let s:g_base3       = s:g_base3
    let s:g_back        = s:g_back
endif
if w:solarized_contrast == "low"
    let s:g_back        = s:g_base02
endif
"}}}
" Overrides dependent on user specified values"{{{
" ---------------------------------------------------------------------
if w:solarized_termtrans == 1
    let s:c_back        = "NONE"
endif

if w:solarized_bold == 1
    let s:b             = ",bold"
else
    let s:b             = ""
endif

if w:solarized_underline == 1
    let s:u             = ",underline"
else
    let s:u             = ""
endif

if w:solarized_italic == 1
    let s:i             = ",italic"
else
    let s:i             = ""
endif
"}}}
" Highlighting primitives"{{{
" ---------------------------------------------------------------------

exe "let s:bg_none      = ' ctermbg=".s:c_none   ." guibg=".s:g_none   ."'"
exe "let s:bg_back      = ' ctermbg=".s:c_back   ." guibg=".s:g_back   ."'"
exe "let s:bg_base03    = ' ctermbg=".s:c_base03 ." guibg=".s:g_base03 ."'"
exe "let s:bg_base02    = ' ctermbg=".s:c_base02 ." guibg=".s:g_base02 ."'"
exe "let s:bg_base01    = ' ctermbg=".s:c_base01 ." guibg=".s:g_base01 ."'"
exe "let s:bg_base00    = ' ctermbg=".s:c_base00 ." guibg=".s:g_base00 ."'"
exe "let s:bg_base0     = ' ctermbg=".s:c_base0  ." guibg=".s:g_base0  ."'"
exe "let s:bg_base1     = ' ctermbg=".s:c_base1  ." guibg=".s:g_base1  ."'"
exe "let s:bg_base2     = ' ctermbg=".s:c_base2  ." guibg=".s:g_base2  ."'"
exe "let s:bg_base3     = ' ctermbg=".s:c_base3  ." guibg=".s:g_base3  ."'"
exe "let s:bg_green     = ' ctermbg=".s:c_green  ." guibg=".s:g_green  ."'"
exe "let s:bg_yellow    = ' ctermbg=".s:c_yellow ." guibg=".s:g_yellow ."'"
exe "let s:bg_orange    = ' ctermbg=".s:c_orange ." guibg=".s:g_orange ."'"
exe "let s:bg_red       = ' ctermbg=".s:c_red    ." guibg=".s:g_red    ."'"
exe "let s:bg_magenta   = ' ctermbg=".s:c_magenta." guibg=".s:g_magenta."'"
exe "let s:bg_violet    = ' ctermbg=".s:c_violet ." guibg=".s:g_violet ."'"
exe "let s:bg_blue      = ' ctermbg=".s:c_blue   ." guibg=".s:g_blue   ."'"
exe "let s:bg_cyan      = ' ctermbg=".s:c_cyan   ." guibg=".s:g_cyan   ."'"

exe "let s:fg_none      = ' ctermfg=".s:c_none   ." guifg=".s:g_none   ."'"
exe "let s:fg_back      = ' ctermfg=".s:c_back   ." guifg=".s:g_back   ."'"
exe "let s:fg_base03    = ' ctermfg=".s:c_base03 ." guifg=".s:g_base03 ."'"
exe "let s:fg_base02    = ' ctermfg=".s:c_base02 ." guifg=".s:g_base02 ."'"
exe "let s:fg_base01    = ' ctermfg=".s:c_base01 ." guifg=".s:g_base01 ."'"
exe "let s:fg_base00    = ' ctermfg=".s:c_base00 ." guifg=".s:g_base00 ."'"
exe "let s:fg_base0     = ' ctermfg=".s:c_base0  ." guifg=".s:g_base0  ."'"
exe "let s:fg_base1     = ' ctermfg=".s:c_base1  ." guifg=".s:g_base1  ."'"
exe "let s:fg_base2     = ' ctermfg=".s:c_base2  ." guifg=".s:g_base2  ."'"
exe "let s:fg_base3     = ' ctermfg=".s:c_base3  ." guifg=".s:g_base3  ."'"
exe "let s:fg_green     = ' ctermfg=".s:c_green  ." guifg=".s:g_green  ."'"
exe "let s:fg_yellow    = ' ctermfg=".s:c_yellow ." guifg=".s:g_yellow ."'"
exe "let s:fg_orange    = ' ctermfg=".s:c_orange ." guifg=".s:g_orange ."'"
exe "let s:fg_red       = ' ctermfg=".s:c_red    ." guifg=".s:g_red    ."'"
exe "let s:fg_magenta   = ' ctermfg=".s:c_magenta." guifg=".s:g_magenta."'"
exe "let s:fg_violet    = ' ctermfg=".s:c_violet ." guifg=".s:g_violet ."'"
exe "let s:fg_blue      = ' ctermfg=".s:c_blue   ." guifg=".s:g_blue   ."'"
exe "let s:fg_cyan      = ' ctermfg=".s:c_cyan   ." guifg=".s:g_cyan   ."'"

exe "let s:sp_none      = ' guisp=".s:g_none   ."'"
exe "let s:sp_back      = ' guisp=".s:g_back   ."'"
exe "let s:sp_base03    = ' guisp=".s:g_base03 ."'"
exe "let s:sp_base02    = ' guisp=".s:g_base02 ."'"
exe "let s:sp_base01    = ' guisp=".s:g_base01 ."'"
exe "let s:sp_base00    = ' guisp=".s:g_base00 ."'"
exe "let s:sp_base0     = ' guisp=".s:g_base0  ."'"
exe "let s:sp_base1     = ' guisp=".s:g_base1  ."'"
exe "let s:sp_base2     = ' guisp=".s:g_base2  ."'"
exe "let s:sp_base3     = ' guisp=".s:g_base3  ."'"
exe "let s:sp_green     = ' guisp=".s:g_green  ."'"
exe "let s:sp_yellow    = ' guisp=".s:g_yellow ."'"
exe "let s:sp_orange    = ' guisp=".s:g_orange ."'"
exe "let s:sp_red       = ' guisp=".s:g_red    ."'"
exe "let s:sp_magenta   = ' guisp=".s:g_magenta."'"
exe "let s:sp_violet    = ' guisp=".s:g_violet ."'"
exe "let s:sp_blue      = ' guisp=".s:g_blue   ."'"
exe "let s:sp_cyan      = ' guisp=".s:g_cyan   ."'"

exe "let s:fmt_none     = ' cterm=NONE".    " gui=NONE".    " term=NONE".    "'"
exe "let s:fmt_bold     = ' cterm=NONE".s:b." gui=NONE".s:b." term=NONE".s:b."'"
exe "let s:fmt_bldi     = ' cterm=NONE".s:b.s:i." gui=NONE".s:b.s:i." term=NONE".s:b.s:i."'"
exe "let s:fmt_undr     = ' cterm=NONE".s:u." gui=NONE".s:u." term=NONE".s:u."'"
exe "let s:fmt_undb     = ' cterm=NONE".s:u.s:b." gui=NONE".s:u.s:b.
            \" term=NONE".s:u.s:b."'"
exe "let s:fmt_undi     = ' cterm=NONE".s:u.s:i." gui=NONE".s:u.s:i.
            \" term=NONE".s:u.s:i."'"
exe "let s:fmt_uopt     = ' cterm=NONE".s:ou." gui=NONE".s:ou.
            \" term=NONE".s:ou."'"
exe "let s:fmt_bopt     = ' cterm=NONE".s:ob." gui=NONE".s:ob.
            \" term=NONE".s:ob."'"
exe "let s:fmt_curl     = ' cterm=NONE".s:c." gui=NONE".s:c." term=NONE".s:c."'"
exe "let s:fmt_ital     = ' cterm=NONE".s:i." gui=NONE".s:i." term=NONE".s:i."'"
exe "let s:fmt_revr     = ' cterm=NONE".s:r." gui=NONE".s:r." term=NONE".s:r."'"
exe "let s:fmt_stnd     = ' cterm=NONE".s:s." gui=NONE".s:s." term=NONE".s:s."'"
"}}}
" Basic highlighting"{{{
" ---------------------------------------------------------------------
" note that link syntax to avoid duplicate configuration doesn't work with the
" exe compiled formats

exe "hi Normal"         . s:fg_base0  .s:bg_back   .s:fmt_none

exe "hi Constant"       . s:fg_cyan   .s:bg_none   .s:fmt_none
"      *Constant        any constant
"       String          a string constant: "this is a string"
"       Character       a character constant: 'c', '\n'
"       Number          a number constant: 234, 0xff
"       Boolean         a boolean constant: TRUE, false
"       Float           a floating point constant: 2.3e10

exe "hi Identifier"     . s:fg_blue   .s:bg_none   .s:fmt_none
"      *Identifier      any variable name
"       Function        function name (also: methods for classes)
"
exe "hi Statement"      . s:fg_green  .s:bg_none   .s:fmt_none
"      *Statement       any statement
"       Conditional     if, then, else, endif, switch, etc.
"       Repeat          for, do, while, etc.
"       Label           case, default, etc.
"       Operator        "sizeof", "+", "*", etc.
"       Keyword         any other keyword
"       Exception       try, catch, throw

exe "hi PreProc"        . s:fg_orange .s:bg_none   .s:fmt_none
"      *PreProc         generic Preprocessor
"       Include         preprocessor #include
"       Define          preprocessor #define
"       Macro           same as Define
"       PreCondit       preprocessor #if, #else, #endif, etc.

exe "hi Type"           . s:fg_yellow .s:bg_none   .s:fmt_none
"      *Type            int, long, char, etc.
"       StorageClass    static, register, volatile, etc.
"       Structure       struct, union, enum, etc.
"       Typedef         A typedef

" *Special              any special symbol
exe "hi Special"        . s:fg_red    .s:bg_none   .s:fmt_none
"        SpecialChar    special character in a constant
"        Tag            you can use CTRL-] on this
"        Delimiter      character that needs attention
"        SpecialComment special things inside a comment
"        Debug          debugging statements

exe "hi Underlined"     . s:fg_violet .s:bg_none   .s:fmt_none
"      *Underlined      text that stands out, HTML links

exe "hi Ignore"         . s:fg_none   .s:bg_none   .s:fmt_none
"      *Ignore          left blank, hidden  |hl-Ignore|

exe "hi Error"          . s:fg_red    .s:bg_none   .s:fmt_bold
"      *Error           any erroneous construct

exe "hi Todo"           . s:fg_magenta.s:bg_none   .s:fmt_bold
"      *Todo            anything that needs extra attention; mostly the
"                       keywords TODO FIXME and XXX
"
" "Highlighting groups for various occasions
" "-----------------------------------------
exe "hi SpecialKey"     . s:fg_base02 .s:bg_none   .s:fmt_none
exe "hi NonText"        . s:fg_base02 .s:bg_none   .s:fmt_bold
exe "hi Directory"      . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi ErrorMsg"       . s:fg_red    .s:bg_none   .s:fmt_revr
exe "hi IncSearch"      . s:fg_yellow .s:bg_none   .s:fmt_revr
exe "hi Search"         . s:fg_yellow .s:bg_none   .s:fmt_stnd
exe "hi MoreMsg"        . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi ModeMsg"        . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi LineNr"         . s:fg_base01 .s:bg_base02 .s:fmt_none
exe "hi Question"       . s:fg_cyan   .s:bg_none   .s:fmt_bold
exe "hi StatusLine"     . s:fg_base0  .s:bg_base02 .s:fmt_none
exe "hi StatusLineNC"   . s:fg_base1  .s:bg_base02 .s:fmt_none
exe "hi VertSplit"      . s:fg_base0  .s:bg_base02 .s:fmt_none
exe "hi Title"          . s:fg_orange .s:bg_none   .s:fmt_bold
exe "hi Visual"         . s:fg_base01 .s:bg_base02 .s:fmt_stnd
exe "hi VisualNOS"      . s:fg_base01 .s:bg_base02 .s:fmt_stnd
exe "hi WarningMsg"     . s:fg_red    .s:bg_none   .s:fmt_bold
exe "hi WildMenu"       . s:fg_base1  .s:bg_base02 .s:fmt_none
exe "hi Folded"         . s:fg_base0  .s:bg_base02 .s:fmt_undr   .s:sp_base03
exe "hi FoldColumn"     . s:fg_base0  .s:bg_base02 .s:fmt_bold
exe "hi DiffAdd"        . s:fg_green  .s:bg_none   .s:fmt_revr
exe "hi DiffChange"     . s:fg_yellow .s:bg_none   .s:fmt_revr
exe "hi DiffDelete"     . s:fg_red    .s:bg_none   .s:fmt_revr
exe "hi DiffText"       . s:fg_blue   .s:bg_none   .s:fmt_revr
exe "hi SignColumn"     . s:fg_base0  .s:bg_base02 .s:fmt_none
exe "hi Conceal"        . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi SpellBad"       . s:fg_none   .s:bg_none   .s:fmt_curl   .s:sp_red
exe "hi SpellCap"       . s:fg_none   .s:bg_none   .s:fmt_curl   .s:sp_violet
exe "hi SpellRare"      . s:fg_none   .s:bg_none   .s:fmt_curl   .s:sp_cyan
exe "hi SpellLocal"     . s:fg_none   .s:bg_none   .s:fmt_curl   .s:sp_yellow
exe "hi Pmenu"          . s:fg_base0  .s:bg_base02 .s:fmt_none
exe "hi PmenuSel"       . s:fg_base2  .s:bg_base01 .s:fmt_none
exe "hi PmenuSbar"      . s:fg_base0  .s:bg_base2  .s:fmt_none
exe "hi PmenuThumb"     . s:fg_base03 .s:bg_base0  .s:fmt_none
exe "hi TabLine"        . s:fg_base0  .s:bg_base02 .s:fmt_undr   .s:sp_base0
exe "hi TabLineSel"     . s:fg_base2  .s:bg_base01 .s:fmt_undr   .s:sp_base0
exe "hi TabLineFill"    . s:fg_base0  .s:bg_base02 .s:fmt_undr   .s:sp_base0
exe "hi CursorColumn"   . s:fg_none   .s:bg_base02 .s:fmt_none
exe "hi CursorLine"     . s:fg_none   .s:bg_base02 .s:fmt_uopt
exe "hi ColorColumn"    . s:fg_none   .s:bg_base02 .s:fmt_none
exe "hi Cursor"         . s:fg_none   .s:bg_none   .s:fmt_revr
exe "hi lCursor"        . s:fg_none   .s:bg_none   .s:fmt_stnd
exe "hi MatchParen"     . s:fg_red    .s:bg_base01 .s:fmt_bold
"}}}
" Extended highlighting "{{{
" ---------------------------------------------------------------------
"}}}
" vim syntax highlighting "{{{
" ---------------------------------------------------------------------
exe "hi vimCommentString".s:fg_violet .s:bg_none   .s:fmt_none
hi link vimVar Identifier
hi link vimFunc Function
hi link vimUserFunc Function
exe "hi vimCommand"     . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi vimCmdSep"      . s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi helpExample"    . s:fg_base1  .s:bg_none   .s:fmt_none
hi link helpSpecial Special
"exe "hi helpSpecial"    . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi helpOption"     . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi helpNote"       . s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi helpVim"       . s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi helpHyperTextJump".s:fg_blue  .s:bg_none   .s:fmt_undr
exe "hi helpHyperTextEntry".s:fg_green .s:bg_none   .s:fmt_none
exe "hi vimIsCommand"   . s:fg_base00 .s:bg_none   .s:fmt_none
exe "hi vimSynMtchOpt". s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi vimSynType"     . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi vimHiLink"      . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi vimHiGroup"     . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi vimGroup"       . s:fg_blue   .s:bg_none   .s:fmt_undb
"}}}
" html highlighting "{{{
" ---------------------------------------------------------------------
exe "hi htmlTag"        . s:fg_base01 .s:bg_none   .s:fmt_none
exe "hi htmlEndTag"     . s:fg_base01 .s:bg_none   .s:fmt_none
exe "hi htmlTagN"       . s:fg_base1  .s:bg_none   .s:fmt_bold
exe "hi htmlTagName"    . s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi htmlSpecialTagName". s:fg_blue  .s:bg_none .s:fmt_ital
exe "hi htmlArg"        . s:fg_base00 .s:bg_none   .s:fmt_none
exe "hi javaScript"     . s:fg_yellow .s:bg_none   .s:fmt_none
"}}}
" perl highlighting "{{{
" ---------------------------------------------------------------------
exe "hi perlHereDoc"    . s:fg_base1  .s:bg_back   .s:fmt_none
exe "hi perlVarPlain" . s:fg_yellow .s:bg_back   .s:fmt_none
exe "hi perlStatementFileDesc"    . s:fg_cyan   .s:bg_back   .s:fmt_none

"}}}
" tex highlighting "{{{
" ---------------------------------------------------------------------
exe "hi texStatement"   . s:fg_cyan   .s:bg_back   .s:fmt_none
exe "hi texMathZoneX"   . s:fg_yellow .s:bg_back   .s:fmt_none
exe "hi texMathMatcher" . s:fg_yellow .s:bg_back   .s:fmt_none
exe "hi texMathMatcher" . s:fg_yellow .s:bg_back   .s:fmt_none
exe "hi texRefLabel"    . s:fg_yellow .s:bg_back   .s:fmt_none
"}}}
" ruby highlighting "{{{
" ---------------------------------------------------------------------
exe "hi rubyDefine"     . s:fg_base1  .s:bg_back   .s:fmt_bold
"rubyInclude
"rubySharpBang
"rubyAccess
"rubyPredefinedVariable
"rubyBoolean
"rubyClassVariable
"rubyBeginEnd
"rubyRepeatModifier
"hi link rubyArrayDelimiter    Special  " [ , , ]
"rubyCurlyBlock  { , , }

"hi link rubyClass             Keyword
"hi link rubyModule            Keyword
"hi link rubyKeyword           Keyword
"hi link rubyOperator          Operator
"hi link rubyIdentifier        Identifier
"hi link rubyInstanceVariable  Identifier
"hi link rubyGlobalVariable    Identifier
"hi link rubyClassVariable     Identifier
"hi link rubyConstant          Type
"}}}
" haskell syntax highlighting"{{{
" ---------------------------------------------------------------------
" For use with syntax/haskell.vim : Haskell Syntax File
" http://www.vim.org/scripts/script.php?script_id=3034
" See also Steffen Siering's github repository:
" http://github.com/urso/dotrc/blob/master/vim/syntax/haskell.vim
" ---------------------------------------------------------------------
"
" Treat True and False specially, see the plugin referenced above
let hs_highlight_boolean=1
" highlight delims, see the plugin referenced above
let hs_highlight_delimiters=1

exe "hi cPreCondit". s:fg_orange.s:bg_none   .s:fmt_none

exe "hi VarId"    . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi ConId"    . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi hsImport" . s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi hsString" . s:fg_base00 .s:bg_none   .s:fmt_none

exe "hi hsStructure"        . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hs_hlFunctionName"  . s:fg_blue   .s:bg_none
exe "hi hsStatement"        . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hsImportLabel"      . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hs_OpFunctionName"  . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi hs_DeclareFunction" . s:fg_orange .s:bg_none   .s:fmt_none
exe "hi hsVarSym"           . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hsType"             . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi hsTypedef"          . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hsModuleName"       . s:fg_green  .s:bg_none   .s:fmt_undr
exe "hi hsModuleStartLabel" . s:fg_magenta.s:bg_none   .s:fmt_none
hi link hsImportParams      Delimiter
hi link hsDelimTypeExport   Delimiter
hi link hsModuleStartLabel  hsStructure
hi link hsModuleWhereLabel  hsModuleStartLabel

" following is for the haskell-conceal plugin
" the first two items don't have an impact, but better safe
exe "hi hsNiceOperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi hsniceoperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none

"}}}
" pandoc markdown syntax highlighting "{{{
" ---------------------------------------------------------------------

"PandocHiLink pandocNormalBlock
exe "hi pandocTitleBlock"               .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi pandocTitleBlockTitle"          .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi pandocTitleComment"             .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi pandocComment"                  .s:fg_base01 .s:bg_none   .s:fmt_ital
exe "hi pandocVerbatimBlock"            .s:fg_yellow .s:bg_none   .s:fmt_none
hi link pandocVerbatimBlockDeep         pandocVerbatimBlock
hi link pandocCodeBlock                 pandocVerbatimBlock
hi link pandocCodeBlockDelim            pandocVerbatimBlock
exe "hi pandocBlockQuote"               .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader1"        .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader2"        .s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader3"        .s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader4"        .s:fg_red    .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader5"        .s:fg_base0  .s:bg_none   .s:fmt_none
exe "hi pandocBlockQuoteLeader6"        .s:fg_base01 .s:bg_none   .s:fmt_none
exe "hi pandocListMarker"               .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi pandocListReference"            .s:fg_magenta.s:bg_none   .s:fmt_undr

" Definitions
" ---------------------------------------------------------------------
let s:fg_pdef = s:fg_violet
exe "hi pandocDefinitionBlock"              .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi pandocDefinitionTerm"               .s:fg_pdef  .s:bg_none  .s:fmt_stnd
exe "hi pandocDefinitionIndctr"             .s:fg_pdef  .s:bg_none  .s:fmt_bold
exe "hi pandocEmphasisDefinition"           .s:fg_pdef  .s:bg_none  .s:fmt_ital
exe "hi pandocEmphasisNestedDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bldi
exe "hi pandocStrongEmphasisDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bold
exe "hi pandocStrongEmphasisNestedDefinition"   .s:fg_pdef.s:bg_none.s:fmt_bldi
exe "hi pandocStrongEmphasisEmphasisDefinition" .s:fg_pdef.s:bg_none.s:fmt_bldi
exe "hi pandocStrikeoutDefinition"          .s:fg_pdef  .s:bg_none  .s:fmt_revr
exe "hi pandocVerbatimInlineDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi pandocSuperscriptDefinition"        .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi pandocSubscriptDefinition"          .s:fg_pdef  .s:bg_none  .s:fmt_none

" Tables
" ---------------------------------------------------------------------
let s:fg_ptable = s:fg_blue
exe "hi pandocTable"                        .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi pandocTableStructure"               .s:fg_ptable.s:bg_none  .s:fmt_none
hi link pandocTableStructureTop             pandocTableStructre
hi link pandocTableStructureEnd             pandocTableStructre
exe "hi pandocTableZebraLight"              .s:fg_ptable.s:bg_base03.s:fmt_none
exe "hi pandocTableZebraDark"               .s:fg_ptable.s:bg_base02.s:fmt_none
exe "hi pandocEmphasisTable"                .s:fg_ptable.s:bg_none  .s:fmt_ital
exe "hi pandocEmphasisNestedTable"          .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi pandocStrongEmphasisTable"          .s:fg_ptable.s:bg_none  .s:fmt_bold
exe "hi pandocStrongEmphasisNestedTable"    .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi pandocStrongEmphasisEmphasisTable"  .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi pandocStrikeoutTable"               .s:fg_ptable.s:bg_none  .s:fmt_revr
exe "hi pandocVerbatimInlineTable"          .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi pandocSuperscriptTable"             .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi pandocSubscriptTable"               .s:fg_ptable.s:bg_none  .s:fmt_none

" Headings
" ---------------------------------------------------------------------
let s:fg_phead = s:fg_orange
exe "hi pandocHeading"                      .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi pandocHeadingMarker"                .s:fg_yellow.s:bg_none.s:fmt_bold
exe "hi pandocEmphasisHeading"              .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi pandocEmphasisNestedHeading"        .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi pandocStrongEmphasisHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi pandocStrongEmphasisNestedHeading"  .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi pandocStrongEmphasisEmphasisHeading".s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi pandocStrikeoutHeading"             .s:fg_phead .s:bg_none.s:fmt_revr
exe "hi pandocVerbatimInlineHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi pandocSuperscriptHeading"           .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi pandocSubscriptHeading"             .s:fg_phead .s:bg_none.s:fmt_bold

" Links
" ---------------------------------------------------------------------
exe "hi pandocLinkDelim"                .s:fg_base01 .s:bg_none   .s:fmt_none
exe "hi pandocLinkLabel"                .s:fg_blue   .s:bg_none   .s:fmt_undr
exe "hi pandocLinkText"                 .s:fg_blue   .s:bg_none   .s:fmt_undb
exe "hi pandocLinkURL"                  .s:fg_base00 .s:bg_none   .s:fmt_undr
exe "hi pandocLinkTitle"                .s:fg_base00 .s:bg_none   .s:fmt_undi
exe "hi pandocLinkTitleDelim"           .s:fg_base01 .s:bg_none   .s:fmt_undi   .s:sp_base00
exe "hi pandocLinkDefinition"           .s:fg_cyan   .s:bg_none   .s:fmt_undr   .s:sp_base00
exe "hi pandocLinkDefinitionID"         .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi pandocImageCaption"             .s:fg_violet .s:bg_none   .s:fmt_undb
exe "hi pandocFootnoteLink"             .s:fg_green  .s:bg_none   .s:fmt_undr
exe "hi pandocFootnoteDefLink"          .s:fg_green  .s:bg_none   .s:fmt_bold
exe "hi pandocFootnoteInline"           .s:fg_green  .s:bg_none   .s:fmt_undb
exe "hi pandocFootnote"                 .s:fg_green  .s:bg_none   .s:fmt_none
exe "hi pandocCitationDelim"            .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi pandocCitation"                 .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi pandocCitationID"               .s:fg_magenta.s:bg_none   .s:fmt_undr
exe "hi pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none

" Main Styles
" ---------------------------------------------------------------------
exe "hi pandocStyleDelim"               .s:fg_base01 .s:bg_none  .s:fmt_none
exe "hi pandocEmphasis"                 .s:fg_base0  .s:bg_none  .s:fmt_ital
exe "hi pandocEmphasisNested"           .s:fg_base0  .s:bg_none  .s:fmt_bldi
exe "hi pandocStrongEmphasis"           .s:fg_base0  .s:bg_none  .s:fmt_bold
exe "hi pandocStrongEmphasisNested"     .s:fg_base0  .s:bg_none  .s:fmt_bldi
exe "hi pandocStrongEmphasisEmphasis"   .s:fg_base0  .s:bg_none  .s:fmt_bldi
exe "hi pandocStrikeout"                .s:fg_base01 .s:bg_none  .s:fmt_revr
exe "hi pandocVerbatimInline"           .s:fg_yellow .s:bg_none  .s:fmt_none
exe "hi pandocSuperscript"              .s:fg_violet .s:bg_none  .s:fmt_none
exe "hi pandocSubscript"                .s:fg_violet .s:bg_none  .s:fmt_none

exe "hi pandocRule"                     .s:fg_blue   .s:bg_none  .s:fmt_bold
exe "hi pandocRuleLine"                 .s:fg_blue   .s:bg_none  .s:fmt_bold
exe "hi pandocEscapePair"               .s:fg_red    .s:bg_none  .s:fmt_bold
exe "hi pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi pandocNonBreakingSpace"         . s:fg_red   .s:bg_none  .s:fmt_revr
hi link pandocEscapedCharacter          pandocEscapePair
hi link pandocLineBreak                 pandocEscapePair

" Embedded Code
" ---------------------------------------------------------------------
exe "hi pandocMetadataDelim"            .s:fg_base01 .s:bg_none   .s:fmt_none
exe "hi pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi pandocMetadataKey"              .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_bold
hi link pandocMetadataTitle             pandocMetadata
"}}}
" License "{{{
" ---------------------------------------------------------------------
"
" Copyright (c) 2011 Ethan Schoonover
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
"}}}
