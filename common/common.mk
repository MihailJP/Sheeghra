.PHONY: all fetch conv2sfd patch clean distclean
.SUFFIXES: .ttf .vps .sfd

all: patch

fetch: $(SRCTTF) $(BASETTF) $(SRCDOC)
$(SRCTTF):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCTTF)
$(SRCDOC):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCDOC)
$(BASETTF):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(BASETTF)

conv2sfd: fetch $(SRCTTF:.ttf=.sfd)
$(SRCTTF:.ttf=.vtp): $(SRCTTF)
	../tools/extractvtp.pl $< > $@
$(SRCTTF:.ttf=.sfd): $(BASETTF) $(SRCTTF:.ttf=.vtp) $(SEDSCR)
	LANG=C;../tools/conv2sfd.py $(BASETTF) $(SRCTTF:.ttf=.vtp) tmp.sfd
	cat tmp.sfd | ../tools/lookupname.pl $(SRCTTF:.ttf=.vtp) > $@
	rm tmp.sfd

patch: conv2sfd $(TARGET:.ttf=.sfd) $(PATCHFILE)
$(TARGET:.ttf=.sfd): $(SRCTTF:.ttf=.sfd) $(PATCHFILE)
	patch -o $@ < $(PATCHFILE)

clean:
	-rm -rf $(SRCTTF:.ttf=.vtp) $(SRCTTF:.ttf=.sfd) *~

distclean: clean
	-rm -rf $(SRCTTF) $(BASETTF) $(SRCDOC)
