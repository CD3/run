DESTDIR=${HOME}

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
