# Names
TARGET-DIR = build
SOURCE-FILE = main.tex
SOURCE-DIR = src
OUTPUT=main
OUTPUT-PDF = ${OUTPUT}.pdf
BIB=bib
LOG=pdf-latex.log

# Env
RM = rm -rf
PDFLATEX = pdflatex
PDFLATEX-ARGS = -synctex=1 -shell-escape -interaction=nonstopmode --output-directory=${TARGET-DIR}

# Builds the whole thing in a docker contaner

all:
	mkdir -p $(TARGET-DIR)
	UID=$$(id -u) GID=$$(id -g) docker-compose -f scripts/docker-compose.yaml up --force-recreate

# Builds locally without dockers

local: 
	mkdir -p $(TARGET-DIR)
	$(PDFLATEX) $(PDFLATEX-ARGS)  $(SOURCE-DIR)/$(SOURCE-FILE)
	bibtex $(TARGET-DIR)/$(OUTPUT)
	$(PDFLATEX) $(PDFLATEX-ARGS)  $(SOURCE-DIR)/$(SOURCE-FILE)
	cp $(TARGET-DIR)/$(OUTPUT-PDF) $(OUTPUT-PDF)
	$(RM) $(TARGET-DIR)
	