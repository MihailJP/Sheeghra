.PHONY: all fetch conv2sfd patch clean distclean
DIRS=devanagari bengali gurmukhi gujarati oriya tamil telugu kannada malayalam
FETCHDOCS=COPYING.txt

all: patch
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

fetch: $(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

$(FETCHDOCS):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(FETCHDOCS)

conv2sfd: fetch
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

patch: conv2sfd
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

clean:
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

distclean: clean
	-rm $(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done
