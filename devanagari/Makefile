SRCTTF=RKRaghuHindi.ttf
SRCDOC=RKRaghuHindiReadme.txt
.PHONY: fetch clean

fetch: $(SRCTTF) $(SRCDOC)
$(SRCTTF):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCTTF)
$(SRCDOC):
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(SRCDOC)

clean:
	-rm -rf $(SRCTTF) $(SRCDOC)
