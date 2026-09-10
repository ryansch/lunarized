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
		EndOfBuffer { fg = p.back }, -- filler lines (~) after the end of the buffer; hidden
		TermCursor { Cursor }, -- cursor in a focused terminal
		ErrorMsg { fg = clrs.red, gui = s.r }, -- error messages on the command line
		WinSeparator { fg = clrs.base01 }, -- separators between window splits (0.7+; VertSplit is the legacy name)
		VertSplit { WinSeparator },
		Folded { fg = clrs.base0, bg = clrs.base02, sp = clrs.base03, gui = s.b }, -- line used for closed folds
		FoldColumn { fg = clrs.base0, bg = clrs.base02 }, -- 'foldcolumn'
		SignColumn { fg = clrs.base0 }, -- column where |signs| are displayed
		IncSearch { fg = clrs.orange, gui = s.s }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		CurSearch { fg = clrs.base03, bg = clrs.orange }, -- current match for the last search pattern
		LineNr { fg = "#004C60", bg = clrs.base03, gui = s.b },
		CursorLineNr { CursorLine }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		-- Brackets are already red and CursorLine is already base02, so the match needs a base01 block behind it (the original Solarized value).
		MatchParen { fg = clrs.red, bg = clrs.base01, gui = s.b }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg { fg = clrs.blue }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea      { }, -- Area for messages and cmdline
		MsgSeparator { fg = clrs.base01, bg = clrs.base02 }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg { fg = clrs.blue }, -- |more-prompt|
		NonText { fg = clrs.base00, bg = s.none, gui = s.b }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal { fg = clrs.base0, bg = p.back, gui = s.none }, -- normal text
		NormalFloat { Normal, bg = Normal.bg.darken(13) }, -- Normal text in floating windows; slightly darker than the buffer so popups separate from it.
		FloatBorder { NormalFloat, fg = clrs.base01 }, -- border of floating windows
		FloatTitle { NormalFloat, fg = clrs.blue, gui = s.b }, -- title of floating windows
		FloatFooter { NormalFloat, fg = clrs.base01 }, -- footer of floating windows
		NormalNC { Normal }, -- normal text in non-current windows
		Pmenu { NormalFloat }, -- Popup menu: normal item.
		PmenuSel { fg = clrs.base01, bg = clrs.base2, gui = p.revbb }, -- Popup menu: selected item.
		PmenuKind { Pmenu, fg = clrs.cyan }, -- Popup menu: kind column
		PmenuKindSel { PmenuSel }, -- Popup menu: kind column, selected item
		PmenuExtra { Pmenu, fg = clrs.base01 }, -- Popup menu: extra text (source, detail)
		PmenuExtraSel { PmenuSel }, -- Popup menu: extra text, selected item
		PmenuMatch { Pmenu, fg = clrs.blue, gui = s.b }, -- Popup menu: matched text
		PmenuMatchSel { PmenuSel, gui = s.b }, -- Popup menu: matched text, selected item
		PmenuSbar { fg = clrs.base2, bg = clrs.base0, gui = p.revbb }, -- Popup menu: scrollbar.
		PmenuThumb { fg = clrs.base0, bg = clrs.base03, gui = p.revbb }, -- Popup menu: Thumb of the scrollbar.
		Question { fg = clrs.cyan, gui = s.b }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine { bg = clrs.base02, gui = s.b }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search { fg = clrs.yellow, gui = s.s }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		Substitute { Search }, -- |:substitute| replacement text highlighting
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
		Whitespace { fg = clrs.base02 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		WildMenu { fg = clrs.base2, bg = clrs.base02, gui = p.revbb }, -- current match in 'wildmenu' completion
		WinBar { fg = clrs.base1, bg = p.back }, -- window bar of current window
		WinBarNC { fg = clrs.base01, bg = p.back }, -- window bar of not-current windows
		StatusLineTerm { StatusLine }, -- status line of current terminal window
		StatusLineTermNC { StatusLineNC }, -- status line of not-current terminal windows
		OkMsg { fg = clrs.green }, -- success messages
		DiffTextAdd { DiffAdd }, -- added text within a changed line
		Added { fg = clrs.green }, -- added line in a diff (0.10+); many plugins fall back to these three
		Changed { fg = clrs.yellow }, -- changed line in a diff
		Removed { fg = clrs.red }, -- removed line in a diff
		debugPC { bg = clrs.base02 }, -- current line while debugging (nvim-dap DapStopped linehl)
		debugBreakpoint { fg = clrs.red, bg = clrs.base02 }, -- breakpoint line
		SnippetTabstop { bg = clrs.base01.darken(35) }, -- tabstops in snippets; same lift as LspReferenceText since they sit on the cursor line

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
		DiagnosticOk { fg = clrs.green }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

		-- Virtual text gets a faint tint of its own color so plugins that use these
		-- groups as badges (snacks, noice, dap-virtual-text) read as pills.
		DiagnosticVirtualTextError { fg = clrs.red, bg = clrs.red.darken(75) }, -- Used for "Error" diagnostic virtual text
		DiagnosticVirtualTextWarn { fg = clrs.yellow, bg = clrs.yellow.darken(75) }, -- Used for "Warning" diagnostic virtual text
		DiagnosticVirtualTextInfo { fg = clrs.cyan, bg = clrs.cyan.darken(75) }, -- Used for "Information" diagnostic virtual text
		DiagnosticVirtualTextHint { fg = clrs.green, bg = clrs.green.darken(75) }, -- Used for "Hint" diagnostic virtual text
		DiagnosticVirtualTextOk { fg = clrs.green, bg = clrs.green.darken(75) }, -- Used for "Ok" diagnostic virtual text

		DiagnosticUnderlineError { sp = clrs.red, gui = s.c }, -- Used to underline "Error" diagnostics
		DiagnosticUnderlineWarn { sp = clrs.yellow, gui = s.c }, -- Used to underline "Warning" diagnostics
		DiagnosticUnderlineInfo { sp = clrs.cyan, gui = s.c }, -- Used to underline "Information" diagnostics
		DiagnosticUnderlineHint { sp = clrs.green, gui = s.c }, -- Used to underline "Hint" diagnostics
		DiagnosticUnderlineOk { sp = clrs.green, gui = s.c }, -- Used to underline "Ok" diagnostics

		DiagnosticDeprecated { sp = clrs.red, gui = "strikethrough" }, -- deprecated code
		-- DiagnosticUnnecessary links to Comment by default, which is fine here.

		-- Two steps above CursorLine (base02) so the highlight survives on the cursor's own row.
		LspReferenceText { bg = clrs.base01.darken(35) }, -- references under the cursor (document highlight)
		LspReferenceRead { LspReferenceText }, -- read-access references
		LspReferenceWrite { LspReferenceText, gui = s.u }, -- write-access references
		LspReferenceTarget { LspReferenceText }, -- the reference the cursor is on
		LspInlayHint { fg = clrs.base01, gui = s.i }, -- inlay hints
		LspCodeLens { fg = clrs.base01, gui = s.i }, -- virtual text of code lenses
		LspCodeLensSeparator { LspCodeLens }, -- separator between two or more code lenses
		LspSignatureActiveParameter { fg = clrs.orange, gui = s.b }, -- active parameter in signature help

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
		sym("@variable.parameter.builtin") { Special }, -- special parameters (e.g. `_`, `it`)
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
		sym("@string.special.symbol") { fg = clrs.violet }, -- symbols or atoms; violet so they read apart from strings (cyan) and identifiers (blue)
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

		sym("@attribute") { Identifier }, -- attribute annotations (e.g. Python decorators)
		sym("@attribute.builtin") { Special }, -- builtin annotations (e.g. `@property` in Python)
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
		sym("@keyword.modifier") { StorageClass }, -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
		sym("@keyword.type") { Keyword }, -- keywords describing composite types (e.g. `struct`, `enum`)
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
		sym("@comment.note") { DiagnosticHint }, -- note-type comments (e.g., `NOTE:`, `INFO:`)
		sym("@comment.todo") { Todo }, -- todo-type comments (e.g-, `TODO:`, `WIP:`)

		-- Markup
		sym("@markup.strong") { Bold }, -- bold text
		sym("@markup.italic") { Italic }, -- text with emphasis
		sym("@markup.strikethrough") { Strike }, -- strikethrough text
		sym("@markup.underline") { Underlined }, -- underlined text (only for literal underline markup!)

		sym("@markup.heading") { Title }, -- headings, titles (including markers)
		sym("@markup.heading.1") { fg = clrs.orange, gui = s.b }, -- top-level heading
		sym("@markup.heading.2") { fg = clrs.yellow, gui = s.b }, -- section heading
		sym("@markup.heading.3") { fg = clrs.green, gui = s.b }, -- subsection heading
		sym("@markup.heading.4") { fg = clrs.cyan, gui = s.b }, -- and so on
		sym("@markup.heading.5") { fg = clrs.blue, gui = s.b }, -- and so forth
		sym("@markup.heading.6") { fg = clrs.violet, gui = s.b }, -- six levels ought to be enough for anybody

		sym("@markup.quote") { Constant }, -- block quotes
		sym("@markup.math") { Special }, -- math environments (e.g. `$ ... $` in LaTeX)

		sym("@markup.link") { PreProc }, -- text references, footnotes, citations, etc.
		sym("@markup.link.label") { sym("@markup.link") }, -- non-url links
		sym("@markup.link.url") { Underlined }, -- url links in markup

		sym("@markup.raw") { Constant }, -- literal or verbatim text (e.g., inline code)
		sym("@markup.raw.block") { sym("@markup.raw") }, -- literal or verbatim text as a stand-alone block

		sym("@markup.list") { SpecialChar }, -- list markers
		sym("@markup.list.checked") { fg = clrs.green }, -- checked todo-style list markers
		sym("@markup.list.unchecked") { fg = clrs.base01 }, -- unchecked todo-style list markers

		sym("@diff.plus") { DiffAdd }, -- added text (for diff files)
		sym("@diff.minus") { DiffDelete }, -- deleted text (for diff files)
		sym("@diff.delta") { DiffChange },

		sym("@tag") { Tag }, -- XML tag names
		sym("@tag.builtin") { Special }, -- builtin tag names (e.g. HTML5 tags)
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
		sym("@lsp.type.event") { Identifier },
		sym("@lsp.type.keyword") { sym("@keyword") },
		sym("@lsp.type.modifier") { sym("@keyword.modifier") },
		sym("@lsp.type.number") { sym("@number") },
		sym("@lsp.type.operator") { sym("@operator") },
		sym("@lsp.type.regexp") { sym("@string.regexp") },
		sym("@lsp.type.string") { sym("@string") },

		-- Modifiers apply on top of the type; only the ones that add information
		-- beyond what treesitter already conveys.
		sym("@lsp.mod.deprecated") { gui = "strikethrough" },
		sym("@lsp.mod.readonly") { Constant },

		-- Language Specific
		-- ruby

		qfLineNr { LineNr },
		qfFileName { Directory },

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

		-- diff highlighting
		diffAdded { Statement },
		diffLine { Identifier },

		-- git and gitcommit
		gitcommitComment { fg = clrs.base01, gui = s.i },
		gitcommitUntracked { gitcommitComment },
		gitcommitDiscarded { gitcommitComment },
		gitcommitSelected { gitcommitComment },
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

		--
		-- Plugins
		--

		-- gitsigns.nvim
		-- The GitGutter* names stay as aliases: gitsigns and neo-tree probe them
		-- as fallbacks before the GitSigns* names.
		GitSignsAdd { fg = clrs.green },
		GitSignsChange { fg = clrs.yellow },
		GitSignsDelete { fg = clrs.red },
		GitSignsChangedelete { GitSignsDelete },
		GitSignsTopdelete { GitSignsDelete },
		GitSignsUntracked { fg = clrs.cyan },
		GitSignsCurrentLineBlame { fg = clrs.base01, gui = s.i },
		-- word-diff regions default to TermCursor (reverse video); use tints instead
		GitSignsAddInline { bg = clrs.green.darken(65) },
		GitSignsChangeInline { bg = clrs.yellow.darken(65) },
		GitSignsDeleteInline { bg = clrs.red.darken(65) },
		GitGutterAdd { GitSignsAdd },
		GitGutterChange { GitSignsChange },
		GitGutterDelete { GitSignsDelete },
		GitGutterChangeDelete { GitSignsChangedelete },

		-- blink.cmp
		BlinkCmpLabelMatch { fg = clrs.blue, gui = s.b },
		BlinkCmpLabelDeprecated { fg = clrs.base0, gui = "strikethrough" },
		BlinkCmpLabelDetail { fg = clrs.base01, gui = s.i },
		BlinkCmpLabelDescription { BlinkCmpLabelDetail },
		BlinkCmpSource { BlinkCmpLabelDetail },
		BlinkCmpMenuBorder { Pmenu, fg = clrs.base01 },
		BlinkCmpDocBorder { FloatBorder },
		BlinkCmpSignatureHelpBorder { FloatBorder },

		BlinkCmpKindField { Identifier },
		BlinkCmpKindProperty { BlinkCmpKindField },
		BlinkCmpKindEvent { BlinkCmpKindField },
		BlinkCmpKindEnumMember { Identifier },

		BlinkCmpKindText { Statement },
		BlinkCmpKindEnum { Statement },
		BlinkCmpKindKeyword { Statement },
		BlinkCmpKindOperator { Statement },

		BlinkCmpKindConstant { Constant },
		BlinkCmpKindConstructor { Constant },
		BlinkCmpKindReference { Constant },
		BlinkCmpKindValue { Constant },

		BlinkCmpKindStruct { Type },
		BlinkCmpKindClass { Type },
		BlinkCmpKindModule { Type },
		BlinkCmpKindInterface { Type },
		BlinkCmpKindTypeParameter { Type },

		BlinkCmpKindUnit { Macro },
		BlinkCmpKindSnippet { Macro },
		BlinkCmpKindFolder { Macro },
		BlinkCmpKindFile { Macro },

		BlinkCmpKindVariable { Function },
		BlinkCmpKindFunction { Function },
		BlinkCmpKindMethod { Function },

		BlinkCmpKindColor { Special },

		-- snacks.nvim picker (ported from the old Telescope look)
		SnacksPicker { NormalFloat },
		SnacksPickerBorder { FloatBorder },
		SnacksPickerTitle { NormalFloat, fg = clrs.base1, gui = s.b },
		SnacksPickerFooter { FloatFooter },
		SnacksPickerMatch { Title },

		SnacksPickerInput { Normal, bg = Normal.bg.darken(2) },
		SnacksPickerInputBorder { SnacksPickerInput, fg = clrs.base01 },
		SnacksPickerInputTitle { SnacksPickerInput, fg = clrs.blue, gui = s.i },
		SnacksPickerInputFooter { SnacksPickerInputBorder },
		SnacksPickerPrompt { Statement, bg = SnacksPickerInput.bg },

		SnacksPickerList { SnacksPicker },
		SnacksPickerListBorder { SnacksPickerBorder },
		SnacksPickerListTitle { SnacksPickerTitle },
		SnacksPickerListCursorLine { bg = clrs.base02 }, -- defaults to Visual (reverse video)

		SnacksPickerPreview { SnacksPicker },
		SnacksPickerPreviewBorder { SnacksPickerBorder },
		SnacksPickerPreviewTitle { SnacksPicker, fg = clrs.cyan, gui = s.i },
		SnacksPickerPreviewCursorLine { CursorLine },

		SnacksPickerBox { SnacksPicker },
		SnacksPickerBoxBorder { SnacksPickerBorder },
		SnacksPickerBoxTitle { SnacksPickerTitle },

		-- snacks.nvim indent guides (defaults are bold NonText and a red scope line)
		SnacksIndent { fg = clrs.base02 },
		SnacksIndentScope { fg = clrs.base01 },
		SnacksIndentChunk { SnacksIndentScope },

		-- snacks.nvim gh picker (defaults are GitHub's web palette)
		SnacksGhGreen { fg = clrs.green },
		SnacksGhPurple { fg = clrs.violet },
		SnacksGhGray { fg = clrs.base01 },
		SnacksGhRed { fg = clrs.red },

		-- flash.nvim
		FlashLabel { fg = clrs.base03, bg = clrs.magenta, gui = s.b },

		-- neo-tree.nvim (overrides its hardcoded grays and oranges)
		NeoTreeDotfile { fg = clrs.base01 },
		NeoTreeHiddenByName { NeoTreeDotfile },
		NeoTreeWindowsHidden { NeoTreeDotfile },
		NeoTreeGitIgnored { NeoTreeDotfile },
		NeoTreeGitConflict { fg = clrs.orange, gui = s.b },
		NeoTreeGitUnstaged { NeoTreeGitConflict },
		NeoTreeGitUntracked { fg = clrs.cyan, gui = s.i },
		NeoTreeModified { fg = clrs.yellow },
		NeoTreeRootName { fg = clrs.blue, gui = s.b },
		NeoTreeFloatTitle { FloatTitle },
		NeoTreeTitleBar { fg = clrs.base03, bg = clrs.blue },
		NeoTreeTabActive { fg = clrs.base1, bg = p.back, gui = s.b },
		NeoTreeTabInactive { fg = clrs.base01, bg = clrs.base02 },
		NeoTreeTabSeparatorActive { fg = clrs.base02, bg = p.back },
		NeoTreeTabSeparatorInactive { fg = clrs.base03, bg = clrs.base02 },

		-- mason.nvim (every default is hardcoded gold and teal)
		MasonBackdrop { bg = clrs.base03 },
		MasonHeader { fg = clrs.base03, bg = clrs.yellow, gui = s.b },
		MasonHeaderSecondary { fg = clrs.base03, bg = clrs.cyan, gui = s.b },
		MasonHighlight { fg = clrs.cyan },
		MasonHighlightBlock { fg = clrs.base03, bg = clrs.cyan },
		MasonHighlightBlockBold { MasonHighlightBlock, gui = s.b },
		MasonHighlightSecondary { fg = clrs.yellow },
		MasonHighlightBlockSecondary { fg = clrs.base03, bg = clrs.yellow },
		MasonHighlightBlockBoldSecondary { MasonHighlightBlockSecondary, gui = s.b },
		MasonMuted { fg = clrs.base01 },
		MasonMutedBlock { fg = clrs.base03, bg = clrs.base01 },
		MasonMutedBlockBold { MasonMutedBlock, gui = s.b },

		-- neotest (every default is hardcoded)
		NeotestPassed { fg = clrs.green },
		NeotestFailed { fg = clrs.red },
		NeotestRunning { fg = clrs.yellow },
		NeotestWatching { fg = clrs.yellow },
		NeotestSkipped { fg = clrs.base01 },
		NeotestNamespace { fg = clrs.magenta },
		NeotestFile { fg = clrs.cyan },
		NeotestDir { fg = clrs.blue },
		NeotestIndent { fg = clrs.base01 },
		NeotestExpandMarker { fg = clrs.base01 },
		NeotestAdapterName { fg = clrs.violet, gui = s.b },
		NeotestWinSelect { fg = clrs.cyan, gui = s.b },
		NeotestMarked { fg = clrs.orange, gui = s.b },
		NeotestTarget { fg = clrs.red },

		-- mini.icons (which-key's icon colors follow these)
		MiniIconsAzure { fg = clrs.blue },
		MiniIconsBlue { fg = clrs.blue },
		MiniIconsCyan { fg = clrs.cyan },
		MiniIconsGreen { fg = clrs.green },
		MiniIconsGrey { fg = clrs.base01 },
		MiniIconsOrange { fg = clrs.orange },
		MiniIconsPurple { fg = clrs.violet },
		MiniIconsRed { fg = clrs.red },
		MiniIconsYellow { fg = clrs.yellow },

		-- Groups other plugins default to Visual (reverse video here)
		TroublePreview { bg = clrs.base02 },
		DapStoppedLine { debugPC },
		GrugFarVisualBufrange { bg = clrs.base02 },
		LazyButtonActive { fg = clrs.base03, bg = clrs.blue },

		-- grug-far.nvim (indicator defaults are GitHub-light hex)
		GrugFarResultsAddIndicator { fg = clrs.green },
		GrugFarResultsChangeIndicator { fg = clrs.yellow },
		GrugFarResultsRemoveIndicator { fg = clrs.red },

		-- fff.nvim (git status defaults are Tailwind hex)
		FFFGitStaged { fg = clrs.green },
		FFFGitModified { fg = clrs.yellow },
		FFFGitDeleted { fg = clrs.red },
		FFFGitRenamed { fg = clrs.violet },
		FFFGitUntracked { fg = clrs.cyan },
		FFFGitIgnored { fg = clrs.base01 },
		FFFGitSignStaged { FFFGitStaged },
		FFFGitSignModified { FFFGitModified },
		FFFGitSignDeleted { FFFGitDeleted },
		FFFGitSignRenamed { FFFGitRenamed },
		FFFGitSignUntracked { FFFGitUntracked },
		FFFGitSignIgnored { FFFGitIgnored },

		-- claudecode.nvim (inline diff defaults are One Dark hex)
		ClaudeCodeInlineDiffAdd { bg = clrs.green.darken(75) },
		ClaudeCodeInlineDiffDelete { bg = clrs.red.darken(75), gui = "strikethrough" },
		ClaudeCodeInlineDiffAddSign { fg = clrs.green },
		ClaudeCodeInlineDiffDeleteSign { fg = clrs.red },
	}
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
