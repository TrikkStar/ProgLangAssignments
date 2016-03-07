%{
  open Types
%}

%token <float> FLOAT
%token TRUE FALSE
%token DBLSEMI
%nonassoc FLOAT

%start main
%type <Types.exprS> main
%%

main:
  | headEx DBLSEMI               { $1 }
;

headEx:
  | expr                         { $1 }
;

expr:
  | FLOAT                        { NumS $1 }
  | FALSE                        { BoolS }
  | TRUE                         { BoolS }
;

