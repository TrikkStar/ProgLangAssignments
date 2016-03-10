%{
  open Types
%}

%token <float> FLOAT
%token TRUE FALSE
%token DBLSEMI
%token IF THEN ELSE
%token OR
%token AND
%token NOT

%nonassoc FLOAT
%nonassoc ELSE
%nonassoc OR AND
%nonassoc NOT

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
  | IF expr THEN expr ELSE expr  { IfS ($2, $4, $6) }
  | expr OR expr                 { OrS ($1, $3) }
  | expr AND expr                { AndS ($1, $3) }
  | NOT expr                     { NotS $2 }
;

