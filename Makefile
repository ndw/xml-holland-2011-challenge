EPUB=book.epub
XPROC=calabash
EPUBCHECK=/usr/local/epubcheck-1.2/epubcheck-1.2.jar
ENDNOTES=0

all: epubcheck

epub: setup
	rm -f epub/doc/*.html
	$(XPROC) -isource=Millioenenstudien/mult001mill01_01.xml tei2epub.xpl endnotes=$(ENDNOTES)

epubcheck: epub
	rm -f $(EPUB)
	cd epub && zip -q0X ../$(EPUB) mimetype && zip -qXr9D ../$(EPUB) *
	java -jar $(EPUBCHECK) $(EPUB)

setup:
	mkdir -p epub/doc
	cp Millioenenstudien/*.gif epub/doc/
	cp ancillary/doc.css epub/doc/

clean:
	rm -rf epub
	rm -f book.epub
