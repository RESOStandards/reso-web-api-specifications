lexer grammar rcp019Lexer;

CONCAT: PIPE;
LPAREN: '(';
RPAREN: ')';
SQUOTE: '\'';
QUOTE: '"';
DOT: '.';
ASTERISK: '*';
SLASH: '/';
EXCLAMATION: '!';
DOLLAR: '$';
CARET: '^';
BACKSLASH: '\\';
SINGLE_SPACE: ' ';

OR: '.OR.';
AND: '.AND.';
NOT: '.NOT.';

EQ: '=';
NE: EXCLAMATION EQ;
LT: '<';
LTE: LT EQ;
GT: '>';
GTE: GT EQ;

CONTAINS: '.CONTAINS.';
IN: '.IN.';
COMMA: ',';
PLUS: '+';
MINUS: '-';
MOD: '.MOD.';
PIPE: '|';
LBRACKET: '[';
RBRACKET: ']';
HASH: '#';

IIF: 'IIF';
LAST: 'LAST';
LIST: 'LIST';
SET: 'SET';
DIFFERENCE: 'DIFFERENCE';
INTERSECTION: 'INTERSECTION';
UNION: 'UNION';
TRUE: 'TRUE';
FALSE: 'FALSE';
EMPTY: 'EMPTY';
TODAY: 'TODAY';
NOW: 'NOW';
ENTRY: 'ENTRY';
OLDVALUE: 'OLDVALUE';
USERID: 'USERID';
USERCLASS: 'USERCLASS';
USERLEVEL: 'USERLEVEL';
AGENTCODE: 'AGENTCODE';
BROKERCODE: 'BROKERCODE';
BROKERBRANCH: 'BROKERBRANCH';
UPDATEACTION: 'UPDATEACTION';
ANY: 'any';

// special tokens
RESO_SPECIAL_TOKENS: FIELD_NAME | SPECOP;

// TODO: dynamically fill in your FIELD_NAMEs here
FIELD_NAME:
	'ListPrice'
	| 'Status'
	| 'CloseDate'
	| 'Bedrooms'
	| 'Bathrooms';

SPECFUNC: IIF;

SPECOP:
	EMPTY
	| TRUE
	| FALSE
	| TODAY
	| NOW
	| ENTRY
	| OLDVALUE
	| USERID
	| USERCLASS
	| USERLEVEL
	| AGENTCODE
	| BROKERCODE
	| BROKERBRANCH
	| UPDATEACTION
	| ANY;

ISO_TIMESTAMP: '##TODO##';
ISO_DATE: '#TODO#';

ALPHA: ('a' ..'z' | 'A' ..'Z');
DIGIT: ('0' ..'9');

ALPHANUM: ALPHA (ALPHA | DIGIT)*;

QUOTED_TERM: QUOTE (~[\\"])*? QUOTE | SQUOTE (~[\\'])*? SQUOTE;

//added support for c++ style comments
SLASH_STAR_COMMENT: '/*' .+? '*/' -> skip;
SLASH_SLASH_COMMENT: '//' .+? ('\n' | EOF) -> skip;

WS: [ \t\n\r]+ -> skip;