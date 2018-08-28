all: pdf html

mds=$(wildcard *.md)

%.pdf : %.md 
	pandoc -t beamer $< -o $@

%.html : %.md
	pandoc -t dzslides --standalone --self-contained $< -o $@


pdfs=$(mds:.md=.pdf)

html: $(mds:.md=.html)

pdf: $(pdfs)
