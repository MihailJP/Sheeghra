SRCTTF=RKRaghuHindi.ttf
SRCDOC=RKRaghuHindiReadme.txt
.PHONY: fetch conv2sfd clean
.SUFFIXES: .ttf .vps .sfd

fetch: $(SRCTTF) $(SRCDOC)
$(SRCTTF):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCTTF)
$(SRCDOC):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCDOC)

conv2sfd: $(SRCTTF:.ttf=.sfd)
$(SRCTTF:.ttf=.vtp): $(SRCTTF)
	../tools/extractvtp.pl $< > $@
$(SRCTTF:.ttf=.sfd): $(SRCTTF) $(SRCTTF:.ttf=.vtp)
	LANG=C;../tools/conv2sfd.py $^ > $@

clean:
	-rm -rf $(SRCTTF) $(SRCDOC) $(SRCTTF:.ttf=.vtp) $(SRCTTF:.ttf=.sfd)
