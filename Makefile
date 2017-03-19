DESTDIR=${HOME}

docs:
	podselect run > README.md
	podselect -section LICENSE run > LICENSE.md

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
	install run-util $(DESTDIR)/bin
