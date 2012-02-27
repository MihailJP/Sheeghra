SRCTTF=RKRaghuHindi.ttf
SRCDOC=RKRaghuHindiReadme.txt
.PHONY: fetch clean
.SUFFIXES: .ttf .vps .sfd

fetch: $(SRCTTF) $(SRCDOC)
$(SRCTTF):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCTTF)
$(SRCDOC):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCDOC)

$(SRCTTF:.ttf=.vtp): $(SRCTTF)
	../tools/extractvtp.pl $< > $@

clean:
	-rm -rf $(SRCTTF) $(SRCDOC)
