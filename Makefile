DESTDIR=${HOME}

dummy:

docs:
	./run -m > README.md

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
	install run-util $(DESTDIR)/bin
