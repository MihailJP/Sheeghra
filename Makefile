.PHONY:fetch
DIRS=devanagari

fetch:
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/COPYING.txt
	for i in $(DIRS);do cd $$i; make fetch; cd ..; done
