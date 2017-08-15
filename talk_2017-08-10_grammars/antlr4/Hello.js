'use strict';
const antlr4 = require('antlr4');
const HelloLexer = require('./HelloLexer');
const HelloParser = require('./HelloParser');
const input = process.argv[2] || 'hello world';
const chars = new antlr4.InputStream(input);
const lexer = new HelloLexer.HelloLexer(chars);
const tokens = new antlr4.CommonTokenStream(lexer);
const parser = new HelloParser.HelloParser(tokens);
parser.buildParseTrees = true;
const tree = parser.r();
// console.log({
//     antlr4, HelloLexer, HelloParser, chars, lexer, tokens, parser, tree
// });
console.log({tree});
