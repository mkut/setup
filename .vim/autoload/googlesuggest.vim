if !exists('g:googlesuggest_language')
  let g:googlesuggest_language = 'ja'
endif

function! s:nr2byte(nr)
  if a:nr < 0x80
    return nr2char(a:nr)
  elseif a:nr < 0x800
    return nr2char(a:nr/64+192).nr2char(a:nr%64+128)
  else
    return nr2char(a:nr/4096%16+224).nr2char(a:nr/64%64+128).nr2char(a:nr%64+128)
  endif
endfunction

function! s:nr2enc_char(charcode)
  if &encoding == 'utf-8'
    return nr2char(a:charcode)
  endif
  let char = s:nr2byte(a:charcode)
  if strlen(char) > 1
    let char = strtrans(iconv(char, 'utf-8', &encoding))
  endif
  return char
endfunction

function! s:nr2hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunction

function! s:encodeURIComponent(instr)
  let instr = iconv(a:instr, &enc, "utf-8")
  let len = strlen(instr)
  let i = 0
  let outstr = ''
  while i < len
    let ch = instr[i]
    if ch =~# '[0-9A-Za-z-._~!''()*]'
      let outstr = outstr . ch
    elseif ch == ' '
      let outstr = outstr . '+'
    else
      let outstr = outstr . '%' . substitute('0' . s:nr2hex(char2nr(ch)), '^.*\(..\)$', '\1', '')
    endif
    let i = i + 1
  endwhile
  return outstr
endfunction

function! s:item2query(items, sep)
  let ret = ''
  if type(a:items) == 4
    for key in keys(a:items)
      if strlen(ret) | let ret .= a:sep | endif
      let ret .= key . "=" . s:encodeURIComponent(a:items[key])
    endfor
  elseif type(a:items) == 3
    for item in a:items
      if strlen(ret) | let ret .= a:sep | endif
      let ret .= item
    endfor
  else
    let ret = a:items
  endif
  return ret
endfunction

function! s:do_http(url, getdata, postdata, cookie, returnheader)
  let url = a:url
  let getdata = s:item2query(a:getdata, '&')
  let postdata = s:item2query(a:postdata, '&')
  let cookie = s:item2query(a:cookie, '; ')
  if strlen(getdata)
    let url .= "?" . getdata
  endif
  let command = "curl -s -k"
  if a:returnheader
    let command .= " -i"
  endif
  if strlen(cookie)
    let command .= " -H \"Cookie: " . cookie . "\""
  endif
  let command .= " \"" . url . "\""
  if strlen(postdata)
    let file = tempname()
    exec 'redir! > '.file
    silent echo postdata
    redir END
    let quote = &shellxquote == '"' ?  "'" : '"'
    let res = system(command . " -d @" . quote.file.quote)
    call delete(file)
  else
    let res = system(command)
  endif
  return res
endfunction

