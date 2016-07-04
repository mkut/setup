" Vim syntax file
" Language:    LiLFeS
" Last Change: 2011 Jun 30

" There are two sets of highlighting in here:
" If the "lilfes_highlighting_clean" variable exists, it is rather sparse.
" Otherwise you get more highlighting.

" Quit when a syntax file was already loaded
if version < 600
   syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Prolog is case sensitive.
syn case match

" Very simple highlighting for comments, clause heads and
" character codes.  It respects lilfes strings and atoms.

syn region   lilfesCComment	start=+/\*+ end=+\*/+
syn match    lilfesComment	+%.*+

syn keyword  lilfesKeyword	module meta_predicate multifile dynamic
syn match    lilfesCharCode	+0'\\\=.+
syn region   lilfesString       start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match    lilfesIdentifier     +[A-Z][a-zA-Z0-9]*+
syn region   lilfesAtom                start=+'+ skip=+\\\\\|\\'+ end=+'+
" syn region   lilfesClauseHead   start=+^[a-z][^(]*(+ skip=+\.[^		]+ end=+:-\|\.$\|\.[	 ]\|-->+ contains=lilfesComment,lilfesCComment,lilfesString,lilfesIdentifier

if !exists("lilfes_highlighting_clean")

  " some keywords
  " some common predicates are also highlighted as keywords
  " is there a better solution?
  syn keyword lilfesKeyword   abolish current_output  peek_code
  " syn keyword lilfesKeyword   append  current_predicate       put_byte
  syn keyword lilfesKeyword   arg     current_lilfes_flag     put_char
  syn keyword lilfesKeyword   asserta fail    put_code
  syn keyword lilfesKeyword   assertz findall read
  syn keyword lilfesKeyword   at_end_of_stream	      float   read_term
  syn keyword lilfesKeyword   atom    flush_output    repeat
  syn keyword lilfesKeyword   atom_chars      functor retract
  syn keyword lilfesKeyword   atom_codes      get_byte	      set_input
  syn keyword lilfesKeyword   atom_concat     get_char	      set_output
  syn keyword lilfesKeyword   atom_length     get_code	      set_lilfes_flag
  syn keyword lilfesKeyword   atomic  halt    set_stream_position
  syn keyword lilfesKeyword   bagof   integer setof
  syn keyword lilfesKeyword   call    is      stream_property
  syn keyword lilfesKeyword   catch   nl      sub_atom
  syn keyword lilfesKeyword   char_code       nonvar  throw
  syn keyword lilfesKeyword   char_conversion number  true
  syn keyword lilfesKeyword   clause  number_chars    unify_with_occurs_check
  syn keyword lilfesKeyword   close   number_codes    var
  syn keyword lilfesKeyword   compound	      once    write
  syn keyword lilfesKeyword   copy_term       op      write_canonical
  syn keyword lilfesKeyword   current_char_conversion open    write_term
  syn keyword lilfesKeyword   current_input   peek_byte       writeq
  syn keyword lilfesKeyword   current_op      peek_char
  " LiLFeS Only
  syn keyword lilfesKeyword   ensure_loaded

  syn match   lilfesOperator "=\\=\|=:=\|\\==\|=<\|==\|>=\|\\=\|\\+\|<\|>\|="
  " LiLFeS Only
  syn match   lilfesAsIs     "===\|\\===\|<=\|=>"

  syn match   lilfesNumber	      "\<[0123456789]*\>'\@!"
  syn match   lilfesCommentError      "\*/"
  syn match   lilfesSpecialCharacter  ";"
  syn match   lilfesSpecialCharacter  "!"
  syn match   lilfesQuestion	      "?-.*\."	contains=lilfesNumber

  syn match   lilfesClauseHead   +<-[^\[]*\[[^\]]*\]\.+

endif

syn sync maxlines=50


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lilfes_syn_inits")
  if version < 508
    let did_lilfes_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlighting.
  HiLink lilfesComment		Comment
  HiLink lilfesCComment		Comment
  HiLink lilfesCharCode		Special

  if exists ("lilfes_highlighting_clean")

    HiLink lilfesKeyword	Statement
    HiLink lilfesClauseHead	Statement

  else
    HiLink lilfesKeyword	Keyword
    HiLink lilfesIdentifier     Identifier
    HiLink lilfesClauseHead	PreProc
    HiLink lilfesType           Type
    HiLink lilfesQuestion	PreProc
    HiLink lilfesSpecialCharacter Special
    HiLink lilfesNumber		Number
    HiLink lilfesAsIs		Normal
    HiLink lilfesCommentError	Error
    HiLink lilfesAtom		String
    HiLink lilfesString		String
    HiLink lilfesOperator	Operator

  endif

  delcommand HiLink
endif

let b:current_syntax = "lilfes"

" vim: ts=8

