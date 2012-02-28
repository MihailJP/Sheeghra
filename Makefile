.PHONY:fetch conv2sfd clean
DIRS=devanagari bengali gurmukhi gujarati oriya tamil telugu kannada malayalam
FETCHDOCS=COPYING.txt

fetch:
	wget http://www.cdacmumbai.in/projects/indix/RaghuFonts/$(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

conv2sfd:
	for i in $(DIRS);do cd $$i; make $@; cd ..; done

clean:
	-rm $(FETCHDOCS)
	for i in $(DIRS);do cd $$i; make $@; cd ..; done