function s:toHira(str)
	let str = a:str
	let table = {
\ "a"  : "あ"  , "i"  : "い"  , "u"  : "う"  , "e"  : "え"  , "o"  : "お"  ,
\ "ka" : "か"  , "ki" : "き"  , "ku" : "く"  , "ke" : "け"  , "ko" : "こ"  ,
\ "sa" : "さ"  , "si" : "し"  , "su" : "す"  , "se" : "せ"  , "so" : "そ"  ,
\ "ta" : "た"  , "ti" : "ち"  , "tu" : "つ"  , "te" : "て"  , "to" : "と"  ,
\ "na" : "な"  , "ni" : "に"  , "nu" : "ぬ"  , "ne" : "ね"  , "no" : "の"  ,
\ "ha" : "は"  , "hi" : "ひ"  , "hu" : "ふ"  , "he" : "へ"  , "ho" : "ほ"  ,
\ "ma" : "ま"  , "mi" : "み"  , "mu" : "む"  , "me" : "め"  , "mo" : "も"  ,
\ "ya" : "や"  , "yi" : "い"  , "yu" : "ゆ"  , "ye" : "いぇ", "yo" : "よ"  ,
\ "ra" : "ら"  , "ri" : "り"  , "ru" : "る"  , "re" : "れ"  , "ro" : "ろ"  ,
\ "wa" : "わ"  , "wi" : "うぃ", "wu" : "う"  , "we" : "うぇ", "wo" : "を"  ,
\ "xa" : "ぁ"  , "xi" : "ぃ"  , "xu" : "ぅ"  , "xe" : "ぇ"  , "xo" : "ぉ"  ,
\ "la" : "ぁ"  , "li" : "ぃ"  , "lu" : "ぅ"  , "le" : "ぇ"  , "lo" : "ぉ"  ,
\ "kya": "きゃ", "kyi": "きぃ", "kyu": "きゅ", "kye": "きぇ", "kyo": "きょ",
\ "sya": "しゃ", "syi": "しぃ", "syu": "しゅ", "sye": "しぇ", "syo": "しょ",
\ "sha": "しゃ", "shi": "し"  , "shu": "しゅ", "she": "しぇ", "sho": "しょ",
\ "tya": "ちゃ", "tyi": "ちぃ", "tyu": "ちゅ", "tye": "ちぇ", "tyo": "ちょ",
\ "cha": "ちゃ", "chi": "ち"  , "chu": "ちゅ", "che": "ちぇ", "cho": "ちょ",
\ "tsa": "つぁ", "tsi": "つぃ", "tsu": "つ"  , "tse": "つぇ", "tso": "つぉ",
\ "nya": "にゃ", "nyi": "にぃ", "nyu": "にゅ", "nye": "にぇ", "nyo": "にょ",
\ "hya": "ひゃ", "hyi": "ひぃ", "hyu": "ひゅ", "hye": "ひぇ", "hyo": "ひょ",
\ "mya": "みゃ", "myi": "みぃ", "myu": "みゅ", "mye": "みぇ", "myo": "みょ",
\ "xxa": "ゃ"  , "xxi": "ぃ"  , "xxu": "ゅ"  , "xxe": "ぇ"  , "xxo": "ょ"  ,
\ "lya": "ゃ"  , "lyi": "ぃ"  , "lyu": "ゅ"  , "lye": "ぇ"  , "lyo": "ょ"  ,
\ "rya": "りゃ", "ryi": "りぃ", "ryu": "りゅ", "rye": "りぇ", "ryo": "りょ",
\ "fa" : "ふぁ", "fi" : "ふぃ", "fu" : "ふ"  , "fe" : "ふぇ", "fo" : "ふぉ",
\ "ga" : "が"  , "gi" : "ぎ"  , "gu" : "ぐ"  , "ge" : "げ"  , "go" : "ご"  ,
\ "za" : "ざ"  , "zi" : "じ"  , "zu" : "ず"  , "ze" : "ぜ"  , "zo" : "ぞ"  ,
\ "da" : "だ"  , "di" : "ぢ"  , "du" : "づ"  , "de" : "で"  , "do" : "ど"  ,
\ "ba" : "ば"  , "bi" : "び"  , "bu" : "ぶ"  , "be" : "べ"  , "bo" : "ぼ"  ,
\ "pa" : "ぱ"  , "pi" : "ぴ"  , "pu" : "ぷ"  , "pe" : "ぺ"  , "po" : "ぽ"  ,
\ "va" : "ヴァ", "vi" : "ヴィ", "vu" : "ヴ"  , "ve" : "ヴォ", "vo" : "ヴォ",
\ "gya": "ぎゃ", "gyi": "ぎぃ", "gyu": "ぎゅ", "gye": "ぎぇ", "gyo": "ぎょ",
\ "jya": "じゃ", "jyi": "じぃ", "jyu": "じゅ", "jye": "じぇ", "jyo": "じょ",
\ "ja" : "じゃ", "ji" : "じ"  , "ju" : "じゅ", "je" : "じぇ", "jo" : "じょ",
\ "dya": "ぢゃ", "dyi": "ぢぃ", "dyu": "ぢゅ", "dye": "ぢぇ", "dyo": "ぢょ",
\ "bya": "びゃ", "byi": "びぃ", "byu": "びゅ", "bye": "びぇ", "byo": "びょ",
\ "pya": "ぴゃ", "pyi": "ぴぃ", "pyu": "ぴゅ", "pye": "ぴぇ", "pyo": "ぴょ",
\ "n"  : "ん"  , "nn" : "ん"  
\	}
	let res = ""
	let prev = 0
	for i in range(strlen(str))
		let next = str[prev : i]
		if has_key(table, next)
			let prev = i+1
			let res = res . table[next]
		endif
		let i = i + 1
	endfor
	return res
endfunction

function! googlesuggest#Complete(str)
   " find months matching with "a:base"
   let res = []
   let q = iconv(a:str, "utf-8", &encoding)
 let q = <SID>toHira(q)
 if q == ""
	 return res
 endif
   let str = s:do_http('http://google.com/transliterate', {"text" : q, "langpair" : "ja-Hira|ja" }, {}, {}, 0)
   let str = iconv(str, "utf-8", &encoding)
 let str = substitute(str, "\n", "", "g")
   let l:true = 1
   let l:false = 0
   let lst = eval(str)
   for m in lst[0][1]
	 for i in range(1, len(lst)-1)
	 	let m = m . "," . lst[i][0]
		let i = i + 1
	endfor
     call add(res, {word: m})
   endfor
   return res
endfunction

