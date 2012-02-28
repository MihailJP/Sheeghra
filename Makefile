.PHONY: all fetch conv2sfd clean distclean
DIRS=devanagari bengali gurmukhi gujarati oriya tamil telugu kannada malayalam
FETCHDOCS=COPYING.txt

all: conv2sfd

fetch: COPYING.txt
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

COPYING.txt:
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(FETCHDOCS)

conv2sfd: fetch
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

clean:
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

distclean: clean
	-rm $(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done
