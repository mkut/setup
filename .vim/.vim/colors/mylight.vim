set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="mylight"

hi Normal        ctermfg=white ctermbg=232
hi LineNr        ctermfg=green ctermbg=233 
hi Statusline    ctermfg=white ctermbg=232
hi StatuslineNC  ctermfg=white ctermbg=232
hi VertSplit     ctermfg=white ctermbg=232
hi Cursor                      ctermfg=white

" hi Title    ctermfg=black	 ctermbg=white gui=BOLD
" hi lCursor  ctermbg=Cyan   ctermfg=NONE

" syntax highlighting groups
" hi Comment    gui=NONE ctermfg=#996666
" hi Operator   ctermfg=#ff0000

" hi Identifier    ctermfg=#33ff99 gui=NONE

" hi Statement	 ctermfg=#cc9966 gui=NONE
" hi TypeDef       ctermfg=#c000c8 gui=NONE
" hi Type          ctermfg=#ccffff gui=NONE
" hi Boolean       ctermfg=#ff00aa gui=NONE

" hi String        ctermfg=#99ccff gui=NONE
" hi Number        ctermfg=#66ff66 gui=NONE
" hi Constant      ctermfg=#f0f000 gui=NONE

" hi Function      gui=NONE      ctermfg=#fffcfc 
" hi PreProc       ctermfg=#cc6600 gui=NONE
" hi Define        gui=bold ctermfg=#f0f0f0 
" hi Special       gui=none ctermfg=#cccccc 
" hi BrowseDirectory  gui=none ctermfg=#FFFF00 

" hi Keyword       ctermfg=#ff8088 gui=NONE
" hi Search        gui=NONE ctermbg=#ffff00 ctermfg=#330000 
" hi IncSearch     gui=NONE ctermfg=#fcfcfc ctermbg=#8888ff
" hi SpecialKey    gui=NONE ctermfg=#fcfcfc ctermbg=#8888ff
" hi NonText       gui=NONE ctermfg=#fcfcfc 
" hi Directory     gui=NONE ctermfg=#999900
