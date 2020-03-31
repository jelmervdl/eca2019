.PHONY: all clean open

all: eca2019proceedings.pdf

clean:
	rm -f *.idx *.ilg *.ind *.log *.aux *.toc eca2019proceedings.pdf papers-with-names.tex

open: eca2019proceedings.pdf
	open eca2019proceedings.pdf

papers-with-names.tex: papers.tex authors.py
	python authors.py < papers.tex > papers-with-names.tex

eca2019proceedings.pdf: eca2019proceedings.tex papers-with-names.tex
	pdflatex ./eca2019proceedings.tex
	pdflatex ./eca2019proceedings.tex # for TOC and bookmarks

