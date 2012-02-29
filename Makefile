.PHONY: all fetch conv2sfd patch preparedist clean distclean
DIRS=devanagari bengali gurmukhi gujarati oriya tamil telugu kannada malayalam
FETCHDOCS=COPYING.txt
README=README
CHANGELOG=ChangeLog
include common/vars.mk
DISTFILE=$(DISTDIR).tar.xz

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

preparedist: all $(DISTDIR) $(DISTDIR)/$(FETCHDOCS) $(DISTDIR)/$(README) $(DISTDIR)/$(CHANGELOG)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done
$(DISTDIR):
	-mkdir $(DISTDIR)
$(DISTDIR)/$(FETCHDOCS): $(FETCHDOCS)
	cp $^ $@
$(DISTDIR)/$(README): $(README)
	cp $^ $@
$(DISTDIR)/$(CHANGELOG): $(CHANGELOG)
	cp $^ $@

dist: preparedist $(DISTFILE)
$(DISTFILE): $(DISTDIR)
	tar cfvJ $@ $<

clean:
	-rm -rf $(DISTFILE) $(DISTDIR) *~ */*~
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

distclean: clean
	-rm $(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done
