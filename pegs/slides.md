!SLIDE title-slide
# Parse #
# Interpret/Compile #
# ??? #
# Profit #

!SLIDE title-slide
# about me #

!SLIDE bullets 
* eBay Local, Milo
* (Release | Quality) > Engineering
* Platform > (Tooling | Maintenance)
* dkarapetyan@ebay.com
* github/MiloReleaseEngineering

!SLIDE title-slide incremental bullets
# Agenda #
* PEGs (Parsing Expresison Grammars)
* Definitions
* Examples

!SLIDE title-slide incremental
# PEGs #
* Language for describing formal languages
* Like regular expressions but better
* Easy to understand (no shift/reduce errors)
* No lexical analysis step required

!SLIDE title-slide incremental
# Definitions #
* sequence: e1 > e2
* alternate: e1 | e2
* repeat, option: e.many, e.any
* name: e[:name]
* semantic action: e >> ->(s) { #code }

!SLIDE title-slide incremental
# Examples #
* one_of(/[0-9]/).many
* m('bibek') | m('mikael') | m('mark').any
* one_of(/[0-9]/)[:d] >> ->(s) { [s[:d][0].text] }
* r(:digit) > r(:letter) > wildcard

!SLIDE title-slide bullets
# Examples (cont.) #
* simple lisp (github.com/davidk01/peglisp)
* another simple lisp (github.com/markrwilliams/parslisp)

!SLIDE title-slide bullets
# tools using PEGs #
* github/MiloReleaseEngineering/FTW
* github/MiloReleaseEngineering/openstratus-api-toolkit

!SLIDE title-slide
# Questions #
