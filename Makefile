.PHONY: watch

Site.pdf:	$(wildcard *.adoc) $(wildcard */*.adoc) identity-model.json user-model.json

%.json: %.edn
	bb -o edn2json $< > $@

%.pdf:	%.adoc
	bundle exec asciidoctor-pdf \
	-a toc=macro \
	-r asciidoctor-diagram \
	-r asciidoctor-mathematical \
	-r asciidoctor-bibtex \
	-a bibtex-file=references.bib \
	-a bibtex-throw=true \
	-a bibtex-style=apa \
	-a mathematical-format=svg \
	-a icons=font \
	-a media=prepress \
	-a pdf-style=juxt \
	-a pdf-fontsdir=fonts \
	-a pdf-style=juxt \
	-a pdf-stylesdir=themes \
	-a sectnumlevels=3 \
	-a sectnums=true \
	-a title-page=true \
	-a xrefstyle=short \
	-o $@ $<

watch:
	find . -name "*.adoc" -or -name "*.json" | entr -n make
