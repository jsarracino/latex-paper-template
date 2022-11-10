FILES=*.tex *.sty
# PICS=figures/*.png
PICS=
# PICS+=figures/*.pdf

# Fill these in as needed
TARGET=paper
SITE_DIR=js3629@linux.coecis.cornell.edu:/cs/people/js3629/files/

build: $(TARGET).pdf

_build:
	mkdir -p _build

_build/$(TARGET).pdf: _build $(FILES) $(PICS)
	latexmk -interaction=nonstopmode -shell-escape -bibtex -outdir=_build -pdf $(TARGET).tex

$(TARGET).pdf: _build/$(TARGET).pdf
	cp _build/$(TARGET).pdf ./$(TARGET).pdf

clean:
	rm -f $(TARGET).pdf
	latexmk -c -outdir=_build
	latexmk -c -outdir=.

pub: $(TARGET).pdf
	rsync -avh $(TARGET).pdf $(SITE_DIR)

.PHONY: build clean
