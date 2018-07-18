include ../common/vars.mk
.PHONY: all fetch conv2sfd patch preparedist clean distclean
.SUFFIXES: .ttf .vps .sfd

all: patch $(TARGET)
$(TARGET): $(TARGET:.ttf=.sfd)
	fontforge -lang=ff -c "Open(\"$<\");Generate(\"$@\")"

fetch:
	@echo The target \`fetch\` is deprecated and does nothing.

conv2sfd: $(SRCTTF:.ttf=.sfd)
$(SRCTTF:.ttf=.vtp): $(SRCTTF)
	../tools/extractvtp.pl $< > $@
$(SRCTTF:.ttf=.sfd): $(BASETTF) $(SRCTTF:.ttf=.vtp) $(SEDSCR)
	LANG=C;../tools/conv2sfd.py $(BASETTF) $(SRCTTF:.ttf=.vtp) tmp.sfd
	cat tmp.sfd | ../tools/lookupname.pl $(SRCTTF:.ttf=.vtp) > $@
	rm tmp.sfd

patch: conv2sfd $(TARGET:.ttf=.sfd) $(PATCHFILE)
$(TARGET:.ttf=.sfd): $(PATCHFILE) $(SRCTTF:.ttf=.sfd)
	patch -o $@ < $<

preparedist: all ../$(DISTDIR)/$(TARGET) ../$(DISTDIR)/$(SRCDOC)
../$(DISTDIR)/$(TARGET): $(TARGET)
	cp $^ $@
../$(DISTDIR)/$(SRCDOC): $(SRCDOC)
	cp $^ $@

clean:
	-rm -rf $(SRCTTF:.ttf=.vtp) $(SRCTTF:.ttf=.sfd) $(TARGET) $(TARGET:.ttf=.sfd) *~

distclean: clean
	@echo The target \`distclean\` is deprecated and does nothing more than \`clean\`.
