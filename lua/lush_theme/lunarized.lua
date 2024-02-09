--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")

local gui_combine = function(gui)
	for i = 1, #gui do
		if gui[i] == "" then
			table.remove(gui, i)
		end
	end
	return table.concat(gui, ",")
end

local clrs = require("lunarized").colors

local cfg = {
	bold = vim.g.lunarized_bold or 1,
	italic = vim.g.lunarized_italic or 0,
	underline = vim.g.lunarized_underline or 1,
}

local s = {
	none = "NONE",
	n = "NONE",
	c = "undercurl",
	r = "reverse",
	s = "standout",
	ou = "",
	ob = "",
	b = cfg.bold == 1 and "bold" or "",
	bb = cfg.bold == 1 and "" or "bold",
	u = cfg.underline == 1 and "underline" or "",
	i = cfg.italic == 1 and "italic" or "",
}

-- `p` for highlighting primitive
local p = {
	back = clrs.base03,
	revbb = gui_combine { s.r, s.bb },
	revbbu = gui_combine { s.r, s.bb, s.u },
}

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		-- The following are all the Neovim default highlight groups from the docs
		-- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
		-- probably style all of these at a bare minimum.
		--
		-- Referenced/linked groups must come before being referenced/lined,
		-- so the order shown ((mostly) alphabetical) is likely
		-- not the order you will end up with.
		--
		-- You can uncomment these and leave them empty to disable any
		-- styling for that group (meaning they mostly get styled as Normal)
		-- or leave them commented to apply vims default colouring or linking.

		Comment { fg = clrs.base01, gui = gui_combine { "NONE", s.i } }, -- any comment
		ColorColumn { bg = clrs.base02 }, -- used for the columns set with 'colorcolumn'
		Conceal { fg = clrs.blue }, -- placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor { fg = clrs.base03, bg = clrs.base0 }, -- character under the cursor
		lCursor { Cursor }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
		CursorColumn { bg = clrs.base02 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine { CursorColumn, sp = clrs.base1, gui = s.ou }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory { fg = clrs.blue }, -- directory names (and other special names in listings)
		DiffAdd { fg = clrs.green, bg = clrs.base02, sp = clrs.green, gui = s.b }, -- diff mode: Added line |diff.txt|
		DiffChange { fg = clrs.yellow, bg = clrs.base02, sp = clrs.yellow, gui = s.b }, -- diff mode: Changed line |diff.txt|
		DiffDelete { fg = clrs.red, bg = clrs.base02, gui = s.b }, -- diff mode: Deleted line |diff.txt|
		DiffText { fg = clrs.blue, bg = clrs.base02, sp = clrs.blue, gui = s.b }, -- diff mode: Changed text within a changed line |diff.txt|
		-- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		-- TermCursor   { }, -- cursor in a focused terminal
		-- TermCursorNC { }, -- cursor in an unfocused terminal
		ErrorMsg { fg = clrs.red, gui = s.r }, -- error messages on the command line
		VertSplit { fg = clrs.base00 }, -- the column separating vertically split windows
		Folded { fg = clrs.base0, bg = clrs.base02, sp = clrs.base03, gui = s.b }, -- line used for closed folds
		FoldColumn { fg = clrs.base0, bg = clrs.base02 }, -- 'foldcolumn'
		SignColumn { fg = clrs.base0 }, -- column where |signs| are displayed
		IncSearch { fg = clrs.orange, gui = s.s }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		-- Substitute   { }, -- |:substitute| replacement text highlighting
		LineNR { fg = "#004C60", gui = s.b, bg = "#002B36" },
		CursorLineNr { CursorLine }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		-- Overridden below in YADR section
		-- MatchParen   { fg = clrs.red, bg = clrs.base01, gui = s.b }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg { fg = clrs.blue }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea      { }, -- Area for messages and cmdline
		-- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg { fg = clrs.blue }, -- |more-prompt|
		NonText { fg = clrs.base00, bg = s.none, gui = s.b }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal { fg = clrs.base0, bg = p.back, gui = s.none }, -- normal text
		NormalFloat { Normal }, -- Normal text in floating windows.
		NormalNC { Normal }, -- normal text in non-current windows
		Pmenu { Normal, bg = Normal.bg.darken(13) }, -- Popup menu: normal item.
		-- Pmenu { fg = clrs.base02, bg = clrs.base1, gui = p.revbb }, -- Popup menu: normal item.
		PmenuSel { fg = clrs.base01, bg = clrs.base2, gui = p.revbb }, -- Popup menu: selected item.
		PmenuSbar { fg = clrs.base2, bg = clrs.base0, gui = p.revbb }, -- Popup menu: scrollbar.
		PmenuThumb { fg = clrs.base0, bg = clrs.base03, gui = p.revbb }, -- Popup menu: Thumb of the scrollbar.
		Question { fg = clrs.cyan, gui = s.b }, -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search { fg = clrs.yellow, gui = s.s }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		SpecialKey { fg = clrs.base00, bg = clrs.base02, gui = s.b }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
		SpellBad { sp = clrs.red, gui = s.c }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellCap { sp = clrs.violet, gui = s.c }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellLocal { sp = clrs.yellow, gui = s.c }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellRare { sp = clrs.cyan, gui = s.c }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine { fg = clrs.base1, bg = clrs.base02, gui = p.revbb }, -- status line of current window
		StatusLineNC { fg = clrs.base00, bg = clrs.base02, gui = p.revbb }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		TabLine { fg = clrs.base0, bg = clrs.base02, sp = clrs.base0 }, -- tab pages line, not active tab page label
		TabLineFill { TabLine }, -- tab pages line, where there are no labels
		TabLineSel { fg = clrs.base01, bg = clrs.base2, sp = clrs.base0, gui = s.r }, -- tab pages line, active tab page label
		Title { fg = clrs.orange, gui = s.b }, -- titles for output from ":set all", ":autocmd" etc.
		Visual { fg = clrs.base01, bg = clrs.base03, gui = p.revbb }, -- Visual mode selection
		VisualNOS { bg = clrs.base02, gui = gui_combine { s.r, s.bb, s.s } }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg { fg = clrs.red, gui = s.b }, -- warning messages
		-- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		WildMenu { fg = clrs.base2, bg = clrs.base02, gui = p.revbb }, -- current match in 'wildmenu' completion

		-- These groups are not listed as default vim groups,
		-- but they are defacto standard group names for syntax highlighting.
		-- commented out groups should chain up to their "preferred" group by
		-- default,
		-- Uncomment and edit if you want more specific syntax highlighting.

		Constant { fg = clrs.cyan }, -- (preferred) any constant
		String { Constant }, --   a string constant: "this is a string"
		Character { Constant }, --  a character constant: 'c', '\n'
		Number { Constant }, --   a number constant: 234, 0xff
		Boolean { Constant }, --  a boolean constant: TRUE, false
		Float { Constant }, --    a floating point constant: 2.3e10

		Identifier { fg = clrs.blue }, -- (preferred) any variable name
		Function { Identifier }, -- function name (also: methods for classes)

		Statement { fg = clrs.green }, -- (preferred) any statement
		Conditional { Statement }, --  if, then, else, endif, switch, etc.
		Repeat { Statement }, --   for, do, while, etc.
		Label { Statement }, --    case, default, etc.
		Operator { Statement }, -- "sizeof", "+", "*", etc.
		Keyword { Statement }, --  any other keyword
		Exception { Statement }, --  try, catch, throw

		PreProc { fg = clrs.orange }, -- (preferred) generic Preprocessor
		Include { PreProc }, --  preprocessor #include
		Define { PreProc }, --   preprocessor #define
		Macro { PreProc }, --    same as Define
		PreCondit { PreProc }, --  preprocessor #if, #else, #endif, etc.

		Type { fg = clrs.yellow, gui = s.b }, -- (preferred) int, long, char, etc.
		StorageClass { Type }, -- static, register, volatile, etc.
		Structure { Type }, --  struct, union, enum, etc.
		Typedef { Type }, --  A typedef

		Special { fg = clrs.red }, -- (preferred) any special symbol
		SpecialChar { Special }, --  special character in a constant
		Tag { Special }, --    you can use CTRL-] on this
		Delimiter { Special }, --  character that needs attention
		SpecialComment { Special }, -- special things inside a comment
		Debug { Special }, --    debugging statements

		Underlined { fg = clrs.violet, gui = "underline" }, -- (preferred) text that stands out, HTML links
		Bold { gui = s.b },
		Italic { gui = s.i },
		Strike { gui = "strikethrough" },

		-- ("Ignore", below, may be invisible...)
		Ignore { fg = "NONE", bg = "NONE" }, -- (preferred) left blank, hidden  |hl-Ignore|

		Error { fg = clrs.red, gui = s.b }, -- (preferred) any erroneous construct

		Todo { fg = clrs.magenta, gui = s.b }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client. Some other LSP clients may
		-- use these groups, or use their own. Consult your LSP client's
		-- documentation.

		DiagnosticError { fg = clrs.red }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn { fg = clrs.yellow }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo { fg = clrs.cyan }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint { fg = clrs.green }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

		-- DiagnosticVirtualTextError           { }, -- Used for "Error" diagnostic virtual text
		-- DiagnosticVirtualTextWarn            { }, -- Used for "Warning" diagnostic virtual text
		-- DiagnosticVirtualTextInfo            { }, -- Used for "Information" diagnostic virtual text
		-- DiagnosticVirtualTextHint            { }, -- Used for "Hint" diagnostic virtual text

		DiagnosticUnderlineError { fg = s.none, gui = s.u }, -- Used to underline "Error" diagnostics
		DiagnosticUnderlineWarn { DiagnosticUnderlineError }, -- Used to underline "Warning" diagnostics
		DiagnosticUnderlineInfo { DiagnosticUnderlineError }, -- Used to underline "Information" diagnostics
		DiagnosticUnderlineHint { DiagnosticUnderlineError }, -- Used to underline "Hint" diagnostics

		-- DiagnosticFloatingError              { }, -- Used to color "Error" diagnostic messages in diagnostics float
		-- DiagnosticFloatingWarn               { }, -- Used to color "Warning" diagnostic messages in diagnostics float
		-- DiagnosticFloatingInfo               { }, -- Used to color "Information" diagnostic messages in diagnostics float
		-- DiagnosticFloatingHint               { }, -- Used to color "Hint" diagnostic messages in diagnostics float

		-- DiagnosticSignError                  { }, -- Used for "Error" signs in sign column
		-- DiagnosticSignWarn                   { }, -- Used for "Warning" signs in sign column
		-- DiagnosticSignInfo                   { }, -- Used for "Information" signs in sign column
		-- DiagnosticSignHint                   { }, -- Used for "Hint" signs in sign column

		--
		-- Treesitter
		--
		-- Use the capture names directly as the highlight groups.
		-- To find all the capture names, see https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights)

		-- Identifiers
		sym("@variable") { Identifier }, -- various variable names
		sym("@variable.builtin") { Special }, -- built-in variable names (e.g. `this`)
		sym("@variable.parameter") { sym("@variable") }, -- parameters of a function, use a conspicuous color (VSCode uses the common light_blue)
		sym("@variable.member") { sym("@variable") }, -- object and struct fields

		sym("@constant") { Constant }, -- constant identifiers
		sym("@constant.builtin") { Type }, -- built-in constant values
		sym("@constant.macro") { Define }, -- constants defined by the preprocessor

		sym("@module") { Structure }, -- modules or namespaces
		sym("@module.builtin") { Special }, -- built-in modules or namespaces
		sym("@label") { Label }, -- GOTO and other labels (e.g. `label:` in C), including heredoc labels

		-- Literals
		sym("@string") { String }, -- string literals
		sym("@string.documentation") { sym("@string") }, -- string documenting code (e.g. Python docstrings)
		sym("@string.regexp") { SpecialChar }, -- regular expressions
		sym("@string.escape") { Character }, -- escape sequences
		sym("@string.special") { Character }, -- other special strings (e.g. dates)
		sym("@string.special.symbol") { sym("@string.special") }, -- symbols or atoms
		sym("@string.special.url") { sym("@string.special") }, -- URIs (e.g. hyperlinks), it's url outside markup
		sym("@string.special.path") { sym("@string.special") }, -- filenames

		sym("@character") { Character }, -- character literals
		sym("@character.special") { SpecialChar }, -- special characters (e.g. wildcards)

		sym("@boolean") { Boolean }, -- boolean literals
		sym("@number") { Number }, -- numeric literals
		sym("@number.float") { Float }, -- floating-point number literals

		-- Types
		sym("@type") { Structure }, -- type or class definitions and annotations
		sym("@type.builtin") { Special }, -- built-in types
		sym("@type.definition") { Typedef }, -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
		sym("@type.qualifier") { Special }, -- type qualifiers (e.g. `const`)

		sym("@attribute") { Identifier }, -- attribute annotations (e.g. Python decorators)
		sym("@property") { Identifier }, -- the key in key/value pairs

		-- Function
		sym("@function") { Function }, -- function definitions
		sym("@function.builtin") { Function }, -- built-in functions
		sym("@function.call") { Function }, -- function calls
		sym("@function.macro") { Function }, -- preprocessor macros

		sym("@function.method") { sym("@function") }, -- method definitions
		sym("@function.method.call") { sym("@function.call") }, -- method calls

		sym("@constructor") { Function }, -- constructor calls and definitions
		sym("@operator") { Operator }, -- symbolic operators (e.g. `+` / `*`)

		-- Keyword
		sym("@keyword") { Keyword }, -- keywords not fitting into specific categories
		sym("@keyword.coroutine") { sym("@keyword") }, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		sym("@keyword.function") { sym("@keyword") }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
		sym("@keyword.operator") { Operator }, -- operators that are English words (e.g. `and` / `or`)
		sym("@keyword.import") { Include }, -- keywords for including modules (e.g. `import` / `from` in Python)
		sym("@keyword.storage") { StorageClass }, -- modifiers that affect storage in memory or life-time
		sym("@keyword.repeat") { Repeat }, -- keywords related to loops (e.g. `for` / `while`)
		sym("@keyword.return") { Keyword }, --  keywords like `return` and `yield`
		sym("@keyword.debug") { Debug }, -- keywords related to debugging
		sym("@keyword.exception") { Exception }, -- keywords related to exceptions (e.g. `throw` / `catch`)

		sym("@keyword.conditional") { Conditional }, -- keywords related to conditionals (e.g. `if` / `else`)
		sym("@keyword.conditional.ternary") { sym("@operator") }, -- ternary operator (e.g. `?` / `:`)

		sym("@keyword.directive") { PreProc }, -- various preprocessor directives & shebangs
		sym("@keyword.directive.define") { sym("@keyword.directive") }, -- preprocessor definition directives

		-- Punctuation
		sym("@punctuation.delimiter") { Delimiter }, -- delimiters (e.g. `;` / `.` / `,`)
		sym("@punctuation.bracket") { Special }, -- brackets (e.g. `()` / `{}` / `[]`)
		sym("@punctuation.special") { Special }, -- special symbols (e.g. `{}` in string interpolation)

		-- Comments
		sym("@comment") { Comment }, -- line and block comments
		sym("@comment.documentation") { sym("@comment") }, -- comments documenting code

		sym("@comment.error") { ErrorMsg }, -- error-type comments (e.g., `DEPRECATED:`)
		sym("@comment.warning") { DiagnosticWarn }, -- warning-type comments (e.g., `WARNING:`, `FIX:`)
		sym("@comment.hint") { DiagnosticHint }, -- note-type comments (e.g., `NOTE:`)
		sym("@comment.info") { DiagnosticInfo }, -- info-type comments
		sym("@comment.todo") { Todo }, -- todo-type comments (e.g-, `TODO:`, `WIP:`)

		-- Markup
		sym("@markup.strong") { Bold }, -- bold text
		sym("@markup.italic") { Italic }, -- text with emphasis
		sym("@markup.strikethrough") { Strike }, -- strikethrough text
		sym("@markup.underline") { Underlined }, -- underlined text (only for literal underline markup!)

		sym("@markup.heading") { Title }, -- headings, titles (including markers)

		sym("@markup.quote") { Constant }, -- block quotes
		sym("@markup.math") { Special }, -- math environments (e.g. `$ ... $` in LaTeX)
		sym("@markup.environment") { Macro }, -- environments (e.g. in LaTeX)

		sym("@markup.link") { PreProc }, -- text references, footnotes, citations, etc.
		sym("@markup.link.label") { sym("@markup.link") }, -- non-url links
		sym("@markup.link.url") { Underlined }, -- url links in markup

		sym("@markup.raw") { Constant }, -- literal or verbatim text (e.g., inline code)
		sym("@markup.raw.block") { sym("@markup.raw") }, -- literal or verbatim text as a stand-alone block

		sym("@markup.list") { SpecialChar }, -- list markers
		-- sym("@markup.list.checked") { }, -- checked todo-style list markers
		-- sym("@markup.list.unchecked") { }, -- unchecked todo-style list markers

		sym("@diff.plus") { DiffAdd }, -- added text (for diff files)
		sym("@diff.minus") { DiffDelete }, -- deleted text (for diff files)
		sym("@diff.delta") { DiffChange },

		sym("@tag") { Tag }, -- XML tag names
		sym("@tag.attribute") { Identifier }, -- XML tag attributes
		sym("@tag.delimiter") { Delimiter }, -- XML tag delimiters

		--
		-- LSP Semantic Tokens
		--
		-- The help page :h lsp-semantic-highlight
		-- A short guide: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
		-- Token types and modifiers are described here: https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide
		--
		sym("@lsp.type.class") { sym("@type") },
		sym("@lsp.type.comment") { sym("@comment") },
		sym("@lsp.type.decorator") { sym("@attribute") },
		sym("@lsp.type.enum") { sym("@type") },
		sym("@lsp.type.enumMember") { sym("@constant") },
		sym("@lsp.type.function") { sym("@function") },
		sym("@lsp.type.interface") { sym("@type") },
		sym("@lsp.type.macro") { sym("@constant.macro") },
		sym("@lsp.type.method") { sym("@function.method") },
		sym("@lsp.type.namespace") { sym("@module") },
		sym("@lsp.type.parameter") { sym("@variable.parameter") },
		sym("@lsp.type.property") { sym("@property") },
		sym("@lsp.type.struct") { sym("@type") },
		sym("@lsp.type.type") { sym("@type") },
		sym("@lsp.type.typeParameter") { sym("@type.definition") },
		sym("@lsp.type.variable") { sym("@variable") },

		-- Language Specific
		-- ruby

		qfLineNr = { fg = c.dark5 },
		qfFileName = { fg = c.blue },

		-- Ported overrides from YADR
		-- txtBold { Identifier },
		-- zshVariableDef { Identifier },
		-- zshFunction { Function },
		-- rubyControl { Statement },
		-- rspecGroupMethods { rubyControl },
		-- rspecMocks { Identifier },
		-- rspecKeywords { Identifier },
		-- rubyLocalVariableOrMethod { Normal },
		-- rubyStringDelimiter { Constant },
		-- rubyString { Constant },
		-- rubyAccess { Todo },
		-- rubySymbol { Identifier },
		-- rubyPseudoVariable { Type },
		-- rubyRailsARAssociationMethod { Title },
		-- rubyRailsARValidationMethod { Title },
		-- rubyRailsMethod { Title },
		-- rubyDoBlock { Normal },
		-- MatchParen { DiffText },

		-- CTagsModule { Type },
		-- CTagsClass { Type },
		-- CTagsMethod { Identifier },
		-- CTagsSingleton { Identifier },

		-- javascriptFuncName { Type },
		-- -- jsFuncCall { jsFuncName },
		-- javascriptFunction { Statement },
		-- javascriptThis { Statement },
		-- javascriptParens { Normal },
		-- -- jOperators { javascriptStringD },
		-- jId { Title },
		-- jClass { Title },
		--
		-- -- " Javascript language support
		-- javascriptJGlobalMethod { Statement },

		-- " Make the braces and other noisy things slightly less noisy
		-- hi! jsParens guifg=#005F78 cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
		-- jsParens { fg = "#005F78" },
		-- jsFuncParens { jsParens },
		-- jsFuncBraces { jsParens },
		-- jsBraces { jsParens },
		-- jsNoise { jsParens },

		-- Solarized separators are a little garish.
		-- This moves separators, comments, and normal
		-- text into the same color family as the background.
		-- Using the http://drpeterjones.com/colorcalc/,
		-- they are now just differently saturated and
		-- valued riffs on the background color, making
		-- everything play together just a little more nicely.
		--
		-- VertSplit { fg = "#003745" },
		EasyMotionTarget { fg = "#4CE660", gui = s.b },

		-- diff highlighting
		diffAdded { Statement },
		diffLine { Identifier },

		-- git and gitcommit
		gitcommitComment { fg = clrs.base01, gui = s.i },
		gicommitUntracked { gitcommitComment },
		gicommitDiscarded { gitcommitComment },
		gicommitSelected { gitcommitComment },
		gitcommitUnmerged { fg = clrs.green, gui = s.b },
		gitcommitOnBranch { fg = clrs.base01, gui = s.b },
		gitcommitBranch { fg = clrs.magenta, gui = s.b },
		gitcommitNoBranch { gitcommitBranch },
		gitcommitDiscardedType { fg = clrs.red },
		gitcommitSelectedType { fg = clrs.green },
		gitcommitHeader { fg = clrs.base01 },
		gitcommitUntrackedFile { fg = clrs.cyan, gui = s.b },
		gitcommitDiscardedFile { fg = clrs.red, gui = s.b },
		gitcommitSelectedFile { fg = clrs.green, gui = s.b },
		gitcommitUnmergedFile { fg = clrs.yellow, gui = s.b },
		gitcommitFile { fg = clrs.base0, gui = s.b },
		gitcommitDiscardedArrow { gitcommitDiscardedFile },
		gitcommitSelectedArrow { gitcommitSelectedFile },
		gitcommitUnmergedArrow { gitcommitUnmergedFile },

		-- gitgutter
		GitGutterAdd { fg = clrs.green },
		GitGutterChange { fg = clrs.yellow },
		GitGutterDelete { fg = clrs.red },
		GitGutterChangeDelete { fg = clrs.red },

		--
		-- octo
		OctoGreen { fg = clrs.green },
		OctoRed { fg = clrs.red },
		OctoPurple { fg = clrs.violet },
		OctoYellow { fg = clrs.yellow },
		OctoBlue { fg = clrs.blue },
		OctoGrey { fg = clrs.base0 },

		OctoBubbleGreen { fg = clrs.green, bg = clrs.green.darken(75) },
		OctoBubbleRed { fg = clrs.red, bg = clrs.red.darken(80) },
		OctoBubblePurple { fg = clrs.base2, bg = clrs.violet },
		OctoBubbleYellow { fg = clrs.yellow, bg = clrs.yellow.darken(75) },
		OctoBubbleBlue { fg = clrs.blue, bg = clrs.blue.darken(75) },

		-- Bubble delimiters are hiding here
		OctoBubbleDelimiterGreen { fg = OctoBubbleGreen.bg },
		OctoBubbleDelimiterRed { fg = OctoBubbleRed.bg },
		OctoBubbleDelimiterYellow { fg = OctoBubbleYellow.bg },
		OctoBubbleDelimiterBlue { fg = OctoBubbleBlue.bg },

		OctoFilePanelTitle { fg = Directory.fg, gui = s.b },
		OctoFilePanelCounter { fg = Identifier.fg, gui = s.b },
		OctoNormalFront { fg = Normal.fg },
		OctoViewer { fg = clrs.base03, bg = clrs.blue },

		-- Telescope
		TelescopeNormal { Normal, bg = Normal.bg.darken(13) },
		TelescopeBorder { TelescopeNormal, fg = clrs.base01 },
		TelescopeMatching { Title },
		TelescopeTitle { Normal, gui = "bold" },

		TelescopePreviewTitle { fg = clrs.cyan, bg = TelescopeNormal.bg, gui = s.i },

		TelescopePromptNormal { Normal, bg = Normal.bg.darken(2) },
		TelescopePromptPrefix { Statement, bg = TelescopePromptNormal.bg },
		TelescopePromptBorder { fg = s.none, bg = TelescopePromptNormal.bg },
		TelescopePromptTitle { fg = clrs.blue, bg = TelescopePromptNormal.bg, gui = s.i },

		TelescopeSelection { Visual, bg = TelescopeNormal.bg },
		TelescopeSelectionCaret { TelescopeSelection, fg = clrs.base1 },
		-- TelescopeResultsTitle { },

		-- TelescopeMultiSelection {},

		CmpItemAbbr { fg = clrs.base1, bg = s.none },
		CmpItemAbbrDeprecated { fg = clrs.base0, bg = s.none, strikethrough = true },
		CmpItemAbbrMatch { fg = clrs.blue, bg = s.none, bold = true },
		CmpItemAbbrMatchFuzzy { CmpItemAbbrMatch },
		CmpItemMenu { fg = clrs.base1, bg = s.none, italic = true },

		CmpItemKindField { Identifier },
		CmpItemKindProperty { CmpItemKindField },
		CmpItemKindEvent { CmpItemKindField },
		CmpItemKindEnumMember { Identifier },

		CmpItemKindText { Statement },
		CmpItemKindEnum { Statement },
		CmpItemKindKeyword { Statement },
		CmpItemKindOperator { Statement },

		CmpItemKindConstant { Constant },
		CmpItemKindConstructor { Constant },
		CmpItemKindReference { Constant },
		CmpItemKindValue { Constant },

		CmpItemKindStruct { Type },
		CmpItemKindClass { Type },
		CmpItemKindModule { Type },
		CmpItemKindInterface { Type },
		CmpItemKindTypeParameter { Type },

		CmpItemKindUnit { Macro },
		CmpItemKindSnippet { Macro },
		CmpItemKindFolder { Macro },
		CmpItemKindFile { Macro },

		CmpItemKindVariable { Function },
		CmpItemKindFunction { Function },
		CmpItemKindMethod { Function },

		CmpItemKindColor { Special },
	}
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
