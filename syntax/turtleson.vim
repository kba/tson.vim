" Vim syntax file
" Language:     TSON
" Version:      1.1
" SeeAlso:      <http://github.com/kba/tson>
" Maintainer:   Konstantin Baierer <konstantin.baierer@gmail.com>
" Created:      2015-03-10
" Updated:      2015-03-10

" Based Niklas Lindstrom's n3.vim plugin (https://github.com/niklasl/vim-rdf)

" TODO:
"   * string value specials
"   * fix XML Literal syntax (triplequoutes PLUS ^^rdfs:XMLLiteral)
"   * "@"-prefix of verbs (?)
"   * grouping e.g. statements to ebable folding, error checking etc.


if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match   tsonSeparator         "[][;,)(}{^!]"
syn match   tsonDeclaration       "@[a-zA-Z0-9_-]*"
syn match   tsonClassName         "\(:\?\)\@<=[A-Z][a-zA-Z0-9_-]*"
syn match   tsonPropertyName      "\(:\?\)\@<=[a-z][a-zA-Z0-9_-]*"
syn match   tsonPrefix            "\([a-zA-Z_][a-zA-Z0-9_]*\)\?:"
syn keyword tsonTodo              TODO FIXME XXX contained

" URI:s, strings, numbers, variables
syn match tsonNumber              "[-+]\?[0-9]\+\(\.[0-9]\+\)\?\(e[-+]\?[0-9]\+\)\?" 
syn region tsonURI                matchgroup=tsonURI start=+<+ end=+>+ skip=+\\\\\|\\"+ contains=tsonURITokens
" TODO: tsonURITokens
syn region tsonString             matchgroup=tsonStringDelim start=+['"]+ end=+["']+ skip=+\\\\\|\\"+ contains=tsonEscape
" TODO: tsonEscape

" Comments
syn match   tsonComment           "#.*$" contains=tsonTodo
syn region tsonMultilineComment matchgroup=tsonMultilineComment start=+###+ end=+###+ contains=tsonTodo


" Highlight Links
if version >= 508 || !exists("did_tson_syn_inits")
  if version <= 508
    let did_tson_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink tsonSeparator            Operator
  HiLink tsonDeclaration          Statement
  HiLink tsonClassName            Identifier
  HiLink tsonPropertyName         Identifier
  HiLink tsonComment              Comment
  HiLink tsonMultilineComment     Comment
  HiLink tsonTodo                 Todo
  HiLink tsonNumber               Number
  HiLink tsonURI                  Type
  HiLink tsonString               String
  HiLink tsonStringDelim          Constant
  HiLink tsonPrefix               PreProc

  delcommand HiLink
endif

let b:current_syntax = "tson"

" EOF
