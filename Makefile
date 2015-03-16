DESTDIR=/usr/local/

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
