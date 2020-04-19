ENGINE=lualatex

.PHONY: all clean open

all: eca2019proceedings-vol-1.pdf eca2019proceedings-vol-2.pdf

clean:
	rm -f *.idx *.ilg *.ind *.log *.aux *.toc eca2019proceedings-vol-?.pdf papers-vol-?-with-names.tex

open: eca2019proceedings.pdf
	open eca2019proceedings.pdf

%-with-names.tex: %.tex authors.py
	python3 authors.py < $< > $@

eca2019proceedings-vol-1.pdf: eca2019proceedings-vol-1.tex papers-vol-1-with-names.tex preface.tex layout/cover-vol-1.pdf
	$(ENGINE) eca2019proceedings-vol-1.tex
	$(ENGINE) eca2019proceedings-vol-1.tex # for TOC and bookmarks

eca2019proceedings-vol-2.pdf: eca2019proceedings-vol-2.tex papers-vol-2-with-names.tex preface.tex layout/cover-vol-2.pdf
	$(ENGINE) eca2019proceedings-vol-2.tex
	$(ENGINE) eca2019proceedings-vol-2.tex # for TOC and bookmarks
