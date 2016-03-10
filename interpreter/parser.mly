%{
  open Types
%}

%token <float> FLOAT
%token TRUE FALSE
%token DBLSEMI
%token IF THEN ELSE
%nonassoc FLOAT
%nonassoc ELSE

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
  | FALSE                        { BoolS false }
  | TRUE                         { BoolS true }
  | IF expr THEN expr ELSE expr  { IfC ($2, $4, $6) }
;

