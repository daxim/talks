JAR = antlr-4.7-complete.jar
CLASSPATH := .:$(JAR):$(CLASSPATH)
export CLASSPATH

GRAMMAR ?= Hello
INPUT ?= 'hello world'

help:
	@echo make all
	@echo make js INPUT=\'hello you\'
	@echo make tree
	@echo make tree INPUT=\'hello you\'
	@echo make tree INPUT=invalid
	@echo make gui
	@echo make all GRAMMAR=Flail

clean:
	rm -f *.class *.java *.tokens *{Lexer,Listener,Parser}.js

realclean:
	rm -rf node_modules package-lock.json $(JAR)

all: java js

js: $(GRAMMAR)Parser.js
	node $(GRAMMAR).js '$(INPUT)'

$(GRAMMAR)Parser.js: $(GRAMMAR).g4
	java -Xmx500M org.antlr.v4.Tool -Dlanguage=JavaScript $(GRAMMAR).g4

java: $(GRAMMAR)Parser.class

$(GRAMMAR)Parser.class: $(GRAMMAR)Parser.java
	javac *.java

$(GRAMMAR)Parser.java: $(GRAMMAR).g4
	java -Xmx500M org.antlr.v4.Tool $(GRAMMAR).g4

tree: java
	echo -n $(INPUT) | java org.antlr.v4.gui.TestRig $(GRAMMAR) r -tree

gui: java
	echo -n $(INPUT) | java org.antlr.v4.gui.TestRig $(GRAMMAR) r -gui

deps:
	wget http://www.antlr.org/download/$(JAR)
	npm install antlr4
