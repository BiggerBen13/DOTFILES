local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

--[
-- personal imports
--]
local tex = require("snippets.tex.utils.conditions")
local make_condition = require("luasnip.extras.conditions").make_condition
local in_bullets_cond = make_condition(tex.in_bullets)
local line_begin = require("luasnip.extras.conditions.expand").line_begin

M = {
  s({ trig = "template", name = "template", descr = "generates a preamble" },
    fmta([[
\documentclass{article}

\usepackage[a4paper, margin=2cm]{geometry}
\usepackage{mathtools, amsfonts, amsmath}
\usepackage{mdframed}
% sets the language for auto generated title (ex. Inhaltsverzeichnis)
\usepackage[german]{babel}

\author{Ben Kirschniak}
\title{<>}

\begin{document}

\maketitle

\newpage

\tableofcontents

\newpage

% ---- Start Document here! ----

<>

\end{document}
      ]], {
      i(1, "Insert Document Title"),
      i(2, "start typing here")
    })
    -- { condition = tex.in_preamble }
    )
}

return M
