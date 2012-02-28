.PHONY: all fetch conv2sfd clean distclean
.SUFFIXES: .ttf .vps .sfd

all: conv2sfd

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
	LANG=C;../tools/conv2sfd.py $(SRCTTF) $(SRCTTF:.ttf=.vtp) tmp.sfd
	cat tmp.sfd | ../tools/lookupname.pl $(SRCTTF:.ttf=.vtp) > $@
	rm tmp.sfd

clean:
	-rm -rf $(SRCTTF:.ttf=.vtp) $(SRCTTF:.ttf=.sfd) *~

distclean: clean
	-rm -rf $(SRCTTF) $(BASETTF) $(SRCDOC)
