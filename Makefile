ENGINE=lualatex

.PHONY: all clean

all: eca2019proceedings-vol-1.pdf eca2019proceedings-vol-2.pdf eca2019proceedings-vol-3.pdf

clean:
	rm -f *.idx *.ilg *.ind *.log *.aux *.toc eca2019proceedings-vol-?.pdf papers-vol-?-with-names.tex

%-with-names.tex: %.tex authors.py
	python3 authors.py < $< > $@

eca2019proceedings-%.pdf: eca2019proceedings-%.tex papers-%-with-names.tex preface.tex layout/cover-%.pdf
	$(ENGINE) $<
	$(ENGINE) $< # for TOC and bookmarks

